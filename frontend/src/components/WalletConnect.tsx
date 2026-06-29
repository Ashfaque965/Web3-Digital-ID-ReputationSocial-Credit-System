'use client';

import { useAccount, useConnect, useDisconnect } from 'wagmi';
import { InjectedConnector } from 'wagmi/connectors/injected';

export default function WalletConnect() {
  const { address, isConnected } = useAccount();
  const { connect } = useConnect({ connector: new InjectedConnector() });
  const { disconnect } = useDisconnect();

  return (
    <div className="flex justify-center">
      {isConnected ? (
        <div className="flex items-center gap-4 bg-gray-900 px-6 py-3 rounded-xl">
          <p className="font-mono text-sm">{address?.slice(0, 6)}...{address?.slice(-4)}</p>
          <button onClick={() => disconnect()} className="bg-red-600 hover:bg-red-700 px-4 py-2 rounded-lg text-sm">
            Disconnect
          </button>
        </div>
      ) : (
        <button
          onClick={() => connect()}
          className="bg-blue-600 hover:bg-blue-700 px-8 py-4 rounded-2xl text-lg font-semibold"
        >
          Connect Wallet
        </button>
      )}
    </div>
  );
}