// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "../access/AccessControl.sol";

contract CredentialRegistry is AccessControl {
    bytes32 public constant ISSUER_ROLE = keccak256("ISSUER_ROLE");

    struct Credential {
        address issuer;
        address subject;
        string credentialType;
        uint256 issuedAt;
        uint256 expiresAt;
        string ipfsHash;           // Full credential data
        bool revoked;
    }

    mapping(bytes32 => Credential) public credentials;
    mapping(address => bytes32[]) public userCredentials;

    event CredentialIssued(bytes32 indexed id, address indexed subject, string credentialType);
    event CredentialRevoked(bytes32 indexed id);

    constructor() {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    function issueCredential(
        address subject,
        string calldata credentialType,
        uint256 validityDays,
        string calldata ipfsHash
    ) external onlyRole(ISSUER_ROLE) returns (bytes32) {
        bytes32 credentialId = keccak256(abi.encodePacked(subject, credentialType, block.timestamp));

        credentials[credentialId] = Credential({
            issuer: msg.sender,
            subject: subject,
            credentialType: credentialType,
            issuedAt: block.timestamp,
            expiresAt: block.timestamp + (validityDays * 1 days),
            ipfsHash: ipfsHash,
            revoked: false
        });

        userCredentials[subject].push(credentialId);
        emit CredentialIssued(credentialId, subject, credentialType);
        return credentialId;
    }

    function revokeCredential(bytes32 credentialId) external {
        require(credentials[credentialId].issuer == msg.sender || hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "Not authorized");
        credentials[credentialId].revoked = true;
        emit CredentialRevoked(credentialId);
    }
}