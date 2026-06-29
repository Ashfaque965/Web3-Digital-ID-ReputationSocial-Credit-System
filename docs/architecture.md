# System Architecture

## Layers
1. **Blockchain Layer** — Smart contracts (DID, VC, Reputation)
2. **Identity Layer** — Self-Sovereign DID + Verifiable Credentials
3. **Reputation Layer** — Programmable multi-category scoring
4. **Application Layer** — React dApp + Wallet integration
5. **Storage Layer** — On-chain hashes + IPFS for full documents

## Data Flow
User → Wallet → Issue DID → Receive VC → Actions update Reputation Score → Dashboard displays score