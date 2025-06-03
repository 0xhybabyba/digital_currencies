pragma solidity ^0.8.0;

import  "./IERC20.sol";
import "./Owned.sol";
import "hardhat/console.sol";

contract ERC20 is IERC20, Owned{
    mapping (address => uint) balances;
    mapping (address => mapping(address => uint)) allowances;//sender => recepient => value
    string _name;
    string _symbol;
    uint _totalSupply; 

    constructor(string memory name_, string memory symbol_, uint totalSupply_, address distributor) {
        _name = name_;
        _symbol = symbol_;
        _totalSupply = totalSupply_;
        mint(distributor,_totalSupply);
    }

     function name() external view returns(string memory){
        return _name;
    }

    function symbol() external view returns(string memory){
        return _symbol;
    }

    function decimals() external pure returns(uint8){
        return 18; //1 testToken == 1 wei
    }

    modifier enoughtTokens(address from, uint amount){
        require(balanceOf(from) >= amount, "not enought tokens");
        _;
    }

    function mint(address to, uint amount) ownerOnly internal  {
        balances[to] += amount;
        emit Transfer(address(0), to, amount);
    }

    function burn(uint amount) enoughtTokens(msg.sender, amount) public{
        balances[msg.sender] -= amount;
        _totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    } 


    function balanceOf(address _owner) public  view returns (uint256 balance){
        return balances[_owner];
    }

    function totalSupply() external  view returns (uint){
        return _totalSupply;
    }

    function transfer(address _to, uint256 _value) enoughtTokens(msg.sender, _value) enoughtTokens(msg.sender, _value) external returns (bool success){
        balances[_to] += _value;
        balances[msg.sender] -= _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function allowance(address _owner, address _spender) public view returns (uint256 remaining){
        return allowances[_owner][_spender];
    }

    function approve(address spender, uint amount) public {
        allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
    }

    function transferFrom(address _from, address _to, uint256 _value) enoughtTokens(_from, _value) external returns (bool success){
        allowances[_from][msg.sender] -= _value;
        balances[_from] -= _value;
        balances[_to] += _value;
        emit Transfer(_from, _to, _value);
        return true;
    } 

}

