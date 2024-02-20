// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * Welcome to our little demo on error handling in Solidity!
 * We're going to cover a few patterns like require, assert, and some custom error messages.
 * Let's dive in and make our smart contracts more robust and user-friendly!
 */
contract ErrorHandling {
    // Here's where we keep track of our contract's balance. Starting at zero, naturally.
    uint public balance = 0;

    // Define some errors that are more specific than your average error message.
    // This way, users know exactly what went wrong.
    error DepositAmountNonPositive(); 
    error WithdrawalAmountNonPositive(); 
    error InsufficientBalance(); 
    error DivisionByZero(); 

    // Ready to make a deposit? Let's make sure it's a positive amount first.
    function depositRequire(uint _amount) public {
        if (_amount <= 0) revert DepositAmountNonPositive(); 
        balance += _amount; 
    }

    // Time to withdraw? Let's double-check you've got enough in the tank.
    function withdrawRequire(uint _amount) public {
        if (_amount <= 0) revert WithdrawalAmountNonPositive(); 
        if (_amount > balance) revert InsufficientBalance(); 
        balance -= _amount; 
    }

    // Fancy some division? Let's not divide by zero and cause a black hole.
    function divideRequire(uint _numerator, uint _denominator) public pure returns (uint) {
        if (_denominator == 0) revert DivisionByZero(); 
        return _numerator / _denominator; 
    }

    // Here's a little demo of assert - this one's set up to fail to show you what happens.
    function assertFunction() public pure {
        uint result = divideRequire(10, 2); 
        assert(result == 6); 
    }

    // Ever need to just stop everything and revert? Here's how you might do it.
    function revertFunction() public pure {
        uint result = divideRequire(10, 2); 
        if (result == 5) {
            revert("This function always reverts"); 
        }
    }
}
