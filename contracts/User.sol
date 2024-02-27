// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract User is ERC721URIStorage{
    address private owner;
    uint256 private tokenId;

    constructor(
        string memory name_,
        string memory username_
    ) ERC721(name_, username_) {
        owner = tx.origin;
    }

    function safeMint() external {
        _safeMint(msg.sender, ++tokenId);
    }

    function setTokenURI(string memory _contentURI) external {
        _setTokenURI(tokenId, _contentURI);
    }

    function getAddresses() public view returns (address, address) {
        return (msg.sender, tx.origin);
    }
}
