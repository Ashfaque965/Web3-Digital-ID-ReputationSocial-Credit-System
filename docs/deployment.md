

# Deployment Guide

## 1. Local Development
```bash
# Terminal 1 - Blockchain
npx hardhat node

# Terminal 2 - Contracts
npx hardhat run scripts/deploy.ts --network localhost

# Terminal 3 - Frontend
cd frontend && npm run dev

2. Testnet (Sepolia/Base)Add private key to .env
npx hardhat run scripts/deploy.ts --network sepolia
Update contract addresses in frontend .env.local
Deploy frontend: vercel or netlify

3. Mainnet ChecklistAudit contracts
Set proper gas limits
Monitor with Tenderly
Add multisig for admin roles

### 34. `package.json` (Root)
```json
{
  "name": "world-digital-id-reputation",
  "version": "1.0.0",
  "scripts": {
    "compile": "hardhat compile",
    "deploy": "hardhat run scripts/deploy.ts --network sepolia",
    "test": "hardhat test",
    "frontend": "cd frontend && npm run dev"
  },
  "devDependencies": {
    "hardhat": "^2.22.0",
    "@nomicfoundation/hardhat-toolbox": "^5.0.0",
    "dotenv": "^16.4.0"
  }
}

 Project is now fully featured with soulbound tokens, modern UI, complete deployment pipeline, and production considerations.Summary of What You HaveDecentralized Digital ID (DID + VC)
Reputation/Social Credit Engine (multi-category, updatable)
Governance & Oracles
Soulbound Credentials (non-transferable proof)
Full Frontend Dashboard
Testing + CI/CD
Documentation

This is a solid foundation for a World Government-style Digital ID + Reputation system built on Web3 principles (with SSI emphasis for privacy).The codebase is ready to clone and run.