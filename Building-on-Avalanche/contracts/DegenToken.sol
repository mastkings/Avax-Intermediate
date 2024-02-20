// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
//import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
//import "hardhat/console.sol";

/**
 * @title DegenToken
 * @dev Implementation of an ERC20 token with additional features for item redemption.
 */
contract DegenToken is ERC20, Ownable {

    // Stores redemption rates for various items, identified by their IDs.
    mapping(uint256 => uint256) private _redemptionRates;

    // Emitted when an item is successfully redeemed.
    event ItemRedeemed(address indexed user, uint256 itemId, uint256 amount);

    // Initializes the token with a name and symbol.
    constructor() ERC20("Degen Token", "DGN") {}

    /**
     * @dev Mints tokens to a specified address. Restricted to contract owner.
     */
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    /**
     * @dev Redeems tokens for items, burning tokens in the process.
     */
    function redeem(uint256 itemId, uint256 amount) public {
        uint256 requiredTokens = _getRequiredTokensForRedemption(itemId, amount);
        _burn(msg.sender, requiredTokens);
        emit ItemRedeemed(msg.sender, itemId, amount);
    }

    /**
     * @dev Burns a specified amount of tokens from the sender's account.
     */
    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    /**
     * @dev Sets the redemption rate for a specific item. Restricted to contract owner.
     */
    function setRedemptionRate(uint256 itemId, uint256 rate) public onlyOwner {
        _redemptionRates[itemId] = rate;
    }

    /**
     * @dev Retrieves the redemption rate for a specific item.
     */
    function getRedemptionRate(uint256 itemId) public view returns (uint256) {
        return _redemptionRates[itemId];
    }

    // Private helper function to calculate the required tokens for redemption.
    function _getRequiredTokensForRedemption(uint256 itemId, uint256 amount) private view returns (uint256) {
        require(_redemptionRates[itemId] > 0, "Invalid item ID");
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");
        return _redemptionRates[itemId] * amount;
    }
}
