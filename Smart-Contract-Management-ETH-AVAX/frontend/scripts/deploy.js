// imports
const hre = require("hardhat");
const fs = require('fs');

// funtion to deploy the contracts
async function main() {

  //deploy the token
  const MAVT = await hre.ethers.getContractFactory("MasterAvaxToken");
  const mavt = await MAVT.deploy();
  await mavt.deployed();
  console.log("mavt deployed to:", mavt.address);


  // export the addresses
  fs.writeFileSync('src/abi/address.js', `
    export const mavtAddress = "$mavt.address}"

  `)
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
