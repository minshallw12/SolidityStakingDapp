pragma solidity  >= 0.4.22 <0.9.0;

contract Tether {

    string public name = "dummy_token";
    string public symbol = "dummy_token";
    unit public totalsupply = 100000000000000000;
    unit public decimal = 18;

    event Transfer(
        address indexed _from,
        address indexed _to,
        unit _value
    );

    event approve(
        address indexed _owner,
        address indexed _spender,
        unit _value
    );

    mapping(address => unit256) public balance;
    mapping(address => mapping(address=> unit256)) public allowance;

    constructor() public {
        balance [msg.sender] = totalsupply;
    }

    function transfer(address _to, unit256 _value) public returns(bool success){
        require(balance[msg.sender] >= _value);
        balance[msg.sender] -= _value;
        balance[_to] += _value;
        emit transfer(msg.sender, _to, _value);
        return true;
    }

    function approve(address _spender, unit256 _value) public returns(bool success) {
        allowance[msg.sender][_spender] = _value;
        emit approve(msg.sender, _spender, _value);
        return true;
    }

    function transerfrom(address _from, address _to, unin256 _value) public returns(bool success) {
        require(_value <= balance[_from]);
        require(_valeu <= allowance[_from][msg.sender]);
        balance[_from] -= _value;
        balance[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        emit transfer(_from, _to, _value);
        return true;
    }


}