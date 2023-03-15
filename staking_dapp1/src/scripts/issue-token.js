const staking_dapp = artifacts.require('staking_dapp')

module.exports = async function(callback) {
    let stakingdapp = await staking_dapp.deploy()
    await stakingdapp.issuedummy()

    console.log("dummy token issue")
    callback()
}