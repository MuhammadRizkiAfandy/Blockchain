# Hardhat DeFi 

This is a section of the Javascript Blockchain/Smart Contract FreeCodeCamp Course.

*[⌨️ (19:16:13) Lesson 13: Hardhat DeFi & Aave](https://www.youtube.com/watch?v=gyMwXuJrbJQ&t=69373s)*

[Full Repo](https://github.com/smartcontractkit/full-blockchain-solidity-course-js)

- [Hardhat DeFi](#hardhat-defi)
- [Getting Started](#getting-started)
  - [Requirements](#requirements)
  - [Quickstart](#quickstart)
  - [Typescript](#typescript)
    - [Optional Gitpod](#optional-gitpod)
- [Usage](#usage)
  - [Testing](#testing)
- [Running on a testnet or mainnet](#running-on-a-testnet-or-mainnet)
- [Linting](#linting)
  - [Formatting](#formatting)
- [Thank you!](#thank-you)

# Getting Started

## Requirements

- [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
  - You'll know you did it right if you can run `git --version` and you see a response like `git version x.x.x`
- [Nodejs](https://nodejs.org/en/)
  - You'll know you've installed nodejs right if you can run:
    - `node --version` and get an ouput like: `vx.x.x`
- [Yarn](https://classic.yarnpkg.com/lang/en/docs/install/) instead of `npm`
  - You'll know you've installed yarn right if you can run:
    - `yarn --version` and get an output like:`x.x.x`
    - You might need to install it with npm

## Quickstart

```
git clone https://github.com/PatrickAlphaC/hardhat-defi-fcc
cd hardhat-defi-fcc
yarn
```

## Typescript

For the typescript edition, run:

```
git checkout typescript
```

### Optional Gitpod

If you can't or don't want to run and install locally, you can work with this repo in Gitpod. If you do this, you can skip the `clone this repo` part.

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#github.com/PatrickAlphaC/hardhat-defi-fcc)


# Usage

This repo requires a mainnet rpc provider, but don't worry! You won't need to spend any real money. We are going to be `forking` mainnet, and pretend as if we are interacting with mainnet contracts. 

All you'll need, is to set a `MAINNET_RPC_URL` environment variable in a `.env` file that you create. You can get setup with one for free from [Alchemy](https://alchemy.com/?a=673c802981)

Run:

```
yarn hardhat run scripts/aaveBorrow.js
```

## Testing

We didn't write any tests for this, sorry!


# Running on a testnet or mainnet

1. Setup environment variabltes

You'll want to set your `KOVAN_RPC_URL` and `PRIVATE_KEY` as environment variables. You can add them to a `.env` file, similar to what you see in `.env.example`.

- `PRIVATE_KEY`: The private key of your account (like from [metamask](https://metamask.io/)). **NOTE:** FOR DEVELOPMENT, PLEASE USE A KEY THAT DOESN'T HAVE ANY REAL FUNDS ASSOCIATED WITH IT.
  - You can [learn how to export it here](https://metamask.zendesk.com/hc/en-us/articles/360015289632-How-to-Export-an-Account-Private-Key).
- `KOVAN_RPC_URL`: This is url of the kovan testnet node you're working with. You can get setup with one for free from [Alchemy](https://alchemy.com/?a=673c802981)

2. Get testnet ETH

Head over to [faucets.chain.link](https://faucets.chain.link/) and get some tesnet ETH. You should see the ETH show up in your metamask.

3. Run

```
yarn hardhat run scripts/aaveBorrow.js --network kovan
```


# Linting

To check linting / code formatting:
```
yarn lint
```
or, to fix: 
```
yarn lint:fix
```

## Formatting

```
yarn format
```


# Thank you!

If you appreciated this, feel free to follow me or donate!

ETH/Polygon/Avalanche/etc Address: 0x9680201d9c93d65a3603d2088d125e955c73BD65

[![Patrick Collins Twitter](https://img.shields.io/badge/Twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white)](https://twitter.com/PatrickAlphaC)
[![Patrick Collins YouTube](https://img.shields.io/badge/YouTube-FF0000?style=for-the-badge&logo=youtube&logoColor=white)](https://www.youtube.com/channel/UCn-3f8tw_E1jZvhuHatROwA)
[![Patrick Collins Linkedin](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/patrickalphac/)
[![Patrick Collins Medium](https://img.shields.io/badge/Medium-000000?style=for-the-badge&logo=medium&logoColor=white)](https://medium.com/@patrick.collins_58673/)


# Lesson 13 : Hardhat DeFi & Aave

Poin yang dipelajari pada lesson 13 adalah apa itu DeFi, ap aitu Aave, bangaimana prgramatic borrowing & Lending, cara menggunakan WETH (Wrapped ETH), Forking Mainnet, dan cara deposit dan meminjam dari Aave

## a.	Apa itu DeFi (Decentralized Finance) ?
DeFi (Decentralized Finance) adalah salah satu kemajuan paling signifikan yang ada pada blockchain, smart contracts, dan oracles. Saat DeFi dimulai sebagai gerakan untuk menciptakan kembali instrumen keuangan umum pada infrastruktur terdesentralisasi, DeFi telah berkembang pesat untuk menggerakkan berbagai produk dan pasar yang baru.

Dalam ekonomi DeFi, pengguna dapat mengakses tumpukan aplikasi keuangan yang sama seperti dalam keuangan tradisional tetapi tanpa memerlukan keterlibatan perantara terpusat. Dengan menggunakan protokol sumber terbuka yang berjalan pada jaringan yang tahan sensor dan terdesentralisasi, aplikasi DeFi menyediakan akses tanpa izin global, mengurangi risiko, dan beroperasi bersama dengan aplikasi lain untuk memungkinkan produk keuangan yang lebih canggih.

### •	Cara kerja DeFi
![image](https://user-images.githubusercontent.com/100683960/178105963-bad2dde6-a380-4a1f-8fe1-f80f6c0584cc.png)

Figure 1 Transaksi terpusat memerlukan perantara untuk mengambil alih sementara transaksi terdesentralisasi adalah non-penahanan

Aplikasi DeFi berjalan pada infrastruktur yang sama (yaitu, blockchain), logika dasarnya ditegakkan oleh lingkungan yang aman dan deterministik, memberikan transparansi lengkap seputar aturan yang mengatur sistem dan memfasilitasi konektivitas tanpa batas antara berbagai aplikasi DeFi. Karena kode yang mendukung aplikasi DeFi tersedia bagi siapa saja untuk diaudit, pengguna memiliki keyakinan yang lebih besar bahwa perjanjian keuangan mereka akan dijalankan persis seperti yang diprogram. Memiliki sistem keuangan akses terbuka tidak hanya mengurangi biaya pengembangan dan kepatuhan bagi pengembang, tetapi juga memungkinkan jembatan ekonomi antara segmen ekonomi yang berbeda.

### •	Web pengaplikasian DeFi (Defi Llama)
![image](https://user-images.githubusercontent.com/100683960/178106011-39d85e69-9a4e-454c-9a5a-aec5567b552c.png)

Menunjukkan nilai total yang dikunci di semua protokol terdesentralisasi yang berbeda. Dan kita dapat melihat banyak dari ini berada dalam chain. Dan banyak dari ini adalah chain yang kompatibel dengan EVM, Aetherium, Biden, smart chain, avalanche, Fanta, drawn polygon, semua ini adalah EVM, blockchain yang kompatibel, di mana kita dapat melihat dengan tepat berapa banyak uang yang telah dimasukkan oleh pengguna independen ke dalam protokol ini. Waktu perekaman Ave adalah protokol nomor satu untuk nilai total yang dikunci. Jadi ada $22 miliar terkunci di Ave, yang merupakan protokol yang dibahas pada video ini.

## b. Apa itu Aaave ?
![image](https://user-images.githubusercontent.com/100683960/178106047-c226388b-7169-4708-b4e5-2e40309b4b4b.png)

Aave adalah protokol peminjaman dan peminjaman, ini memungkinkan kita untuk meminjam dan meminjamkan mata uang kripto. Jadi kita benar-benar dapat meletakkan token sebagai jaminan, ini mirip seperti menaruh uang di bank, dan mendapatkan hasil dari orang lain yang meminjam agunan dari kita hampir persis seperti yang dilakukan bank, kecuali fakta bahwa itu disebut noncustodial. tim Aave tidak pernah menyentuh uang kami. Tidak ada yang pernah menyentuh uang itu. Itu semua hanya smart contracts. Ini semua hanya kode program ini. Jadi kita bisa yakin, tidak ada yang akan kabur dengan uang kita, tidak ada yang akan melakukan hal buruk. Dan kami juga mendapatkan hasil yang lebih tinggi ini. meminjam dan meminjamkan adalah bagian penting untuk membuat aplikasi keuangan yang benar-benar menarik.

## c.	Programatic Borrowing & Lending
Pada percobaan meminjam dan meminjamkan ini, dilakukan percobaan melalui code.

## d.	WETH – Wrapped ETH

## e.	Forking Mainnet
Anda dapat memulai instance Hardhat Network yang memotong mainnet. Ini berarti akan mensimulasikan status yang sama dengan mainnet, tetapi akan bekerja sebagai jaringan pengembangan lokal. Dengan begitu Anda dapat berinteraksi dengan protokol yang diterapkan dan menguji interaksi kompleks secara lokal.
