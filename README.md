# Rental Agreement - Automate Deposits, Monthly Payments, Dispute Resolution

## Project Description

This smart contract project revolutionizes traditional rental agreements by automating key processes on the blockchain. It eliminates the need for intermediaries, reduces disputes, and ensures transparent, trustless execution of rental terms between landlords and tenants.

The RentalAgreement smart contract handles security deposits, automates monthly rent payments, and provides a fair dispute resolution mechanism through a neutral arbitrator. All transactions are recorded immutably on the blockchain, creating an auditable trail of payments and agreements.

## Project Vision

Our vision is to transform the rental industry by:

- **Eliminating Trust Issues**: Remove the need for tenants and landlords to trust each other with large deposits and timely payments
- **Reducing Disputes**: Automate payment tracking and provide transparent records to minimize conflicts
- **Lowering Costs**: Cut out middlemen like property management companies and escrow services
- **Increasing Accessibility**: Make rental agreements accessible globally through blockchain technology
- **Ensuring Fairness**: Provide neutral, automated dispute resolution that protects both parties

We envision a future where rental agreements are seamless, transparent, and executed automatically through smart contracts, benefiting millions of tenants and landlords worldwide.

## Key Features

### 1. **Automated Security Deposit Management**
- Tenant deposits funds securely in the smart contract
- Deposit is locked and protected from unauthorized access
- Automatic refund after lease ends (if no disputes)
- Transparent tracking of deposit status

### 2. **Monthly Rent Payment Automation**
- Tenants pay rent directly through the smart contract
- Payments are instantly transferred to the landlord
- On-chain payment history for proof of payment
- Month-by-month tracking prevents double payments

### 3. **Fair Dispute Resolution**
- Either party can raise a dispute if issues arise
- Neutral arbitrator reviews evidence and makes binding decisions
- Security deposit is distributed based on arbitrator's judgment
- Protects both tenant rights and landlord interests

### 4. **Transparency & Immutability**
- All transactions recorded permanently on blockchain
- Public visibility of contract terms and payment status
- No possibility of tampering with payment records
- Event logs for complete audit trail

### 5. **Multi-Party Protection**
- Role-based access control (landlord, tenant, arbitrator)
- Prevents unauthorized withdrawals or modifications
- Time-locked functions for lease duration
- Secure fund management

## Future Scope

### Short-term Enhancements
- **Late Fee Calculation**: Automatic penalties for overdue rent payments
- **Grace Period Implementation**: Configurable grace period before late fees apply
- **Partial Payment Support**: Allow tenants to pay rent in installments
- **Multi-Currency Support**: Accept payments in various cryptocurrencies or stablecoins

### Medium-term Features
- **Maintenance Request System**: Integrate work order tracking and payment
- **Utility Bill Integration**: Automate utility payments alongside rent
- **Insurance Integration**: Connect with decentralized insurance protocols
- **Credit Score Building**: Create on-chain rental payment history for credit scoring
- **Renewal Automation**: Smart contract auto-renewal with updated terms

### Long-term Vision
- **IoT Smart Lock Integration**: Automatic access control based on payment status
- **Property Token Marketplace**: Enable fractional ownership and investment
- **AI-Powered Arbitration**: Machine learning models to assist in dispute resolution
- **Cross-Chain Compatibility**: Deploy on multiple blockchains for wider adoption
- **Mobile App Interface**: User-friendly apps for tenants and landlords
- **Legal Framework Integration**: Work with jurisdictions for legal enforceability
- **Decentralized Autonomous Rental Organizations (DAROs)**: Community-managed rental properties

### Scalability Goals
- Support for commercial properties and multi-unit buildings
- Sublease and roommate functionality
- Integration with traditional property management systems
- Government and regulatory compliance tools
- Global expansion with localized terms and regulations

---

## Technical Details

**Smart Contract**: `RentalAgreement.sol`

**Core Functions**:
1. `paySecurityDeposit()` - Tenant deposits security amount
2. `payMonthlyRent()` - Automated monthly rent payment
3. `resolveDispute()` - Arbitrator resolves conflicts

**Blockchain**: Ethereum-compatible (can deploy on Polygon, Arbitrum, etc.)

**Solidity Version**: ^0.8.0

---

## Getting Started

### Prerequisites
- Node.js and npm
- Hardhat or Truffle
- MetaMask or similar Web3 wallet
- Test ETH (for deployment on testnet)

### Installation
```bash
# Clone the repository
git clone <repository-url>

# Install dependencies
npm install

# Compile contracts
npx hardhat compile

# Deploy to testnet
npx hardhat run scripts/deploy.js --network sepolia
```

### Usage Example
```solidity
// Deploy contract with parameters
RentalAgreement rental = new RentalAgreement(
    tenantAddress,
    arbitratorAddress,
    1 ether,  // Monthly rent
    2 ether,  // Security deposit
    12        // Lease duration in months
);

// Tenant pays deposit
rental.paySecurityDeposit{value: 2 ether}();

// Tenant pays monthly rent
rental.payMonthlyRent{value: 1 ether}(1); // Month 1
```

---

## Contributing

We welcome contributions! Please follow these steps:
1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Submit a pull request

---

## License

MIT License - see LICENSE file for details

---

## Contact

For questions, suggestions, or collaboration opportunities, please reach out through:
- GitHub Issues
- Email: [your-email@example.com]
- Discord: [your-discord-server]

---

**Built with ❤️ for a transparent rental future**

Contract Address: 0xd0037D6E43F327e1515ecCC00F59CB4A543F33C3
<img width="1846" height="884" alt="image" src="https://github.com/user-attachments/assets/d95382a7-d3f6-4fdc-8f0c-4c088f01a9c5" />
