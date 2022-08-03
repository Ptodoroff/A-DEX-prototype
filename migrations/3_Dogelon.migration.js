const Dogelon = artifacts.require("Dogelon");
const Dex = artifacts.require ("Dex");

module.exports =async  function (deployer, network, accounts) {                         /* apart form deployer, we also include network and more importantly accounts in order to be able to make use of accounts[0] when declarin the elonbalance variable  */
 await  deployer.deploy(Dogelon);
  let dex = await Dex.deployed()
  let elon = await Dogelon.deployed()
  await elon.approve(dex.address,300)
  await dex.addToken(web3.utils.fromUtf8("ELON"),elon.address)
  await dex.deposit(100, web3.utils.fromUtf8("ELON"))
  let elonBalance = await dex.balances(accounts[0],web3.utils.fromUtf8("ELON"));
  console.log(elonBalance);
};


/*
We added some mo functionality in the module exports function in order to predeploy our contract with our ELON token being preapprove, added to the tokenMapping and tokenList of the Wallet contract.
We also deposited some coins and defined a variable to display our balance upon deployment 


BEWARE - THE SCOPE OF THIS FILE HAS NOTHING TO DO WHEN WE ENTER TRUFFLE (DEVELOP) MODE. THIS MEANS THAT AFTER MIGRATING, WE WILL HAVE TO ASSIGN A VARIABLE TO THE DEPLOYED CONTRACT WITH WHICH WE WILL INTERACT

E.G.  let wallet = await wallet.deployed()


Although we have it in this file, this file only "hands over" the contract with the depposited and approved token, but its variables hav enothing to do with the truffle environment once we are in truffle (develop)







*/