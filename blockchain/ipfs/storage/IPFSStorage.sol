// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract IPFSStorage {
    struct Content {
        string cid;           // IPFS Content Identifier
        uint256 timestamp;
        address uploader;
        bool isEncrypted;
    }

    mapping(bytes32 => Content) public storedContent;
    mapping(address => bytes32[]) public userContent;

    event ContentStored(bytes32 indexed contentId, string cid, address indexed uploader);

    function storeContent(string calldata cid, bool encrypted) external returns (bytes32) {
        bytes32 contentId = keccak256(abi.encodePacked(cid, msg.sender, block.timestamp));

        storedContent[contentId] = Content({
            cid: cid,
            timestamp: block.timestamp,
            uploader: msg.sender,
            isEncrypted: encrypted
        });

        userContent[msg.sender].push(contentId);
        emit ContentStored(contentId, cid, msg.sender);
        return contentId;
    }

    function getContent(bytes32 contentId) external view returns (string memory) {
        return storedContent[contentId].cid;
    }
}