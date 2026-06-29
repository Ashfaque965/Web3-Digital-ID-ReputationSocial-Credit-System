import { groth16 } from 'snarkjs';

export async function generateAgeProof(
  credentialData: any,
  minAge: number
) {
  // In real app: Use wasm + circuit files
  const { proof, publicSignals } = await groth16.fullProve(
    {
      birthDate: credentialData.birthDate,
      currentDate: Math.floor(Date.now() / 1000),
      minAge: minAge,
    },
    "/circuits/age.circuit.wasm",
    "/circuits/age.final.zkey"
  );

  return { proof, publicSignals };
}

export function formatProofForContract(proof: any) {
  return {
    a: [proof.pi_a[0], proof.pi_a[1]],
    b: [
      [proof.pi_b[0][1], proof.pi_b[0][0]],
      [proof.pi_b[1][1], proof.pi_b[1][0]]
    ],
    c: [proof.pi_c[0], proof.pi_c[1]],
  };
}