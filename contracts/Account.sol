// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract Account is ERC721URIStorage {
    address private owner;
    uint256 private postId;

    string private _name;
    string private _username;

    constructor(
        string memory name_,
        string memory username_,
        address _owner
    ) ERC721(_name, _username) {
        _name = name_;
        _username = username_;
        owner = _owner;
    }

    function name() public view override returns (string memory) {
        return _name;
    }

    function username() external view virtual returns (string memory) {
        return _username;
    }

    function safeMint(address _to) external returns (uint256) {
        _safeMint(_to, ++postId);
        return postId;
    }

    function setTokenURI(string memory _contentURI) external {
        _setTokenURI(postId, _contentURI);
    }
}
