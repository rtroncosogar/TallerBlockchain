pragma solidity ^0.4.22;

import "./EIP20Interface.sol";

contract EIP is EIP20Interface {
  	uint256 constant private MAX_UINT256 = 2**256 - 1;

	mapping (address => uint256) public balances;
	mapping (address => mapping (address => uint256)) public allowed;

	string public name;
	string public symbol;
	uint8 public decimals; 



  constructor(uint _initialAmount, string _name, string _symbol, uint8 _decimals ) public 
  {
	decimals = _decimals;
	symbol = _symbol;
	name = _name;
	totalSupply = _initialAmount;
	balances[msg.sender] = _initialAmount;	
	}

	function balanceOf(address _owner) public view returns(uint256){
		return balances[_owner];
	}

	function transfer(address _to, uint256 _value) public returns (bool success){
		require(balances[msg.sender] >= _value);
		balances[msg.sender] -= _value;
		balances[_to] += _value;
		emit Transfer(msg.sender, _to, _value);
		return true;
	}

	function transferFrom(address _from, address _to, uint256 _value) public returns (bool success){
		uint256 allowance = allowed[_from][msg.sender];
		require(balances[_from] >= _value && allowance >= _value && allowance < MAX_UINT256);
		allowed[_from][msg.sender] -= _value;
		balances[_from] -= _value;
		balances[_to] += _value;
		emit Transfer(_from, _to, _value);
		return true;		
	}

	function approve(address _spender, uint _value) public returns(bool success) {
		allowed[msg.sender][_spender] = _value;
		emit Approval(msg.sender, _spender, _value);
		return true;
	}

	function allowance(address _owner, address _spender) public view returns(uint256 remaining){
		return allowed[_owner][_spender];
	}
}