// Add to previous ReputationScore.sol
import "@openzeppelin/contracts/security/Pausable.sol";

contract ReputationScore is Pausable {
    uint256 public maxScore = 1000;
    uint256 public minScore = 0;

    function updateScore(address user, uint256 points, string calldata category) external whenNotPaused {
        // ... existing logic
        userScores[user].totalScore = clamp(userScores[user].totalScore + points, minScore, maxScore);
    }

    function clamp(uint256 value, uint256 min, uint256 max) internal pure returns (uint256) {
        return value < min ? min : (value > max ? max : value);
    }

    function pause() external onlyRole(DEFAULT_ADMIN_ROLE) { _pause(); }
    function unpause() external onlyRole(DEFAULT_ADMIN_ROLE) { _unpause(); }
}