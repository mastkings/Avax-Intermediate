// Import necessary modules
const hre = require("hardhat");
const fs = require('fs');
const path = require('path');

/**
 * Deploys the MasterToken contract.
 */
async function deployContract() {
  const MasterToken = await hre.ethers.getContractFactory("MasterToken");
  const mastertoken = await MasterToken.deploy(); 
  await mastertoken.deployed();
  console.log("MasterToken deployed to:", mastertoken.address);
 
  return mastertoken.address; 
 } 

/**
 * Writes deployed contract address to a file.
 * @param {string} address - The contract address.
 */
function exportAddress(address) {
  const content = `export const MasterTokenAddress = '${address}';\n`;
  const filePath = path.join(__dirname, 'address.js'); 
  fs.writeFileSync(filePath, content);
 }
 
// Main function
async function main() {
  try {
    const address = await deployContract();
    exportAddress(address);
    process.exit(0);
  } catch (error) {
    console.error("Deployment failed:", error);
    process.exit(1);
  }
}

main();
