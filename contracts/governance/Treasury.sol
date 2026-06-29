// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "../token/NXTToken.sol";

contract Treasury {
    NXTToken public governanceToken;
    address public dao;

    event FundsReleased(address indexed to, uint256 amount, string reason);

    constructor(address _token, address _dao) {
        governanceToken = NXTToken(_token);
        dao = _dao;
    }

    modifier onlyDAO() {
        require(msg.sender == dao, "Only DAO");
        _;
    }

    function releaseFunds(address to, uint256 amount, string calldata reason) external onlyDAO {
        governanceToken.transfer(to, amount);
        emit FundsReleased(to, amount, reason);
    }

    function getBalance() external view returns (uint256) {
        return governanceToken.balanceOf(address(this));
    }
}