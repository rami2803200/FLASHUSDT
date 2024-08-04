const FlashUSDT = artifacts.require("FlashUSDT");

module.exports = function(deployer) {
  deployer.deploy(FlashUSDT, 1000000); // Deploy with initial supply of 1,000,000 tokens
};
