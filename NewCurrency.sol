//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
contract Coin{
    address public minter;
    mapping(address => uint) public balances;

    event Sent(address _from, address _to, uint _amount);
    event Mint(address _mint, uint _amount);

    constructor(){
        minter = msg.sender;
    }
    modifier onlyOwner(){
        require(minter == msg.sender, "Unauthorised access");
        _;
    }

    function mint(address _minter, uint _amount) external onlyOwner{
        require(_amount < type(uint).max);

        balances[_minter] += _amount;
        emit Mint(msg.sender, _amount);
    }
    function send(address _receiver, uint _amount) external onlyOwner{  
            balances[_receiver] += _amount;
            balances[minter] -= _amount;
            emit Sent(msg.sender, _receiver, _amount);
    }
}
