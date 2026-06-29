import { useState, useEffect } from 'react';
import { useAccount, useReadContract } from 'wagmi';
import { reputationScoreABI } from '@/lib/abis';

export function useReputation(userAddress?: string) {
  const { address } = useAccount();
  const targetAddress = userAddress || address;

  const { data: score, isLoading } = useReadContract({
    address: process.env.NEXT_PUBLIC_REPUTATION_CONTRACT as `0x${string}`,
    abi: reputationScoreABI,
    functionName: 'getScore',
    args: targetAddress ? [targetAddress] : undefined,
    query: { enabled: !!targetAddress },
  });

  const [categories, setCategories] = useState<Record<string, number>>({});

  // Add more reads for category scores...

  return {
    score: score ? Number(score) : 0,
    categories,
    loading: isLoading,
  };
}