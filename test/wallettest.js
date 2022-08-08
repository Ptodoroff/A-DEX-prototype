const Dex = artifacts.require("Dex");
const Dogelon = artifacts.require("Dogelon");
const truffleAssert = require('truffle-assertions');
contract.skip ("Dex",accounts => {
    it ("shuld only be possible for owner to add tokens", async () =>{


        let dex = await Dex.deployed()
      
        let elon = await Dogelon.deployed()
      
    await truffleAssert.passes (
      
         dex.addToken(web3.utils.fromUtf8("ELON"),elon.address, {from: accounts[0]})
    )


    })
    it ("should handle deposits correctly", async () =>{


        let dex = await Dex.deployed()
      
        let elon = await Dogelon.deployed()
      
    await truffleAssert.passes (
      
         dex.addToken(web3.utils.fromUtf8("ELON"),elon.address, {from: accounts[0]})
    )


    })




})