// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract DigitalID is AccessControl {
    bytes32 public constant ISSUER_ROLE = keccak256("ISSUER_ROLE");
    
    struct Identity {
        address owner;
        uint256 issuedAt;
        string didUri;           // e.g., did:ethr:0x...
        bool isActive;
    }
    
    mapping(address => Identity) public identities;
    mapping(bytes32 => bool) public usedNonces;
    
    event IdentityIssued(address indexed owner, string didUri);
    event IdentityRevoked(address indexed owner);
    
    constructor() {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }
    
    function issueDID(address owner, string calldata didUri) external onlyRole(ISSUER_ROLE) {
        identities[owner] = Identity({
            owner: owner,
            issuedAt: block.timestamp,
            didUri: didUri,
            isActive: true
        });
        emit IdentityIssued(owner, didUri);
    }
    
    function revokeDID(address owner) external onlyRole(ISSUER_ROLE) {
        identities[owner].isActive = false;
        emit IdentityRevoked(owner);
    }
}