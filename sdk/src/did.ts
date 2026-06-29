import { createVerifiableCredential } from '@veramo/core'; // or custom implementation

export async function createDIDDocument(address: string) {
  return {
    "@context": ["https://www.w3.org/ns/did/v1"],
    id: `did:ethr:${address}`,
    verificationMethod: [{
      id: `did:ethr:${address}#keys-1`,
      type: "EcdsaSecp256k1VerificationKey2019",
      controller: `did:ethr:${address}`,
      publicKeyHex: "0x..." // from wallet
    }]
  };
}