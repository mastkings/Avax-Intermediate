# AVAX-Intermediate-Types-of-Functions

This is the third project in AVAX-Intermediate, in this project I am tasked to create a smart contract to create my own token on a local HardHat network. Once I have created the contract, I should be able to use remix to interact with it. From remix, the contract owner should be able to mint tokens to a provided address. Any user should be able to burn and transfer tokens.

## Getting Started

### Requirement

- Remix IDE
- Hardhat

### Executing program

#### Remix IDE

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at [Remix IDE](https://remix.ethereum.org/).

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., HelloWorld.sol). Copy and paste the code into the file.

#### Hardhat

Download the codes by downloading the entire repository which will give you access to other contencts of the repository.In the project directory,  run:

```shell

 yarn install

```

Start Local Hardhat Node:
After installing the dependencies, run the following command to start the local Hardhat node:

```shell

yarn hardhat node

```

Deploy the Contract:
Open a second terminal and deploy the contract on the local Hardhat node using the following command:

```shell

yarn hardhat run scripts/deploy.js --network localhost

```

Configure MetaMask:
   - Add Hardhat Network: In MetaMask, add a new network with the following settings:
     - Network Name: Hardhat
     - New RPC URL: http://localhost:8545
     - Chain ID: 1337

   - Import Account: In the first terminal where the Hardhat node is running, copy any of the private keys (preferably the first one) and import it into MetaMask.

After installing the dependences, run the test file by using the following command:

```shell

yarn hardhat test
```

## Author

[[Kings](https://github.com/mastkings)] 

## License

This project is licensed under the [MIT License](LICENSE).
