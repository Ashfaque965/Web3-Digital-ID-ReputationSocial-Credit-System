// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/governance/Governor.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorSettings.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorCountingSimple.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorVotes.sol";

contract WorldIDDAO is Governor, GovernorSettings, GovernorCountingSimple, GovernorVotes {
    constructor(IVotes _token)
        Governor("WorldID DAO")
        GovernorSettings(1 days, 7 days, 0)
        GovernorVotes(_token)
    {}

    function quorum(uint256) public pure override returns (uint256) {
        return 500_000 * 10 ** 18; // 0.5M tokens
    }
}