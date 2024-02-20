require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config({ path: ".env" }); // This gets the environment variables

module.exports = {
  solidity: "0.8.19",
  networks: {
    fuji: {
      url: "https://lingering-dark-flower.avalanche-testnet.quiknode.pro/ee5ec630dd02f6e21ede4b28c611765b08bf3f4f/ext/bc/C/rpc/",
      accounts: [""],
    },
  },
};
