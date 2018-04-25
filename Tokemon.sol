pragma solidity ^0.4.18;

// ----------------------------------------------------------------------------
// ERC Token Standard #20 Interface
// ----------------------------------------------------------------------------
contract ERC20Interface {
    
    function totalSupply() constant public returns (uint256);
    function balanceOf(address _owner) constant public returns (uint256 balance);
    function allowance(address _owner, address _spender) public constant returns (uint remaining);
    function transfer (address _to, uint256 _value) public returns (bool success);
    function approve(address _spender, uint _amount) public returns (bool success);
    function transferFrom(address _from, address _to, uint256 _amount) public returns (bool success);

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}


contract Tokemon is ERC20Interface {

    uint256 private _totalSupply;
    string public name;
    string public symbol;
    uint256 public decimals;
    mapping (address => uint256) public balances;
    mapping (address => mapping (address => uint256)) public allowed;

  function Tokemon() public {
    symbol = "TM";
    name = "Tokemon";
    decimals = 18;
    _totalSupply = 151000000 * 10**uint(decimals);
    balances[msg.sender] = _totalSupply;
    emit Transfer(address(0), msg.sender, _totalSupply);
  }

  function totalSupply() constant public returns (uint256) {
      return _totalSupply;
  }

  function balanceOf(address _owner) constant public returns (uint256) {
      return balances[_owner];
  }

  function transfer (address _to, uint256 _value) public returns (bool success) {
      if ( 
      _to != 0x0 //prevents the transfer to 0x0 address
      && _value > 0 //prevents 0 value transactions from taking place
      && balances[msg.sender] >= _value //confirms there is enough balance to be sent
      && balances[_to] + _value > balances[_to]) //prevents overflows
    {
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
    return false;
  }
function approve(address _spender, uint _amount) public returns (bool success) {
      allowed[msg.sender][_spender] = _amount;
    emit Approval(msg.sender, _spender, _amount);
      return true;
  }

  function allowance(address _owner, address _spender) public constant returns (uint remaining){
      return allowed[_owner][_spender];
  }

  function transferFrom(address _from, address _to, uint256 _amount) public returns (bool success) {
    if (
      allowed[_from][msg.sender] >= _amount
      && balances[_from] >= _amount
      && _amount > 0) {
      allowed[_from][msg.sender] -= _amount;
      balances[_from] -= _amount;
      balances[_to] += _amount;
      return true;
    }
    return false;
  }

}
