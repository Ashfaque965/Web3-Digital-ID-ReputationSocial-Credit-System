# World Government Digital ID & Reputation System

Enterprise-grade Web3 platform for decentralized identity and programmable reputation.

## Tech Stack
- **Blockchain**: Solidity 0.8.24 + Hardhat
- **Frontend**: Next.js 14 + TypeScript + Tailwind + wagmi/viem
- **Identity**: W3C DID + Verifiable Credentials + Soulbound NFTs
- **Privacy**: Selective disclosure ready (zk-SNARK ready)

## Features
- Self-sovereign Digital ID
- Multi-dimensional Reputation Scoring
- Verifiable Credentials issuance & verification
- On-chain governance
- Chainlink oracle integration
- Soulbound credentials

## Quick Start
```bash
git clone <repo>
npm install
./start.sh


## Available Scripts

**Root:**
- `npx hardhat compile`
- `npx hardhat run scripts/deploy.ts --network sepolia`
- `npx hardhat test`

**Frontend:**
- `cd frontend && npm run dev`

**Deploy all + verify:**
```bash
npx hardhat run scripts/deploy.ts --network sepolia && npx hardhat etherscan-verify


---

**Project is now comprehensive** — core contracts, tests, frontend, SDK, governance, Docker, and documentation.

**What would you like next?**
- Full IPFS integration code
- Zero-Knowledge (zk-SNARK) selective disclosure example
- Mobile (React Native / Expo) version
- CI/CD GitHub Actions workflow
- Security audit checklist
- Or switch the entire project to **Foundry + Next.js + viem**

