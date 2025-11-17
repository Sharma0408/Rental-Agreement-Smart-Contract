// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Project - Rental Agreement Smart Contract
 * @dev Automates rental deposits, monthly payments, and dispute resolution
 */
contract Project {
    
    // State variables
    address public landlord;
    address public tenant;
    address public arbitrator;
    
    uint256 public monthlyRent;
    uint256 public securityDeposit;
    uint256 public leaseStartTime;
    uint256 public leaseDuration; // in months
    
    bool public depositPaid;
    bool public leaseActive;
    
    enum DisputeStatus { None, Pending, Resolved }
    DisputeStatus public disputeStatus;
    
    mapping(uint256 => bool) public rentPaidForMonth;
    uint256 public totalMonthsPaid;
    
    // Events 
    event DepositPaid(address indexed tenant, uint256 amount, uint256 timestamp);
    event RentPaid(address indexed tenant, uint256 month, uint256 amount, uint256 timestamp);
    event DisputeRaised(address indexed initiator, uint256 timestamp);
    event DisputeResolved(uint256 tenantRefund, uint256 landlordAmount, uint256 timestamp);
    event LeaseTerminated(uint256 timestamp);
    
    // Modifiers
    modifier onlyTenant() {
        require(msg.sender == tenant, "Only tenant can call this");
        _;
    }
    
    modifier onlyLandlord() {
        require(msg.sender == landlord, "Only landlord can call this");
        _;
    }
    
    modifier onlyArbitrator() {
        require(msg.sender == arbitrator, "Only arbitrator can call this");
        _;
    }
    
    modifier leaseIsActive() {
        require(leaseActive, "Lease is not active");
        _;
    }
    
    /**
     * @dev Constructor - Initialize rental agreement
     * Landlord deploys the contract with predefined values
     */
    constructor() {
        landlord = msg.sender;
        
        // Predefined values - no input required
        tenant = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
        arbitrator = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
        
        monthlyRent = 1 ether;
        securityDeposit = 2 ether;
        leaseDuration = 12; // 12 months
        
        leaseStartTime = block.timestamp;
        leaseActive = true;
        depositPaid = false;
        disputeStatus = DisputeStatus.None;
    }
    
    /**
     * @dev CORE FUNCTION 1: Pay Security Deposit
     * Tenant pays security deposit to activate the lease
     */
    function payDeposit() external payable onlyTenant leaseIsActive {
        require(!depositPaid, "Deposit already paid");
        require(msg.value == securityDeposit, "Incorrect deposit amount");
        
        depositPaid = true;
        emit DepositPaid(msg.sender, msg.value, block.timestamp);
    }
    
    /**
     * @dev CORE FUNCTION 2: Pay Monthly Rent
     * Tenant pays monthly rent which is transferred to landlord
     */
    function payRent(uint256 monthNumber) external payable onlyTenant leaseIsActive {
        require(depositPaid, "Must pay deposit first");
        require(msg.value == monthlyRent, "Incorrect rent amount");
        require(!rentPaidForMonth[monthNumber], "Rent already paid for this month");
        require(monthNumber > 0 && monthNumber <= leaseDuration, "Invalid month number");
        
        rentPaidForMonth[monthNumber] = true;
        totalMonthsPaid++;
        
        // Transfer rent to landlord immediately
        payable(landlord).transfer(msg.value);
        
        emit RentPaid(msg.sender, monthNumber, msg.value, block.timestamp);
    }
    
    /**
     * @dev CORE FUNCTION 3: Resolve Dispute
     * Arbitrator resolves disputes and distributes security deposit fairly
     */
    function resolveDispute(uint256 tenantRefund, uint256 landlordAmount) 
        external 
        onlyArbitrator 
    {
        require(disputeStatus == DisputeStatus.Pending, "No active dispute");
        require(depositPaid, "No deposit to distribute");
        require(tenantRefund + landlordAmount <= securityDeposit, "Amounts exceed deposit");
        
        disputeStatus = DisputeStatus.Resolved;
        leaseActive = false;
        
        // Distribute security deposit based on arbitrator's decision
        if (tenantRefund > 0) {
            payable(tenant).transfer(tenantRefund);
        }
        
        if (landlordAmount > 0) {
            payable(landlord).transfer(landlordAmount);
        }
        
        // Arbitrator fee (remaining amount)
        uint256 arbitratorFee = securityDeposit - tenantRefund - landlordAmount;
        if (arbitratorFee > 0) {
            payable(arbitrator).transfer(arbitratorFee);
        }
        
        emit DisputeResolved(tenantRefund, landlordAmount, block.timestamp);
    }
    
    // Additional helper functions
    
    /**
     * @dev Raise a dispute
     */
    function raiseDispute() external {
        require(msg.sender == tenant || msg.sender == landlord, "Unauthorized");
        require(disputeStatus == DisputeStatus.None, "Dispute already exists");
        require(depositPaid, "No active lease");
        
        disputeStatus = DisputeStatus.Pending;
        emit DisputeRaised(msg.sender, block.timestamp);
    }
    
    /**
     * @dev Return deposit to tenant after successful lease completion
     */
    function returnDeposit() external {
        require(msg.sender == tenant || msg.sender == landlord, "Unauthorized");
        require(depositPaid, "No deposit to return");
        require(disputeStatus == DisputeStatus.None, "Dispute is active");
        require(block.timestamp >= leaseStartTime + (leaseDuration * 30 days), "Lease not ended");
        
        leaseActive = false;
        payable(tenant).transfer(securityDeposit);
        
        emit DisputeResolved(securityDeposit, 0, block.timestamp);
    }
    
    /**
     * @dev Terminate lease early
     */
    function terminateLease() external {
        require(msg.sender == landlord || msg.sender == tenant, "Unauthorized");
        require(leaseActive, "Lease already terminated");
        
        leaseActive = false;
        emit LeaseTerminated(block.timestamp);
    }
    
    /**
     * @dev Get contract balance
     */
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
    
    /**
     * @dev Check if specific month's rent is paid
     */
    function isRentPaidForMonth(uint256 month) external view returns (bool) {
        return rentPaidForMonth[month];
    }
    
    /**
     * @dev Get lease details
     */
    function getLeaseDetails() external view returns (
        address _landlord,
        address _tenant,
        address _arbitrator,
        uint256 _monthlyRent,
        uint256 _securityDeposit,
        uint256 _leaseDuration,
        bool _depositPaid,
        bool _leaseActive,
        uint256 _totalMonthsPaid
    ) {
        return (
            landlord,
            tenant,
            arbitrator,
            monthlyRent,
            securityDeposit,
            leaseDuration,
            depositPaid,
            leaseActive,
            totalMonthsPaid
        );
    }
}
