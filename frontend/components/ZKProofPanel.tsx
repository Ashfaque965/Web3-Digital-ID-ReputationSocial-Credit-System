'use client';

import { useState } from 'react';
import { useAccount, useWriteContract } from 'wagmi';
import { generateAgeProof, formatProofForContract } from '@/lib/zk';

export default function ZKProofPanel() {
  const { address } = useAccount();
  const { writeContract } = useWriteContract();
  const [minAge, setMinAge] = useState(21);
  const [loading, setLoading] = useState(false);
  const [result, setResult] = useState<string>("");

  const proveAndVerify = async () => {
    if (!address) return;
    setLoading(true);

    try {
      // Mock credential data (in real app: from user wallet)
      const credentialData = { birthDate: 946684800 }; // Example: Year 2000

      const { proof, publicSignals } = await generateAgeProof(credentialData, minAge);
      const formattedProof = formatProofForContract(proof);

      const proofId = ethers.utils.randomBytes(32); // nonce

      writeContract({
        address: process.env.NEXT_PUBLIC_SELECTIVE_DISCLOSURE as `0x${string}`,
        abi: selectiveDisclosureABI,
        functionName: 'verifyAgeProof',
        args: [formattedProof, publicSignals, credentialId, proofId],
      });

      setResult(`✅ Proved age ≥ ${minAge} without revealing birth date`);
    } catch (err) {
      setResult("❌ Proof generation failed");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="glass p-8 rounded-3xl border border-purple-500/30">
      <h2 className="text-2xl font-bold mb-2">Zero-Knowledge Selective Disclosure</h2>
      <p className="text-gray-400 mb-6">Prove attributes privately</p>

      <div className="space-y-6">
        <div>
          <label className="block text-sm mb-2">Prove Minimum Age</label>
          <input
            type="range"
            min="13"
            max="100"
            value={minAge}
            onChange={(e) => setMinAge(Number(e.target.value))}
            className="w-full accent-purple-500"
          />
          <div className="text-center text-3xl font-mono mt-2">{minAge}</div>
        </div>

        <button
          onClick={proveAndVerify}
          disabled={loading}
          className="w-full py-5 bg-gradient-to-r from-purple-600 to-violet-600 rounded-2xl font-semibold text-lg disabled:opacity-50"
        >
          {loading ? "Generating ZK Proof..." : `Prove Age ≥ ${minAge}`}
        </button>

        {result && <div className="mt-4 p-4 bg-black rounded-2xl text-sm">{result}</div>}
      </div>
    </div>
  );
}