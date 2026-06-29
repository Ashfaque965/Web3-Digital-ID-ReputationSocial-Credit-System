import { useAccount, useReadContract, useWriteContract } from 'wagmi';
import { reputationScoreABI } from '@/lib/abis';
import { useState } from 'react';

export function useReputation() {
  const { address } = useAccount();
  const [loading, setLoading] = useState(false);

  const { data: score } = useReadContract({
    address: process.env.NEXT_PUBLIC_REPUTATION_CONTRACT as `0x${string}`,
    abi: reputationScoreABI,
    functionName: 'getScore',
    args: address ? [address] : undefined,
  });

  const { writeContract } = useWriteContract();

  const updateScore = async (points: number, category: string) => {
    if (!address) return;
    setLoading(true);
    try {
      await writeContract({
        address: process.env.NEXT_PUBLIC_REPUTATION_CONTRACT as `0x${string}`,
        abi: reputationScoreABI,
        functionName: 'updateScore',
        args: [address, BigInt(points), category],
      });
    } finally {
      setLoading(false);
    }
  };

  return { score: score ? Number(score) : 0, updateScore, loading };
}