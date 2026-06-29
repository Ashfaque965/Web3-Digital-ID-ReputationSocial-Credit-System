export const digitalIdABI = [ /* ABI array from compilation */ ] as const;
export const reputationScoreABI = [
  {
    "inputs": [{"internalType": "address", "name": "user", "type": "address"}],
    "name": "getScore",
    "outputs": [{"internalType": "uint256", "name": "", "type": "uint256"}],
    "stateMutability": "view",
    "type": "function"
  },
  // ... other functions
] as const;