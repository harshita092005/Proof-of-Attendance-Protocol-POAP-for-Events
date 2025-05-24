async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying POAP contract with account:", deployer.address);

  const POAP = await ethers.getContractFactory("POAP");
  const baseURI = "https://example.com/api/metadata/"; // Replace with your actual metadata base URI

  const poap = await POAP.deploy(baseURI);

  await poap.deployed();

  console.log("POAP deployed to:", poap.address);
}

main()
  .then(() => process.exit(0))
  .catch(err => {
    console.error(err);
    process.exit(1);
  });
