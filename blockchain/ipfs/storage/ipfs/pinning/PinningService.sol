// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

interface IPinningService {
    function pin(string calldata cid) external returns (bool);
    function unpin(string calldata cid) external returns (bool);
}

contract PinataMock is IPinningService {
    mapping(string => bool) public pinnedCIDs;

    function pin(string calldata cid) external override returns (bool) {
        pinnedCIDs[cid] = true;
        return true;
    }

    function unpin(string calldata cid) external override returns (bool) {
        pinnedCIDs[cid] = false;
        return true;
    }

    function isPinned(string calldata cid) external view returns (bool) {
        return pinnedCIDs[cid];
    }
}