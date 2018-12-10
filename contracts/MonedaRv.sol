pragma solidity ^0.4.2;

contract MonedaRv {

	string public name = 'MonedaRv';
	string public symbol = 'RV';
	string public standard = 'RV Token 1.0';
	uint256 public totalSupply;

	mapping(address => uint256) public balanceOf;
	mapping(address => mapping (address => uint256)) public allowance;
	


	event Transfer(
		address indexed _from,
		address indexed _to,
		uint _value
	);

	event Approval(
		address indexed _owner,
		address indexed _spender,
		uint _value
	);

	constructor (uint256 _initialSupply) public {
		//  Setting the initial supply to the person who deployed the contract
		balanceOf[msg.sender] = _initialSupply;

		totalSupply = _initialSupply;
	}

	function transfer(address _to, uint256 _value) public returns (bool success) {
		require(balanceOf[msg.sender] >= _value);
		balanceOf[msg.sender] -= _value;
		balanceOf[_to] += _value;
		
		Transfer(msg.sender, _to, _value);

		return true;
	}

	function approve(address _spender, uint256 _value) public returns (bool success) {
		allowance[msg.sender][_spender] = _value;
		Approval(msg.sender, _spender, _value);
		return true;
	}

	function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
		require(balanceOf[_from] >= _value);
		require(allowance[_from][msg.sender] >= _value);
		balanceOf[_to] += _value;
		balanceOf[_from] -= _value;
		allowance[_from][msg.sender] -= _value;

		Transfer(_from, _to, _value);
		return true;
	}
}