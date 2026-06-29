import { createPublicClient, http } from 'viem';
import { mainnet } from 'viem/chains';

export class DigitalIDSDK {
  private client;

  constructor(rpcUrl: string) {
    this.client = createPublicClient({
      chain: mainnet,
      transport: http(rpcUrl),
    });
  }

  async getReputation(address: `0x${string}`) {
    // Call contract
  }

  async createVerifiablePresentation(credentials: any[]) {
    // Zero-knowledge or JWT logic here
  }
}

export { DigitalIDSDK };