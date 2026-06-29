'use client';

import { useAccount } from 'wagmi';
import { useReputation } from '@/hooks/useReputation';

export default function ReputationDashboard() {
  const { address } = useAccount();
  const { score, categories, loading } = useReputation(address);

  if (loading) return <div>Loading reputation...</div>;

  return (
    <div className="p-6">
      <h1 className="text-3xl font-bold">Your Global Digital Reputation</h1>
      <div className="mt-8 text-6xl font-mono">{score}</div>
      {/* Category breakdown, history, etc. */}
    </div>
  );
}