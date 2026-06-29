'use client';

export default function CredentialIssuer() {
  const issue = () => {
    alert("Credential Issued on-chain (demo)");
  };

  return (
    <div className="mt-12 bg-gray-900 p-8 rounded-3xl">
      <h2 className="text-2xl font-semibold mb-6">Issue Verifiable Credential</h2>
      <button onClick={issue} className="w-full bg-emerald-600 hover:bg-emerald-700 py-4 rounded-2xl">
        Issue Example Credential (Age / Credit / Passport)
      </button>
    </div>
  );
}