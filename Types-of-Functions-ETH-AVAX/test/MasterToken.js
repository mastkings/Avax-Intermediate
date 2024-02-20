const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("MasterToken", function () {
    let MasterToken;
    let masterToken;
    let admin;
    let user1;
    let user2;
    let addrs;
    const initialAmount = 1000;

    beforeEach(async function () {
        MasterToken = await ethers.getContractFactory("MasterToken");
        [admin, user1, user2, ...addrs] = await ethers.getSigners();
        masterToken = await MasterToken.deploy();
        await masterToken.deployed();
    });

    describe("Deployment", function () {
        it("should set the right admin", async function () {
            expect(await masterToken.admin()).to.equal(admin.address);
        });
    });

    describe("createToken", function () {
        it("should only allow admin to create tokens", async function () {
            await expect(masterToken.connect(user1).createToken(user1.address, 100))
                .to.be.revertedWith("MasterToken: caller is not the admin");

            await expect(masterToken.connect(admin).createToken(user1.address, 100))
                .not.to.be.reverted;
        });

        it("should increase circulating supply when tokens are created", async function () {
            const supplyBefore = await masterToken.circulatingSupply();
            await masterToken.connect(admin).createToken(user1.address, initialAmount);
            const supplyAfter = await masterToken.circulatingSupply();
            expect(supplyAfter).to.equal(supplyBefore.add(initialAmount));
        });
    });

    describe("eliminate", function () {
        beforeEach(async function () {
            await masterToken.connect(admin).createToken(user1.address, initialAmount);
        });

        it("should allow token holders to burn tokens", async function () {
            const burnAmount = 100;
            await masterToken.connect(user1).eliminate(burnAmount);
            const balanceAfter = await masterToken.accountBalances(user1.address);
            expect(balanceAfter).to.equal(initialAmount - burnAmount);
        });

        it("should decrease circulating supply when tokens are burned", async function () {
            const burnAmount = 100;
            const supplyBefore = await masterToken.circulatingSupply();
            await masterToken.connect(user1).eliminate(burnAmount);
            const supplyAfter = await masterToken.circulatingSupply();
            expect(supplyAfter).to.equal(supplyBefore.sub(burnAmount));
        });
    });

    describe("sendToken", function () {
        beforeEach(async function () {
            await masterToken.connect(admin).createToken(user1.address, initialAmount);
        });

        it("should transfer tokens correctly", async function () {
            const transferAmount = 100;
            await masterToken.connect(user1).sendToken(user2.address, transferAmount);
            const balanceUser2 = await masterToken.accountBalances(user2.address);
            expect(balanceUser2).to.equal(transferAmount);
        });

        it("should not allow transfers to the same address", async function () {
            const transferAmount = 100;
            await expect(masterToken.connect(user1).sendToken(user1.address, transferAmount))
                .to.be.revertedWith("MasterToken: cannot transfer to the same address");
        });

        it("should not allow transfers if insufficient balance", async function () {
            const transferAmount = initialAmount + 1;
            await expect(masterToken.connect(user1).sendToken(user2.address, transferAmount))
                .to.be.revertedWith("MasterToken: transfer amount exceeds balance");
        });
    });
});


