'use client';

import WalletConnect from '@/components/WalletConnect';
import DIDManager from '@/components/DIDManager';
import ReputationDashboard from '@/components/ReputationDashboard';
import CredentialIssuer from '@/components/CredentialIssuer';

export default function Home() {
  return (
    <main className="min-h-screen bg-gray-950 text-white p-8">
      <div className="max-w-6xl mx-auto">
        <h1 className="text-5xl font-bold text-center mb-4">
          World Digital Identity &amp; Reputation
        </h1>
        <p className="text-center text-gray-400 mb-12">
          Self-Sovereign • Blockchain • Transparent
        </p>

        <WalletConnect />

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-8 mt-12">
          <DIDManager />
          <ReputationDashboard />
        </div>

        <CredentialIssuer />
      </div>
    </main>
  );
}