// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "./IdentityManager.sol";

contract Recovery {
    IdentityManager public identityManager;

    mapping(address => address[]) public guardians;
    mapping(address => uint256) public recoveryRequests;
    mapping(bytes32 => bool) public approvedRecoveries;

    uint256 public constant RECOVERY_THRESHOLD = 3; // Number of guardians needed

    event RecoveryRequested(address indexed owner);
    event GuardianAdded(address indexed owner, address guardian);
    event RecoveryExecuted(address indexed oldOwner, address indexed newOwner);

    constructor(address _identityManager) {
        identityManager = IdentityManager(_identityManager);
    }

    function addGuardian(address guardian) external {
        require(guardian != msg.sender, "Cannot be own guardian");
        guardians[msg.sender].push(guardian);
        emit GuardianAdded(msg.sender, guardian);
    }

    function requestRecovery(address newOwner) external {
        require(identityManager.profiles(msg.sender).isActive, "No active identity");
        recoveryRequests[msg.sender] = block.timestamp;
        emit RecoveryRequested(msg.sender);
    }

    function approveRecovery(address ownerToRecover, bytes32 approvalId) external {
        require(isGuardian(msg.sender, ownerToRecover), "Not a guardian");
        approvedRecoveries[approvalId] = true;
    }

    function executeRecovery(address oldOwner, address newOwner, bytes32 approvalId) external {
        require(approvedRecoveries[approvalId], "Not enough approvals");
        // Transfer identity ownership logic here
        emit RecoveryExecuted(oldOwner, newOwner);
    }

    function isGuardian(address potentialGuardian, address owner) internal view returns (bool) {
        address[] memory ownerGuardians = guardians[owner];
        for (uint i = 0; i < ownerGuardians.length; i++) {
            if (ownerGuardians[i] == potentialGuardian) return true;
        }
        return false;
    }
}