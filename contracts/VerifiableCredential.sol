// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract VerifiableCredential is AccessControl {
    bytes32 public constant ISSUER_ROLE = keccak256("ISSUER_ROLE");

    struct Credential {
        address issuer;
        address subject;
        string credentialType;     // e.g., "Passport", "CreditHistory", "AgeProof"
        uint256 issuanceDate;
        uint256 expirationDate;
        bytes32 credentialHash;    // Hash of the off-chain VC data
        bool revoked;
    }

    mapping(bytes32 => Credential) public credentials;  // credentialId => Credential
    mapping(address => bytes32[]) public userCredentials;

    event CredentialIssued(bytes32 indexed credentialId, address indexed subject, string credentialType);
    event CredentialRevoked(bytes32 indexed credentialId);

    constructor() {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(ISSUER_ROLE, msg.sender);
    }

    function issueCredential(
        address subject,
        string calldata credentialType,
        uint256 validityDays,
        bytes32 credentialHash
    ) external onlyRole(ISSUER_ROLE) returns (bytes32) {
        bytes32 credentialId = keccak256(abi.encodePacked(subject, credentialType, block.timestamp));

        credentials[credentialId] = Credential({
            issuer: msg.sender,
            subject: subject,
            credentialType: credentialType,
            issuanceDate: block.timestamp,
            expirationDate: block.timestamp + (validityDays * 1 days),
            credentialHash: credentialHash,
            revoked: false
        });

        userCredentials[subject].push(credentialId);

        emit CredentialIssued(credentialId, subject, credentialType);
        return credentialId;
    }

    function revokeCredential(bytes32 credentialId) external {
        Credential storage cred = credentials[credentialId];
        require(cred.issuer == msg.sender || hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "Not authorized");
        cred.revoked = true;
        emit CredentialRevoked(credentialId);
    }

    function verifyCredential(bytes32 credentialId) external view returns (bool) {
        Credential memory cred = credentials[credentialId];
        return !cred.revoked && block.timestamp < cred.expirationDate;
    }
}