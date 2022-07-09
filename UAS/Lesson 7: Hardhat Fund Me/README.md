# Hardhat Fund Me


# Getting Started

## Requirements

- [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
  - You'll know you did it right if you can run `git --version` and you see a response like `git version x.x.x`
- [Nodejs](https://nodejs.org/en/)
  - You'll know you've installed nodejs right if you can run:
    - `node --version` and get an ouput like: `vx.x.x`
- [Yarn](https://yarnpkg.com/getting-started/install) instead of `npm`
  - You'll know you've installed yarn right if you can run:
    - `yarn --version` and get an output like: `x.x.x`
    - You might need to [install it with `npm`](https://classic.yarnpkg.com/lang/en/docs/install/) or `corepack`

## Quickstart

```
git clone https://github.com/PatrickAlphaC/hardhat-fund-me-fcc
cd hardhat-fund-me-fcc
yarn
```
![image](https://user-images.githubusercontent.com/101384498/178106527-8566d0a0-8c11-48d4-a0ca-1c523201ea95.png)

## Typescript

For the typescript edition, run:

```
git checkout typescript
```
![image](https://user-images.githubusercontent.com/101384498/178106564-c36fc552-874c-429e-bef9-bca7a6c0a9f1.png)

### Optional Gitpod

If you can't or don't want to run and install locally, you can work with this repo in Gitpod. If you do this, you can skip the `clone this repo` part.

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#github.com/PatrickAlphaC/hardhat-fund-me-fcc)

# Usage

Deploy:

```
yarn hardhat deploy
```
![image](https://user-images.githubusercontent.com/101384498/178106601-818b8191-4586-4fbe-8c4b-57b70cbf59e5.png)


## Testing

```
yarn hardhat test
```
![image](https://user-images.githubusercontent.com/101384498/178106608-67c49d09-e172-4e97-951e-68a0272a6966.png)


### Test Coverage

```
yarn hardhat coverage
```
![image](https://user-images.githubusercontent.com/101384498/178106621-92e44ebb-7645-4cd6-9ab2-302b225b953e.png)


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
![image](https://user-images.githubusercontent.com/101384498/178106633-a20ee807-afd0-4352-99cb-38b22659a7fb.png)


## Scripts

After deploy to a testnet or local net, you can run the scripts. 

```
yarn hardhat run scripts/fund.js
```

or
```
yarn hardhat run scripts/withdraw.js
```
![image](https://user-images.githubusercontent.com/101384498/178106638-e4277588-06bd-451f-ab52-e2c00db5b8ee.png)


## Estimate gas

You can estimate how much gas things cost by running:

```
yarn hardhat test
```
![image](https://user-images.githubusercontent.com/101384498/178106666-85b60169-b5cc-47fd-bc67-df5b6f6fc59b.png)


And you'll see and output file called `gas-report.txt`

### Estimate gas cost in USD

To get a USD estimation of gas cost, you'll need a `COINMARKETCAP_API_KEY` environment variable. You can get one for free from [CoinMarketCap](https://pro.coinmarketcap.com/signup). 

Then, uncomment the line `coinmarketcap: COINMARKETCAP_API_KEY,` in `hardhat.config.js` to get the USD estimation. Just note, everytime you run your tests it will use an API call, so it might make sense to have using coinmarketcap disabled until you need it. You can disable it by just commenting the line back out. 


## Verify on etherscan

If you deploy to a testnet or mainnet, you can verify it if you get an [API Key](https://etherscan.io/myapikey) from Etherscan and set it as an environemnt variable named `ETHERSCAN_API_KEY`. You can pop it into your `.env` file as seen in the `.env.example`.

In it's current state, if you have your api key set, it will auto verify kovan contracts!

However, you can manual verify with:

```
yarn hardhat verify --constructor-args arguments.js DEPLOYED_CONTRACT_ADDRESS
```
![image](https://user-images.githubusercontent.com/101384498/178106687-5a9a17c7-8817-41c8-a18c-433ea02d020d.png)


# Linting

To check linting / code formatting:
```
yarn lint
```
or, to fix: 
```
yarn lint:fix
```
![image](https://user-images.githubusercontent.com/101384498/178106696-230feee9-180b-4c7c-b319-3bd25fdb66c7.png)


# Formatting 

```
yarn format
```
![image](https://user-images.githubusercontent.com/101384498/178106702-27df6461-50ea-43ac-88d9-2c0f057af94f.png)



# Thank you!
