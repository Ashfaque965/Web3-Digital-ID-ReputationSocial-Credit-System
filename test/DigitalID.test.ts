import { expect } from "chai";
import { ethers } from "hardhat";

describe("DigitalID", function () {
  it("Should issue and revoke DID", async function () {
    const [owner, user, issuer] = await ethers.getSigners();

    const DigitalID = await ethers.getContractFactory("DigitalID");
    const digitalID = await DigitalID.deploy();

    await digitalID.grantRole(await digitalID.ISSUER_ROLE(), issuer.address);

    const didUri = "did:ethr:0x123...";
    await digitalID.connect(issuer).issueDID(user.address, didUri);

    const identity = await digitalID.identities(user.address);
    expect(identity.isActive).to.equal(true);
    expect(identity.didUri).to.equal(didUri);

    await digitalID.connect(issuer).revokeDID(user.address);
    const revoked = await digitalID.identities(user.address);
    expect(revoked.isActive).to.equal(false);
  });
});