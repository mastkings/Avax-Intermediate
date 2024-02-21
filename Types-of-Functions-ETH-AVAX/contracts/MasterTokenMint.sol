// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract MasterTokenMint {

    // Declare public variables
    string public tokenName;
    string public tokenSymbol;
    uint256 public totalSupply;
    address public owner;

    // Create a mapping of addresses to balances
    mapping(address => uint256) public balance;

    // Constructor function that sets the token name, symbol, and owner
    constructor() {
        tokenName = "Master Token Mint";
        tokenSymbol = "MTM";
        owner = msg.sender;
    }

    // Modifier that only allows the owner to execute a function
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action!");
        _;
    }

    // This function allows only the owner of the contract to mint new tokens
    function mint(address _recipient, uint256 _amount) public onlyOwner {
        // Increase the total supply
        totalSupply += _amount;
        // Increase the balance of the specified address
        balance[_recipient] += _amount;
    }

    // This function allows anyone to burn their own tokens
    // It takes one argument: the amount of tokens to burn
    function burn(uint256 _amount) public {
        // Make sure the sender has enough tokens to burn
        require(balance[msg.sender] >= _amount, "Insufficient balance");
        // Subtract the burn amount from the total supply
        totalSupply -= _amount;
        // Subtract the burn amount from the sender's balance
        balance[msg.sender] -= _amount;
    }

    // Function that allows anyone to transfer tokens to another address
    // This function transfers tokens from the sender to the recipient
    // It takes two arguments: the recipient's address and the amount of tokens to transfer
    function transfer(address _recipient, uint256 _amount) public {
        // Make sure the sender is not the recipient
        require(msg.sender != _recipient,"You can not transfer token(s) to yourself!");
        // Make sure the sender has enough tokens to transfer
        require(balance[msg.sender] >= _amount, "Transfer amount exceeds balance");
        // Subtract the transfer amount from the sender's balance
        balance[msg.sender] -= _amount;
        // Add the transfer amount to the recipient's balance
        balance[_recipient] += _amount;
    }
}

// contract MasterToken {

//     string public constant NAME = "Master Token";
//     string public constant SYMBOL = "MTT";
//     address public immutable admin;

//     uint256 public circulatingSupply;
//     mapping(address => uint256) public accountBalances;

//     /**
//      * @dev Assigns the `admin` role to the account that deploys the contract.
//      */
//     constructor() {
//         admin = msg.sender;
//     }

//     /**
//      * @dev Ensures only the admin can call certain functions.
//      */
//     modifier onlyAdmin() {
//         require(msg.sender == admin, "MasterToken: caller is not the admin");
//         _;
//     }

//     /**
//      * @dev Creates `amount` new tokens and assigns them to `account`.
//      *
//      * Requirements:
//      * - The function caller must be the admin.
//      */
//     function createToken(address account, uint256 amount) public onlyAdmin {
//         require(account != address(0), "MasterToken: cannot mint to the zero address");

//         circulatingSupply += amount;
//         accountBalances[account] += amount;
//     }

//     /**
//      * @dev Eliminates `amount` tokens from the caller's balance.
//      *
//      * Requirements:
//      * - Caller must have at least `amount` tokens.
//      */
//     function eliminate(uint256 amount) public {
//         require(accountBalances[msg.sender] >= amount, "MasterToken: burn amount exceeds balance");

//         circulatingSupply -= amount;
//         accountBalances[msg.sender] -= amount;
//     }

//     /**
//      * @dev Moves `amount` tokens to `account` from the caller.
//      *
//      * Requirements:
//      * - Caller cannot be the same as `account`.
//      * - Caller must have at least `amount` of tokens.
//      */
//     function sendToken(address account, uint256 amount) public {
//         require(msg.sender != account, "MasterToken: cannot Send to the same address");
//         require(accountBalances[msg.sender] >= amount, "MasterToken: Send amount exceeds balance");

//         accountBalances[msg.sender] -= amount;
//         accountBalances[account] += amount;
//     }
// }
// #