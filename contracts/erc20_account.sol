// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

// We declare our contract, using a contract keyword.
contract ERC20ACCOUNT {

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);

    //We are setting the name of our token, its symbol and decimal.
    string public constant name = "ND Coin";
    string public constant symbol = "NDN";
    uint8 public constant decimals = 18;

    // We declare two mappings.
    // A mapping in Solidity is similar to a key-value pair. So in the balances, an address is the key while the uint256 (unsigned integer of 256 bits) is the value.
    mapping(address => uint256) balances;
    mapping(address => mapping (address => uint256)) allowed;

    //declaring the total supply
    uint256 totalSupply_;

// constructors are called when the class is being created
    constructor(uint256 total) {
      totalSupply_ = total;
      balances[msg.sender] = totalSupply_;
    }

    // Getting the balance of an owner.
    function balanceOf(address tokenOwner) public view returns (uint) {
      return balances[tokenOwner];
    } 

    // Transfer tokens to an account.
    function transfer(address receiver, uint numTokens) public returns (bool) {
      require(numTokens <= balances[msg.sender]);
      balances[msg.sender] -= numTokens;
      balances[receiver] += numTokens;
      emit Transfer(msg.sender, receiver, numTokens);
      return true;
    }

    //approval token transfer.
    function approve(address delegate, uint numTokens) public returns (bool) {
      allowed[msg.sender][delegate] = numTokens;
      emit Approval(msg.sender, delegate, numTokens);
      return true;
    }

    // Get the allowance status of an account
    function allowance(address owner, address delegate) public view returns (uint) {
      return allowed[owner][delegate];
    }

    // Transfer tokens from an account to another account
    function transferFrom(address owner, address buyer, uint numTokens) public returns (bool) {
      require(numTokens <= balances[owner]);
      require(numTokens <= allowed[owner][msg.sender]);
      balances[owner] -= numTokens;
      allowed[owner][msg.sender] -= numTokens;
      balances[buyer] += numTokens;
      emit Transfer(owner, buyer, numTokens);
      return true;
    }
}
