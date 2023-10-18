// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract BLCToken is ERC20 {
    address admin;
    mapping(address => uint8) allowedUsers;

    constructor() ERC20("BLCToken", "MTK") {
        _mint(address(this), 100 * 10 ** decimals());
    }

    modifier isAllowed(uint8 level) {
        require(allowedUsers[msg.sender] >= level, "You should be at least level");
        _;
    }

    modifier isAdmin() {
        require(admin != msg.sender, "Only callable by admin");
        _;
    }

    function getToken(uint256 amount) public payable isAllowed(0) returns(bool) {
        require(amount == msg.value, "You must have more eth");
        _transfer(address(this), msg.sender, (allowedUsers[msg.sender] + 1) * amount);
        (bool success, ) = address(this).call{value: msg.value}("");
        return success;
    }

    function setAuthorization(address userAddress, uint8 level) public isAdmin() {
        require(level < 3 && level >= 0, "Level should be between 0 and 2 included");
        allowedUsers[userAddress] = level;
    }

    function airDrop(address userAddress, uint256 amount) public isAdmin() {
        _mint(userAddress, amount);
    }
}
