import { ethers } from "hardhat";

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying with:", deployer.address);

  // 1. Deploy DigitalID
  const DigitalID = await ethers.getContractFactory("DigitalID");
  const digitalID = await DigitalID.deploy();
  await digitalID.waitForDeployment();
  console.log("DigitalID deployed to:", await digitalID.getAddress());

  // 2. Deploy VerifiableCredential
  const VerifiableCredential = await ethers.getContractFactory("VerifiableCredential");
  const vc = await VerifiableCredential.deploy();
  await vc.waitForDeployment();
  console.log("VerifiableCredential deployed to:", await vc.getAddress());

  // 3. Deploy DIDRegistry
  const DIDRegistry = await ethers.getContractFactory("DIDRegistry");
  const didRegistry = await DIDRegistry.deploy();
  await didRegistry.waitForDeployment();
  console.log("DIDRegistry deployed to:", await didRegistry.getAddress());

  // 4. Deploy ReputationScore
  const ReputationScore = await ethers.getContractFactory("ReputationScore");
  const reputation = await ReputationScore.deploy(await digitalID.getAddress());
  await reputation.waitForDeployment();
  console.log("ReputationScore deployed to:", await reputation.getAddress());

  // Grant issuer roles
  await digitalID.grantRole(await digitalID.ISSUER_ROLE(), deployer.address);
  await vc.grantRole(await vc.ISSUER_ROLE(), deployer.address);

  console.log("✅ Deployment completed!");
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});