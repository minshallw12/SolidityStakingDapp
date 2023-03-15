// SPDX-License-Identifier: MIT
pragma solidity  >= 0.4.22 <0.9.0;
import "./dummy_token.sol";
import "./tether_token.sol";

contract staking_dapp{

    string public name = "staking_dapp";
    address public owner;
    dummy public dummy_token;
    Tether public tether_token;

    address[] public stakers;
    mapping(address => uint) public stakingBalance;
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaked;

    constructor (dummy _dummytoken, Tether _tethertoken) public {
        dummy_token = _dummytoken;
        tether_token = _tethertoken;
        owner = msg.sender;
    }

    function stakeToken(uint _amount) public {
        require(_amount > 0, "amount cannot be zero");
        tether_token.transferfrom(msg.sender, address(this), _amount);
        stakingBalance[msg.sender] = stakingBalance[msg.sender] + _amount;

        if (!hasStaked[msg.sender]) {
            stakers.push(msg.sender);
        }

        isStaking[msg.sender] = true;
        hasStaked[msg.sender] = true;

    }

    function unstakeToken() public{
        uint balance = stakingBalance[msg.sender];
        require(balance > 0, "staking balance is zero");
        tether_token.transfer(msg.sender, balance);
        stakingBalance[msg.sender] = 0;
        isStaking[msg.sender] = false;
    }

    function issueDummy() public {

        require(msg.sender == owner, "caller must be the owner");
        for(uint i=0; i<stakers.length; i++) {
            address recipient = stakers[i];
            uint balance = stakingBalance[recipient];
            if(balance > 0) {
                dummy_token.transfer(recipient, balance);
            }
        }
    }

}