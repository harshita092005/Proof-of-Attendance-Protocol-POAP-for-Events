// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract POAP is ERC721, Ownable {
    uint256 public nextTokenId;
    string private baseTokenURI;

    mapping(uint256 => mapping(address => bool)) public claimed;

    event POAPClaimed(address indexed attendee, uint256 indexed eventId, uint256 tokenId);

    // Default base URI for metadata
    string constant DEFAULT_BASE_URI = "https://example.com/poap/";

    constructor() ERC721("Proof of Attendance Protocol", "POAP") Ownable(msg.sender) {
        baseTokenURI = DEFAULT_BASE_URI;
    }

    function setBaseURI(string calldata _baseTokenURI) external onlyOwner {
        baseTokenURI = _baseTokenURI;
    }

    function claimPOAP(uint256 eventId) external {
        require(!claimed[eventId][msg.sender], "POAP already claimed for this event");

        uint256 tokenId = nextTokenId++;
        _safeMint(msg.sender, tokenId);
        claimed[eventId][msg.sender] = true;

        emit POAPClaimed(msg.sender, eventId, tokenId);
    }

    function _baseURI() internal view override returns (string memory) {
        return baseTokenURI;
    }
}
