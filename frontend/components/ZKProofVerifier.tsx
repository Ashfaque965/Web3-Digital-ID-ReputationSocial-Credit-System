'use client';

import { useState } from 'react';
import { useWriteContract } from 'wagmi';

export default function ZKProofVerifier() {
  const [minAge, setMinAge] = useState(18);
  const { writeContract } = useWriteContract();

  const proveAge = async () => {
    // 1. Generate ZK proof (frontend)
    // const { proof, publicSignals } = await generateAgeProof(userCred, minAge);

    // 2. Submit to contract
    writeContract({
      address: process.env.NEXT_PUBLIC_ZK_DISCLOSURE_CONTRACT as `0x${string}`,
      abi: [ /* ABI of SelectiveDisclosure */ ],
      functionName: 'verifyAgeProof',
      args: [formattedProof, publicSignals, credentialId],
    });
  };

  return (
    <div className="glass p-6 rounded-3xl">
      <h3 className="text-xl font-semibold mb-4">Zero-Knowledge Proof Demo</h3>
      <input
        type="number"
        value={minAge}
        onChange={(e) => setMinAge(Number(e.target.value))}
        className="bg-black border border-gray-700 rounded-xl px-4 py-3 w-full mb-4"
        placeholder="Minimum Age"
      />
      <button
        onClick={proveAge}
        className="w-full bg-purple-600 hover:bg-purple-700 py-4 rounded-2xl font-semibold"
      >
        Prove Age ≥ {minAge} (Without Revealing Birth Date)
      </button>
    </div>
  );
}