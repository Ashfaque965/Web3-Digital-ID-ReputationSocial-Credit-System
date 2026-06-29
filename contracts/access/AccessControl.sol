// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/access/AccessControl.sol";

// Re-export for consistency (or extend with custom roles)
contract WorldAccessControl is AccessControl {
    bytes32 public constant GLOBAL_ADMIN = keccak256("GLOBAL_ADMIN");
    
    constructor() {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(GLOBAL_ADMIN, msg.sender);
    }
}