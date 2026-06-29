// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract DIDRegistry {
    mapping(address => string) public dids;           // address => DID document URI
    mapping(string => address) public addressByDid;

    event DIDRegistered(address indexed owner, string did);

    function registerDID(string calldata did) external {
        require(bytes(dids[msg.sender]).length == 0, "DID already registered");
        dids[msg.sender] = did;
        addressByDid[did] = msg.sender;
        emit DIDRegistered(msg.sender, did);
    }

    function resolveDID(address owner) external view returns (string memory) {
        return dids[owner];
    }
}