// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract MetadataRegistry {
    struct Metadata {
        string name;
        string description;
        string imageCID;
        string attributesJSON;   // Additional JSON metadata
        uint256 version;
    }

    mapping(bytes32 => Metadata) public metadata;

    event MetadataUpdated(bytes32 indexed id, string name, uint256 version);

    function setMetadata(
        bytes32 id,
        string calldata name,
        string calldata description,
        string calldata imageCID,
        string calldata attributes
    ) external {
        metadata[id] = Metadata({
            name: name,
            description: description,
            imageCID: imageCID,
            attributesJSON: attributes,
            version: block.timestamp
        });

        emit MetadataUpdated(id, name, block.timestamp);
    }

    function getMetadata(bytes32 id) external view returns (Metadata memory) {
        return metadata[id];
    }
}