
# Hardhat ERC20s

## Requirements

- [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
  - You'll know you did it right if you can run `git --version` and you see a response like `git version x.x.x`
- [Nodejs](https://nodejs.org/en/)
  - You'll know you've installed nodejs right if you can run:
    - `node --version` and get an ouput like `vx.x.x`
- [Yarn](https://classic.yarnpkg.com/lang/en/docs/install/) instead of `npm`
  - You'll know you've installed yarn right if you can run:
    - `yarn --version` And get an output like `x.x.x`
    - You might need to install it with npm

## Quickstart

```
git clone https://github.com/PatrickAlphaC/hardhat-erc20-fcc
cd hardhat-erc20-fcc
yarn
```
![image](https://user-images.githubusercontent.com/101384498/178108051-7b3c72cd-7bc0-488b-bd03-f35e6e8a415f.png)


### Typescript (Optional)

```
git checkout typescript
```
![image](https://user-images.githubusercontent.com/101384498/178108060-65c610a0-1365-4ec6-8062-e9a0d275cc8b.png)


### Optional Gitpod

If you can't or don't want to run and install locally, you can work with this repo in Gitpod. If you do this, you can skip the `clone this repo` part.

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#github.com/PatrickAlphaC/hardhat-erc20-fcc)


# Usage

Deploy:

```
yarn hardhat deploy
```
![image](https://user-images.githubusercontent.com/101384498/178108072-e764e883-fa7e-4ef7-889a-95110990a959.png)


# Deployment to a testnet or mainnet

1. Setup environment variabltes

You'll want to set your `KOVAN_RPC_URL` and `PRIVATE_KEY` as environment variables. You can add them to a `.env` file, similar to what you see in `.env.example`.

- `PRIVATE_KEY`: The private key of your account (like from [metamask](https://metamask.io/)). **NOTE:** FOR DEVELOPMENT, PLEASE USE A KEY THAT DOESN'T HAVE ANY REAL FUNDS ASSOCIATED WITH IT.
  - You can [learn how to export it here](https://metamask.zendesk.com/hc/en-us/articles/360015289632-How-to-Export-an-Account-Private-Key).
- `KOVAN_RPC_URL`: This is url of the kovan testnet node you're working with. You can get setup with one for free from [Alchemy](https://alchemy.com/?a=673c802981)

2. Get testnet ETH

Head over to [faucets.chain.link](https://faucets.chain.link/) and get some tesnet ETH. You should see the ETH show up in your metamask.

3. Deploy

```
yarn hardhat deploy --network kovan
```
![image](https://user-images.githubusercontent.com/101384498/178108085-19039030-13ae-4f1d-9bc4-998f90bb7b1c.png)


## Verify on etherscan

If you deploy to a testnet or mainnet, you can verify it if you get an [API Key](https://etherscan.io/myapikey) from Etherscan and set it as an environemnt variable named `ETHERSCAN_API_KEY`. You can pop it into your `.env` file as seen in the `.env.example`.

In it's current state, if you have your api key set, it will auto verify kovan contracts!

However, you can manual verify with:

```
yarn hardhat verify --constructor-args arguments DEPLOYED_CONTRACT_ADDRESS
```
![image](https://user-images.githubusercontent.com/101384498/178108095-a224b791-98ee-4195-b65e-499bae1d2cee.png)


# Thank you!
