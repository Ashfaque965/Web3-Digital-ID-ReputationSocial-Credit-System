// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "../access/AccessControl.sol";

contract ReputationEngine is AccessControl {
    struct Reputation {
        uint256 totalScore;
        mapping(string => uint256) categoryScores;
        uint256 lastUpdated;
        uint256 updateCount;
    }

    mapping(address => Reputation) public reputations;
    uint256 public constant MAX_SCORE = 1000;
    uint256 public constant MIN_SCORE = 0;

    event ReputationUpdated(address indexed user, uint256 newScore, string category);

    function updateReputation(
        address user,
        uint256 points,
        string calldata category
    ) external onlyRole(DEFAULT_ADMIN_ROLE) {
        Reputation storage rep = reputations[user];
        
        rep.totalScore = clamp(rep.totalScore + points, MIN_SCORE, MAX_SCORE);
        rep.categoryScores[category] += points;
        rep.lastUpdated = block.timestamp;
        rep.updateCount++;

        emit ReputationUpdated(user, rep.totalScore, category);
    }

    function getReputation(address user) external view returns (uint256) {
        return reputations[user].totalScore;
    }

    function clamp(uint256 value, uint256 minVal, uint256 maxVal) internal pure returns (uint256) {
        if (value < minVal) return minVal;
        if (value > maxVal) return maxVal;
        return value;
    }
}