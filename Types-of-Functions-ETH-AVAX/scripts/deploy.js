// Import necessary modules
const hre = require("hardhat");
const fs = require('fs');
const path = require('path');

/**
 * Deploys the MasterTokenMint contract.
 */
async function deployContract() {
  const MasterTokenMint = await hre.ethers.getContractFactory("MasterTokenMint");
  const mastertokenmint = await MasterTokenMint.deploy(); 
  await mastertokenmint.deployed();
  console.log("MasterTokenMint deployed to:", mastertokenmint.address);
 
  return mastertokenmint.address; 
 } 

/**
 * Writes deployed contract address to a file.
 * @param {string} address - The contract address.
 */
function exportAddress(address) {
  const content = `export const MasterTokenMintAddress = '${address}';\n`;
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
