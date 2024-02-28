// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.21;

import "./Account.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract SocialMedia is AccessControl {
    constructor(address _admin) {
        _grantRole(DEFAULT_ADMIN_ROLE, _admin);
    }

    //
    Account[] public accounts;
    mapping(address => Account) accountMap;
    mapping(address => bool) isRegistered;
    mapping(uint256 => string) accountPosts;

    //
    function signUp(string memory name, string memory username) public {
        require(isRegistered[msg.sender] == false, "User has already been registered");
        Account user = new Account(name, username, msg.sender);
        accounts.push(user);
        accountMap[msg.sender] = user;
        isRegistered[msg.sender] = true;
    }

    function checkProfile() public view returns (Account) {
        return accountMap[msg.sender];
    }

    //TODO: separate text post from multimedia post
    function createPost(string memory _content) public {
        require(isRegistered[msg.sender] == true, "You have to sign up first");
        Account user = accountMap[msg.sender];
        uint256 postId = user.safeMint(msg.sender);
        user.setTokenURI(_content);
        accountPosts[postId] = _content;
    }
}
