import { ethers } from "hardhat";

async function main() {
  const [deployer, user1, user2, issuer] = await ethers.getSigners();

  // Deploy contracts (simplified)
  const DigitalID = await ethers.getContractFactory("DigitalID");
  const digitalID = await DigitalID.deploy();
  await digitalID.grantRole(await digitalID.ISSUER_ROLE(), issuer.address);

  const ReputationScore = await ethers.getContractFactory("ReputationScore");
  const reputation = await ReputationScore.deploy(await digitalID.getAddress());

  // Issue DIDs
  await digitalID.connect(issuer).issueDID(user1.address, "did:ethr:0xUser1...");
  await digitalID.connect(issuer).issueDID(user2.address, "did:ethr:0xUser2...");

  // Add reputation
  await reputation.updateScore(user1.address, 920, "financial");
  await reputation.updateScore(user1.address, 850, "civic");
  await reputation.updateScore(user2.address, 450, "financial");

  console.log("🎉 Demo data seeded!");
  console.log("User1 Score:", await reputation.getScore(user1.address));
  console.log("User2 Score:", await reputation.getScore(user2.address));
}

main().catch(console.error);