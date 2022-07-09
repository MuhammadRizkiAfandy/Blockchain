# Lesson 2 : Welcome to Remix! Simple Storage
## Introduction
### Remix and Solidity
Solidity dapat di jalankan pada Remix.org yakni  IDE Online untuk Solidity , remix sendiri hanya digunakan untuk membuat dan mencoba menjalankan Smart Contract pada test server. Setelah Smart contract bisa di jalankan di remix, makadapat di lanjutkanmenggunakan visual studio code untuk menambahkan front end seperti react sebagai tampilan depan dari smart contract itu sendiri dan menggunakan web3.js sebagai penghubungnya
Solidity adalah bahasa tingkat tinggi berorientasi objek untuk mengimplementasikan kontrak pintar. Kontrak pintar adalah program yang mengatur perilaku akun dalam negara Ethereum. Solidity adalah bahasa kurung kurawal yang dirancang untuk menargetkan Ethereum Virtual Machine (EVM). Itu dipengaruhi oleh C++, Python dan JavaScript. Anda dapat menemukan detail lebih lanjut tentang bahasa mana yang menjadi inspirasi Solidity di bagian pengaruh bahasa. Soliditas diketik secara statis, mendukung pewarisan, perpustakaan, dan tipe kompleks yang ditentukan pengguna di antara fitur-fitur lainnya. Dengan Solidity, Anda dapat membuat kontrak untuk penggunaan seperti voting, crowdfunding, pelelangan buta, dan dompet multi-tanda tangan.
### Tipe data solidity
https://docs.soliditylang.org/en/latest/types.html
### Basic Solidity: Functions
•	Fungsi
•	Menyebarkan Kontrak
•	Smart Contracts memiliki alamat seperti dompet kami
•	Memanggil Fungsi pengubah status publik
•	Visibilitas
•	Gas III | Sebuah contoh
•	Cakupan
•	Lihat & Fungsi Murni
### Basic Solidity: Arrays & Structs
•	Structs
•	Pengantar Penyimpanan
•	Array
•	Berukuran Dinamis dan Tetap
•	fungsi larik dorong

### Basic Solidity: Compiler Errors and Warnings
Kuning: Peringatan Oke
Merah: Kesalahan tidak Oke

### Memory, Storage, Calldata (Intro)
6 Tempat Anda dapat menyimpan dan mengakses data
•	data panggilan
•	Penyimpanan
•	penyimpanan
•	kode
•	log
•	tumpukan

### Mapping
Maps dibuat dengan pemetaan sintaks (keyType => valueType). KeyType dapat berupa tipe nilai bawaan, byte, string, atau kontrak apa pun. valueType dapat berupa tipe apa pun termasuk mapping atau array lain. Mapping tidak dapat diubah. 
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Mapping {
    // Mapping from address to uint
    mapping(address => uint) public myMap;

    function get(address _addr) public view returns (uint) {
        // Mapping always returns a value.
        // If the value was never set, it will return the default value.
        return myMap[_addr];
    }

    function set(address _addr, uint _i) public {
        // Update the value at this address
        myMap[_addr] = _i;
    }

    function remove(address _addr) public {
        // Reset the value to the default value.
        delete myMap[_addr];
    }
}

contract NestedMapping {
    // Nested mapping (mapping from address to another mapping)
    mapping(address => mapping(uint => bool)) public nested;

    function get(address _addr1, uint _i) public view returns (bool) {
        // You can get values from a nested mapping
        // even when it is not initialized
        return nested[_addr1][_i];
    }

    function set(
        address _addr1,
        uint _i,
        bool _boo
    ) public {
        nested[_addr1][_i] = _boo;
    }

    function remove(address _addr1, uint _i) public {
        delete nested[_addr1][_i];
    }
}
```
