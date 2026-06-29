// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "./Groth16Verifier.sol";
import "../VerifiableCredential.sol";

contract SelectiveDisclosure {
    Groth16Verifier public immutable verifier;
    VerifiableCredential public immutable vcContract;

    mapping(bytes32 => bool) public usedProofs; // Prevent replay attacks

    event SelectiveProofVerified(
        address indexed prover,
        bytes32 indexed credentialId,
        string attribute,
        uint256 publicValue
    );

    constructor(address _verifier, address _vcContract) {
        verifier = Groth16Verifier(_verifier);
        vcContract = VerifiableCredential(_vcContract);
    }

    function verifyAgeProof(
        Groth16Verifier.Proof calldata proof,
        uint256[3] calldata publicSignals,   // [userAddress, credentialHash, minAge]
        bytes32 credentialId,
        bytes32 proofId                     // nonce to prevent replay
    ) external returns (bool) {
        require(!usedProofs[proofId], "Proof already used");
        require(publicSignals[0] == uint256(uint160(msg.sender)), "Proof not for sender");

        bool valid = verifier.verifyProof(
            proof.a,
            proof.b,
            proof.c,
            publicSignals
        );

        require(valid, "Invalid zero-knowledge proof");
        require(vcContract.verifyCredential(credentialId), "Invalid credential");

        usedProofs[proofId] = true;

        emit SelectiveProofVerified(msg.sender, credentialId, "age", publicSignals[2]);
        return true;
    }

    // Additional proof verifier for credit score range
    function verifyCreditRangeProof(
        Groth16Verifier.Proof calldata proof,
        uint256[4] calldata publicSignals,   // [user, credHash, minScore, maxScore]
        bytes32 credentialId
    ) external returns (bool) {
        // Similar implementation...
        return true;
    }
}