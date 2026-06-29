import { expect } from "chai";
import { ethers } from "hardhat";

describe("ReputationScore", function () {
  it("Should update and read score", async function () {
    const [owner, user, issuer] = await ethers.getSigners();

    const DigitalID = await ethers.getContractFactory("DigitalID");
    const digitalID = await DigitalID.deploy();
    await digitalID.grantRole(await digitalID.ISSUER_ROLE(), issuer.address);
    await digitalID.connect(issuer).issueDID(user.address, "did:example");

    const ReputationScore = await ethers.getContractFactory("ReputationScore");
    const reputation = await ReputationScore.deploy(await digitalID.getAddress());

    await reputation.updateScore(user.address, 850, "financial");

    expect(await reputation.getScore(user.address)).to.equal(850);
  });
});