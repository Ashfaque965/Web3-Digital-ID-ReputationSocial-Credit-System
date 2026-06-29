// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "./DIDRegistry.sol";
import "../access/AccessControl.sol";

contract IdentityManager is AccessControl {
    bytes32 public constant ISSUER_ROLE = keccak256("ISSUER_ROLE");
    bytes32 public constant VERIFIER_ROLE = keccak256("VERIFIER_ROLE");

    DIDRegistry public didRegistry;

    struct IdentityProfile {
        uint256 createdAt;
        uint256 lastUpdated;
        bool isActive;
        string metadataHash;        // IPFS hash
    }

    mapping(address => IdentityProfile) public profiles;

    event IdentityCreated(address indexed owner, string did);
    event IdentityUpdated(address indexed owner);
    event IdentityDeactivated(address indexed owner);

    constructor(address _didRegistry) {
        didRegistry = DIDRegistry(_didRegistry);
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    function createIdentity(string calldata did, string calldata metadataHash) external {
        require(bytes(didRegistry.resolveDID(msg.sender)).length == 0, "DID exists");
        
        didRegistry.registerDID(did);
        
        profiles[msg.sender] = IdentityProfile({
            createdAt: block.timestamp,
            lastUpdated: block.timestamp,
            isActive: true,
            metadataHash: metadataHash
        });

        emit IdentityCreated(msg.sender, did);
    }

    function updateMetadata(string calldata newMetadataHash) external {
        require(profiles[msg.sender].isActive, "Identity inactive");
        profiles[msg.sender].metadataHash = newMetadataHash;
        profiles[msg.sender].lastUpdated = block.timestamp;
        emit IdentityUpdated(msg.sender);
    }
}