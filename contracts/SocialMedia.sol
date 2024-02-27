// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.21;

import "./User.sol";

contract SocialMedia {
    User[] public users;
    mapping (address => User) userMap;

    function createUser(string memory name, string memory username) public {
        User user = new User(name, username);
        users.push(user);
        userMap[msg.sender] = user;
    }

    function getUser() public view returns (User) {
        return userMap[msg.sender];
    }

    function post(string memory _content) public {
        User user = userMap[msg.sender];
        user.safeMint();
        user.setTokenURI(_content);
    }
}