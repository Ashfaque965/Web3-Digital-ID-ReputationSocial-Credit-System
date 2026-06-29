// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract SoulboundCredential is ERC721, AccessControl {
    bytes32 public constant ISSUER_ROLE = keccak256("ISSUER_ROLE");

    mapping(uint256 => string) public credentialMetadata;

    constructor() ERC721("SoulboundDigitalID", "SDID") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(ISSUER_ROLE, msg.sender);
    }

    function issueSoulbound(address to, uint256 tokenId, string calldata metadata) external onlyRole(ISSUER_ROLE) {
        _safeMint(to, tokenId);
        credentialMetadata[tokenId] = metadata;
    }

    // Soulbound: Prevent transfers
    function _beforeTokenTransfer(address from, address to, uint256, uint256) internal pure override {
        require(from == address(0) || to == address(0), "Soulbound: Token cannot be transferred");
    }

    function burn(uint256 tokenId) external {
        require(ownerOf(tokenId) == msg.sender, "Not owner");
        _burn(tokenId);
    }
}