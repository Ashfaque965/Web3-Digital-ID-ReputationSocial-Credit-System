#!/bin/bash
echo "🌍 Starting World Digital ID & Reputation System..."

# Start Hardhat node in background
npx hardhat node > /dev/null 2>&1 &
echo "✅ Local blockchain running on http://127.0.0.1:8545"

sleep 4

# Deploy contracts
echo "Deploying smart contracts..."
npx hardhat run scripts/deploy.ts --network localhost

# Seed demo data
echo "Seeding demo users..."
npx hardhat run scripts/seedDemoData.ts --network localhost

echo "🎉 System ready! Starting frontend..."
cd frontend && npm run dev