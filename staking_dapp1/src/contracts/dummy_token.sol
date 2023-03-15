// SPDX-License-Identifier: MIT
pragma solidity  >= 0.4.22 <0.9.0;

contract dummy {

    string public name = "dummy_token";
    string public symbol = "dummy_token";
    uint public totalsupply = 100000000000000000;
    uint public decimal = 18;

    event transfer(
        address indexed _from,
        address indexed _to,
        uint _value
    );

    event approve(
        address indexed _owner,
        address indexed _spender,
        uint _value
    );

    mapping(address => uint256) public balance;
    mapping(address => mapping(address=> uint256)) public allowance;

    constructor() {
        balance [msg.sender] = totalsupply;
    }

    function transferIt(address _to, uint256 _value) public returns(bool success){
        require(balance[msg.sender] >= _value);
        balance[msg.sender] -= _value;
        balance[_to] += _value;
        emit transfer(msg.sender, _to, _value);
        return true;
    }

    function approveIt(address _spender, uint256 _value) public returns(bool success) {
        allowance[msg.sender][_spender] = _value;
        emit approve(msg.sender, _spender, _value);
        return true;
    }

    function transerfrom(address _from, address _to, uint256 _value) public returns(bool success) {
        require(_value <= balance[_from]);
        require(_value <= allowance[_from][msg.sender]);
        balance[_from] -= _value;
        balance[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        emit transfer(_from, _to, _value);
        return true;
    }


}