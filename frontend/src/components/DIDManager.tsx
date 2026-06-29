'use client';

import { useState } from 'react';
import { useAccount } from 'wagmi';

export default function DIDManager() {
  const { address } = useAccount();
  const [did, setDid] = useState("");

  const register = async () => {
    if (!address) return alert("Connect wallet first");
    // Call DIDRegistry.registerDID(did)
    alert("DID Registered (demo)");
  };

  return (
    <div className="bg-gray-900 p-8 rounded-3xl">
      <h2 className="text-2xl font-semibold mb-6">Manage Your DID</h2>
      <input
        type="text"
        placeholder="did:ethr:0x..."
        value={did}
        onChange={(e) => setDid(e.target.value)}
        className="w-full bg-black border border-gray-700 rounded-xl px-4 py-3 mb-4"
      />
      <button onClick={register} className="w-full bg-white text-black py-4 rounded-2xl font-semibold">
        Register DID
      </button>
    </div>
  );
}