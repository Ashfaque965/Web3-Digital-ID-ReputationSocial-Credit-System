// demo.ts
import { ethers } from "hardhat";

async function demo() {
  console.log("🌍 World Digital ID Demo Starting...");

  const DigitalID = await ethers.getContractFactory("DigitalID");
  const digitalID = await DigitalID.deploy();
  // ... (full flow from previous seed script)

  console.log("✅ Demo completed successfully!");
}

demo();