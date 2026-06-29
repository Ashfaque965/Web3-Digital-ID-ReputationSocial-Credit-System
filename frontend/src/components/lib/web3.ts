import { createConfig, http } from 'wagmi';
import { sepolia, base } from 'wagmi/chains';
import { injected } from 'wagmi/connectors';

export const wagmiConfig = createConfig({
  chains: [sepolia, base],
  connectors: [injected()],
  transports: {
    [sepolia.id]: http(),
    [base.id]: http(),
  },
});