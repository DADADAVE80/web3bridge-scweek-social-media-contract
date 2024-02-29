// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.21;

import "./Account.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract SocialMedia is AccessControl {
    constructor(address _admin) {
        _grantRole(DEFAULT_ADMIN_ROLE, _admin);
    }

    modifier onlyAdmin(bytes32 _role) {
        _checkRole(_role);
        _;
    }

    // Account storage
    Account[] public accounts;
    mapping(address => Account) public accountMap;
    mapping(address => bool) private isRegistered;

    // Post storage
    mapping(address => mapping(uint256 => string)) accountPosts;

    // Sign up
    function signUp(string memory name, string memory username) public {
        require(
            isRegistered[msg.sender] == false,
            "User has already been registered"
        );
        Account user = new Account(name, username, msg.sender);
        accounts.push(user);
        accountMap[msg.sender] = user;
        isRegistered[msg.sender] = true;
    }

    // Check profile
    function checkProfile() public view returns (Account) {
        return accountMap[msg.sender];
    }

    // Create posts
    // TODO: separate text post from multimedia post
    function createPost(string memory _content) public {
        require(isRegistered[msg.sender] == true, "You have to sign up first");
        Account user = accountMap[msg.sender];
        uint256 postId = user.safeMint(msg.sender); //returns the id of minted NFT post
        user.setTokenURI(_content); //sets the content of the post
        accountPosts[msg.sender][postId] = _content;
    }

    // Share posts
    function sharePost(
        address _account,
        uint256 _postId
    ) external view returns (string memory) {
        return accountPosts[_account][_postId];
    }
}
