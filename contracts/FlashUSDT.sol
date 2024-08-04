// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract FlashUSDT {
    string public name = "Flash USDT";
    string public symbol = "FLASH";
    uint8 public decimals = 18;
    uint256 public totalSupply;
    uint256 public constant DURATION = 10 days;

    mapping(address => uint256) public balanceOf;
    mapping(address => uint256) public expirationTime;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Debug(string message, uint256 value);

    constructor(uint256 _initialSupply) {
        emit Debug("Constructor Start", _initialSupply);
        totalSupply = _initialSupply * 10 ** uint256(decimals);
        emit Debug("Total Supply Calculated", totalSupply);
        balanceOf[msg.sender] = totalSupply;
        expirationTime[msg.sender] = block.timestamp + DURATION;
        emit Debug("Expiration Time Set", expirationTime[msg.sender]);
        emit Debug("Constructor End", block.timestamp);
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(_value <= balanceOf[msg.sender], "Insufficient balance");
        require(block.timestamp <= expirationTime[msg.sender], "Tokens expired");

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        expirationTime[_to] = block.timestamp + DURATION;

        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function checkExpiration(address _owner) public view returns (bool) {
        return block.timestamp > expirationTime[_owner];
    }

    function removeExpiredTokens(address _owner) public {
        require(checkExpiration(_owner), "Tokens not yet expired");
        balanceOf[_owner] = 0;
    }
}