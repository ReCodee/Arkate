const contracts = artifacts.require("Arks");

module.exports = function (deployer) {
  deployer.deploy(contracts);
};