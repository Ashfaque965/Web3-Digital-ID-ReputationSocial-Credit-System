// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "../access/AccessControl.sol";

contract IssuerRegistry is AccessControl {
    struct Issuer {
        string name;
        string did;
        uint256 registeredAt;
        bool isActive;
    }

    mapping(address => Issuer) public issuers;
    mapping(string => address) public issuerByDID;

    event IssuerRegistered(address indexed issuerAddress, string name, string did);

    function registerIssuer(string calldata name, string calldata did) external {
        require(!issuers[msg.sender].isActive, "Already registered");

        issuers[msg.sender] = Issuer({
            name: name,
            did: did,
            registeredAt: block.timestamp,
            isActive: true
        });

        issuerByDID[did] = msg.sender;

        emit IssuerRegistered(msg.sender, name, did);
    }

    function verifyIssuer(address issuer) external view returns (bool) {
        return issuers[issuer].isActive;
    }
}