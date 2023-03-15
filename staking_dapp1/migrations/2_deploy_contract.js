const dummy_token = artifacts.require("dummy_token");
const Tether_token = artifacts.require("Tether_token");
const staking_dapp = artifacts.require("staking_dapp");

module.export = async function(deployer, network, accounts) {
    await deployer.deploy(Tether_token)
    const tether_token = await Tether_token.deployed();

    await deployer.deploy(dummy_token)
    const dummy_token = await dummy_token.deployed();

    await deployer.deploy(staking_token, dummy_token.address, tether_token.address)
    const staking_token = await Tether_token.deployed();

    await dummy_token.transfer(staking_dapp.address, "100000000000000000")

    await tether_token.transfer(account[1], '1000000000000000000')
}