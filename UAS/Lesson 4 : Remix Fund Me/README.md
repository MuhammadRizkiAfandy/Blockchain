# Lesson 4 : Remix Fund Me
- [Code](https://github.com/PatrickAlphaC/fund-me-fcc)
## Mengirim ETH Melalui Fungsi & Pengembalian
- [Fields in a Transaction]
Transaksi Ethereum mengacu pada tindakan yang diprakarsai oleh akun yang dimiliki secara eksternal, dengan kata lain akun yang dikelola oleh manusia, bukan kontrak. Misalnya, jika Bob mengirim Alice 1 ETH, akun Bob harus didebit dan akun Alice harus dikredit. Tindakan perubahan status ini terjadi dalam suatu transaksi. Gas adalah referensi untuk perhitungan yang diperlukan untuk memproses transaksi oleh penambang. Pengguna harus membayar biaya untuk perhitungan ini. gasLimit, dan maxPriorityFeePerGas menentukan biaya transaksi maksimum yang dibayarkan kepada penambang

#### Objek transaksi akan terlihat sedikit seperti ini:
```solidity
 {
  from: "0xEA674fdDe714fd979de3EdF0F56AA9716B898ec8",
  to: "0xac03bb73b6a9e108530aff4df5077c2b3d481e5a",
  gasLimit: "21000",
  maxFeePerGas: "300",
  maxPriorityFeePerGas: "10",
  nonce: "0",
  value: "10000000000"
  }
```
Tetapi objek transaksi harus ditandatangani menggunakan kunci pribadi pengirim. Ini membuktikan bahwa transaksi hanya bisa datang dari pengirim dan tidak dikirim dengan curang.

Klien Ethereum seperti Geth akan menangani proses penandatanganan ini.

#### Contoh panggilan JSON-RPC:

```solidity
{
  "id": 2,
  "jsonrpc": "2.0",
  "method": "account_signTransaction",
  "params": [
    {
      "from": "0x1923f626bb8dc025849e00f99c25fe2b2f7fb0db",
      "gas": "0x55555",
      "maxFeePerGas": "0x1234",
      "maxPriorityFeePerGas": "0x1234",
      "input": "0xabcd",
      "nonce": "0x0",
      "to": "0x07a565b7ed7d7a678680a4c162885bedbb695fe0",
      "value": "0x1234"
     }
   ]
}

```
#### Contoh Respon
```solidity
{
  "jsonrpc": "2.0",
  "id": 2,
  "result": {
    "raw": "0xf88380018203339407a565b7ed7d7a678680a4c162885bedbb695fe080a44401a6e4000000000000000000000000000000000000000000000000000000000000001226a0223a7c9bcf5531c99be5ea7082183816eb20cfe0bbc322e97cc5c7f71ab8b20ea02aadee6b34b45bb15bc42d9c09de4a6754e7000908da72d48cc7704971491663",
    "tx": {
      "nonce": "0x0",
      "maxFeePerGas": "0x1234",
      "maxPriorityFeePerGas": "0x1234",
      "gas": "0x55555",
      "to": "0x07a565b7ed7d7a678680a4c162885bedbb695fe0",
      "value": "0x1234",
      "input": "0xabcd",
      "v": "0x26",
      "r": "0x223a7c9bcf5531c99be5ea7082183816eb20cfe0bbc322e97cc5c7f71ab8b20e",
      "s": "0x2aadee6b34b45bb15bc42d9c09de4a6754e7000908da72d48cc7704971491663",
      "hash": "0xeba2df809e7a612a0a0d444ccfa5c839624bdc00dd29e3340d46df3870f8a30e"
    }
  }
}
```
### JENIS TRANSAKSI :
Di Ethereum ada beberapa jenis transaksi yang berbeda:

- Transaksi reguler: transaksi dari satu akun ke akun lainnya.
- Transaksi penyebaran kontrak: transaksi tanpa alamat 'ke', di mana bidang data digunakan untuk kode kontrak.
- Eksekusi kontrak: transaksi yang berinteraksi dengan kontrak pintar yang diterapkan. Dalam hal ini, alamat 'ke' adalah alamat kontrak pintar

### ON GAS
Seperti disebutkan, transaksi membutuhkan gas untuk dieksekusi. Transaksi transfer sederhana membutuhkan 21000 unit Gas.

#### Jadi agar Bob mengirim Alice 1 ETH dengan baseFeePerGas 190 gwei dan maxPriorityFeePerGas 10 gwei, Bob harus membayar biaya berikut:
```
(190 + 10) * 21000 = 4,200,000 gwei
--or—
0.0042 ETH
```
Akun Bob akan didebet -1.0042 ETH

Akun Alice akan dikreditkan +1.0 ETH

Biaya dasar akan dibakar -0,00399 ETH

Penambang menyimpan tipnya +0,000210 ETH

Gas juga diperlukan untuk interaksi kontrak pintar apa pun.

![image](https://user-images.githubusercontent.com/100511533/178108073-5c95b7a0-1bde-47f4-8cbe-88b1fcaa20e6.png)
Gas apa pun yang tidak digunakan dalam transaksi akan dikembalikan ke akun pengguna.
## Payable
Fungsi dan alamat yang dinyatakan terutang dapat menerima eter ke dalam kontrak.
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Payable {
    // Payable address can receive Ether
    address payable public owner;

    // Payable constructor can receive Ether
    constructor() payable {
        owner = payable(msg.sender);
    }

    // Function to deposit Ether into this contract.
    // Call this function along with some Ether.
    // The balance of this contract will be automatically updated.
    function deposit() public payable {}

    // Call this function along with some Ether.
    // The function will throw an error since this function is not payable.
    function notPayable() public {}

    // Function to withdraw all Ether from this contract.
    function withdraw() public {
        // get the amount of Ether stored in this contract
        uint amount = address(this).balance;

        // send all Ether to owner
        // Owner can receive Ether since the address of owner is payable
        (bool success, ) = owner.call{value: amount}("");
        require(success, "Failed to send Ether");
    }

    // Function to transfer Ether from this contract to address from input
    function transfer(address payable _to, uint _amount) public {
        // Note that "to" is declared as payable
        (bool success, ) = _to.call{value: _amount}("");
        require(success, "Failed to send Ether");
    }
}
```
## Require
Mari kita lihat bagaimana cara menggunakan "require" di Solidity
```solidity
pragma solidity ^0.8.4; 

contract Bank { 
mapping(address => uint) balance;
address owner; 
constructor() { 
owner = msg.sender; 
// address that deploys contract will be the owner 
} 

function addBalance(uint _toAdd) public returns(uint) {
 require(msg.sender == owner);
 balance[msg.sender] += _toAdd; 
 return balance[msg.sender]; 
} 

function getBalance() public view returns(uint) {
 return balance[msg.sender]; 
} 

function transfer(address recipient, uint amount) public { 
require(balance[msg.sender]>=amount, "Insufficient Balance"); 
require(msg.sender != recipient, "You can't send money to yourself!");
 _transfer(msg.sender, recipient, amount); 
} 

function _transfer(address from, address to, uint amount) private { 
balance[from] -= amount; balance[to] += amount; 
}

}
```
Dalam contoh kode di atas, kita akan melihat beberapa penggunaan 'require'. Di konstruktor, kami menetapkan pemilik kontrak menjadi alamat yang menyebarkan kontrak. Dalam fungsi addBalance(), kami menggunakan persyaratan untuk memastikan bahwa hanya pemilik kontrak pintar yang dapat menambahkan saldo ke kontrak dan tidak ada orang lain yang dapat menambahkannya. Dalam fungsi transfer() yang kami gunakan membutuhkan dua kali. Pertama kali adalah memeriksa saldo pengirim dan memastikan bahwa itu di atas saldo yang diperlukan. Kedua kalinya kami memastikan bahwa pengguna tidak dapat mengirim uang ke dirinya sendiri. Dalam kedua panggilan " require" ini, kami menggunakan parameter kedua untuk menunjukkan kesalahan kepada pengguna jika ' require' mengembalikan nilai yang salah.

## Floating Point Math in Solidity
### Tuple
Meskipun nama-nama itu sengaja bukan bagian dari pengkodean ABI, mereka sangat masuk akal untuk dimasukkan dalam JSON untuk memungkinkan menampilkannya kepada pengguna akhir. Struktur bersarang dengan cara berikut:
Objek dengan nama anggota, tipe dan komponen potensial menggambarkan variabel yang diketik. Tipe kanonik ditentukan sampai tipe tuple tercapai dan deskripsi string sampai saat itu disimpan dalam prefiks tipe dengan kata tuple, yaitu akan menjadi tuple diikuti oleh urutan [] dan [k] dengan bilangan bulat k. Komponen tuple kemudian disimpan dalam komponen anggota, yang bertipe array dan memiliki struktur yang sama dengan objek tingkat atas kecuali yang diindeks tidak diperbolehkan di sana.

Contoh : 
```solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.5 <0.9.0;
pragma abicoder v2;

contract Test {
    struct S { uint a; uint[] b; T[] c; }
    struct T { uint x; uint y; }
    function f(S memory, T memory, uint) public pure {}
    function g() public pure returns (S memory, T memory, uint) {}
}
```
Menghasilkan JSON :
```solidity
[
  {
    "name": "f",
    "type": "function",
    "inputs": [
      {
        "name": "s",
        "type": "tuple",
        "components": [
          {
            "name": "a",
            "type": "uint256"
          },
          {
            "name": "b",
            "type": "uint256[]"
          },
          {
            "name": "c",
            "type": "tuple[]",
            "components": [
              {
                "name": "x",
                "type": "uint256"
              },
              {
                "name": "y",
                "type": "uint256"
              }
            ]
          }
        ]
      },
      {
        "name": "t",
        "type": "tuple",
        "components": [
          {
            "name": "x",
            "type": "uint256"
          },
          {
            "name": "y",
            "type": "uint256"
          }
        ]
      },
      {
        "name": "a",
        "type": "uint256"
      }
    ],
    "outputs": []
  }
]


```

### LIBRARIES
Libraries mirip dengan kontrak, tetapi tujuannya adalah bahwa mereka hanya digunakan sekali di alamat tertentu dan kodenya digunakan kembali menggunakan fitur DELEGATECALL (CALLCODE hingga Homestead) dari EVM. Ini berarti bahwa jika fungsi perpustakaan dipanggil, kodenya dieksekusi dalam konteks kontrak panggilan, yaitu ini menunjuk ke kontrak panggilan, dan terutama penyimpanan dari kontrak panggilan dapat diakses. Karena perpustakaan adalah bagian dari kode sumber yang terisolasi, ia hanya dapat mengakses variabel status dari kontrak panggilan jika mereka secara eksplisit disediakan (jika tidak, tidak ada cara untuk menamainya). Fungsi library hanya dapat dipanggil secara langsung (yaitu tanpa menggunakan DELEGATECALL) jika fungsi tersebut tidak mengubah status (yaitu jika fungsi tersebut adalah tampilan atau fungsi murni), karena library diasumsikan tidak memiliki status. Secara khusus, tidak mungkin untuk menghancurkan perpustakaan.
Contoh berikut mengilustrasikan cara menggunakan pustaka (tetapi menggunakan metode manual, pastikan untuk memeriksa menggunakan for untuk contoh yang lebih lanjut untuk mengimplementasikan kumpulan).

``` solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.0 <0.9.0;


// We define a new struct datatype that will be used to
// hold its data in the calling contract.
struct Data {
    mapping(uint => bool) flags;
}

library Set {
    // Note that the first parameter is of type "storage
    // reference" and thus only its storage address and not
    // its contents is passed as part of the call.  This is a
    // special feature of library functions.  It is idiomatic
    // to call the first parameter `self`, if the function can
    // be seen as a method of that object.
    function insert(Data storage self, uint value)
        public
        returns (bool)
    {
        if (self.flags[value])
            return false; // already there
        self.flags[value] = true;
        return true;
    }

    function remove(Data storage self, uint value)
        public
        returns (bool)
    {
        if (!self.flags[value])
            return false; // not there
        self.flags[value] = false;
        return true;
    }

    function contains(Data storage self, uint value)
        public
        view
        returns (bool)
    {
        return self.flags[value];
    }
}


contract C {
    Data knownValues;

    function register(uint value) public {
        // The library functions can be called without a
        // specific instance of the library, since the
        // "instance" will be the current contract.
        require(Set.insert(knownValues, value));
    }
    // In this contract, we can also directly access knownValues.flags, if we want.
}

```
Tentu saja, Anda tidak harus mengikuti cara ini untuk menggunakan perpustakaan: mereka juga dapat digunakan tanpa mendefinisikan tipe data struct. Fungsi juga bekerja tanpa parameter referensi penyimpanan apa pun, dan mereka dapat memiliki beberapa parameter referensi penyimpanan dan dalam posisi apa pun.
Contoh berikut menunjukkan cara menggunakan tipe yang disimpan dalam memori dan fungsi internal di pustaka untuk mengimplementasikan tipe kustom tanpa overhead panggilan fungsi eksternal:
```solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

struct bigint {
    uint[] limbs;
}

library BigInt {
    function fromUint(uint x) internal pure returns (bigint memory r) {
        r.limbs = new uint[](1);
        r.limbs[0] = x;
    }

    function add(bigint memory a, bigint memory b) internal pure returns (bigint memory r) {
        r.limbs = new uint[](max(a.limbs.length, b.limbs.length));
        uint carry = 0;
        for (uint i = 0; i < r.limbs.length; ++i) {
            uint limbA = limb(a, i);
            uint limbB = limb(b, i);
            unchecked {
                r.limbs[i] = limbA + limbB + carry;

                if (limbA + limbB < limbA || (limbA + limbB == type(uint).max && carry > 0))
                    carry = 1;
                else
                    carry = 0;
            }
        }
        if (carry > 0) {
            // too bad, we have to add a limb
            uint[] memory newLimbs = new uint[](r.limbs.length + 1);
            uint i;
            for (i = 0; i < r.limbs.length; ++i)
                newLimbs[i] = r.limbs[i];
            newLimbs[i] = carry;
            r.limbs = newLimbs;
        }
    }

    function limb(bigint memory a, uint index) internal pure returns (uint) {
        return index < a.limbs.length ? a.limbs[index] : 0;
    }

    function max(uint a, uint b) private pure returns (uint) {
        return a > b ? a : b;
    }
}

contract C {
    using BigInt for bigint;

    function f() public pure {
        bigint memory x = BigInt.fromUint(7);
        bigint memory y = BigInt.fromUint(type(uint).max);
        bigint memory z = x.add(y);
        assert(z.limb(1) > 0);
    }
}


```
Dimungkinkan untuk mendapatkan alamat perpustakaan dengan mengonversi jenis perpustakaan ke jenis alamat, yaitu menggunakan alamat(LibraryName)
## Sending ETH from a Contract
#### Transfer, Send, Call
### Bagaimana cara mengirim Eter?
Anda dapat mengirim Eter ke kontrak lain dengan
•	transfer (2300 gas, throws error)

•	send (2300 gas, returns bool)

•	call (forward all gas or set gas, returns bool)

### Bagaimana cara menerima Eter?
Kontrak yang menerima Eter harus memiliki setidaknya salah satu fungsi di bawah ini. 

•	receive() external payable

•	fallback() external payable

receive() dipanggil jika msg.data kosong, jika tidak, fallback() dipanggil.
### Metode mana yang harus Anda gunakan?
panggilan dalam kombinasi dengan penjaga masuk kembali adalah metode yang disarankan untuk digunakan setelah Desember 2019.
Jaga agar tidak masuk kembali dengan

•	membuat semua perubahan status sebelum memanggil kontrak lain

•	menggunakan pengubah penjaga masuk kembali

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract ReceiveEther {
    /*
    Which function is called, fallback() or receive()?

           send Ether
               |
         msg.data is empty?
              / \
            yes  no
            /     \
receive() exists?  fallback()
         /   \
        yes   no
        /      \
    receive()   fallback()
    */

    // Function to receive Ether. msg.data must be empty
    receive() external payable {}

    // Fallback function is called when msg.data is not empty
    fallback() external payable {}

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract SendEther {
    function sendViaTransfer(address payable _to) public payable {
        // This function is no longer recommended for sending Ether.
        _to.transfer(msg.value);
    }

    function sendViaSend(address payable _to) public payable {
        // Send returns a boolean value indicating success or failure.
        // This function is not recommended for sending Ether.
        bool sent = _to.send(msg.value);
        require(sent, "Failed to send Ether");
    }

    function sendViaCall(address payable _to) public payable {
        // Call returns a boolean value indicating success or failure.
        // This is the current recommended method to use.
        (bool sent, bytes memory data) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }
}
```
#### Keyword
Apa spesifikasi Keyword ini di Solidity? Bagaimana cara kerjanya?
Sample code :
```
contract Helper {
  function getBalance() returns (uint bal) {
    return this.balance; // balance is "inherited" from the address type
  }
}

```
Ini berarti bahwa ini adalah penunjuk ke instance saat ini dari tipe yang diturunkan dari Address (dalam kasus Anda - instance Helper saat ini), dan balance adalah anggota Address.

## Basic Solidity: Constructor
###	Constructor
Konstruktor adalah fungsi opsional yang dijalankan setelah pembuatan kontrak.

Berikut adalah contoh bagaimana meneruskan argumen ke konstruktor.
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// Base contract X
contract X {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}

// Base contract Y
contract Y {
    string public text;

    constructor(string memory _text) {
        text = _text;
    }
}

// There are 2 ways to initialize parent contract with parameters.

// Pass the parameters here in the inheritance list.
contract B is X("Input to X"), Y("Input to Y") {

}

contract C is X, Y {
    // Pass the parameters here in the constructor,
    // similar to function modifiers.
    constructor(string memory _name, string memory _text) X(_name) Y(_text) {}
}

// Parent constructors are always called in the order of inheritance
// regardless of the order of parent contracts listed in the
// constructor of the child contract.

// Order of constructors called:
// 1. X
// 2. Y
// 3. D
contract D is X, Y {
    constructor() X("X was called") Y("Y was called") {}
}

// Order of constructors called:
// 1. X
// 2. Y
// 3. E
contract E is X, Y {
    constructor() Y("Y was called") X("X was called") {}
}

```
## Basic Solidity: Modifiers
Dalam bahasa pemrograman apa pun, operator memainkan peran penting yaitu mereka membuat fondasi untuk pemrograman. Demikian pula, fungsionalitas Solidity juga tidak lengkap tanpa menggunakan operator. Operator memungkinkan pengguna untuk melakukan operasi yang berbeda pada operan. Solidity mendukung jenis operator berikut berdasarkan fungsinya.

1.	Operator Aritmatika

2.	Operator Relasional

3.	Operator Logika

4.	Operator Bitwise

5.	Operator penugasan

6.	Operator Bersyarat


-	Function Modifier
Modifier adalah kode yang dapat dijalankan sebelum dan/atau setelah pemanggilan fungsi.

Modifier dapat digunakan untuk:

•	Batasi akses

•	Validasi masukan

•	Waspada terhadap peretasan reentrancy

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract FunctionModifier {
    // We will use these variables to demonstrate how to use
    // modifiers.
    address public owner;
    uint public x = 10;
    bool public locked;

    constructor() {
        // Set the transaction sender as the owner of the contract.
        owner = msg.sender;
    }

    // Modifier to check that the caller is the owner of
    // the contract.
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        // Underscore is a special character only used inside
        // a function modifier and it tells Solidity to
        // execute the rest of the code.
        _;
    }

    // Modifiers can take inputs. This modifier checks that the
    // address passed in is not the zero address.
    modifier validAddress(address _addr) {
        require(_addr != address(0), "Not valid address");
        _;
    }

    function changeOwner(address _newOwner) public onlyOwner validAddress(_newOwner) {
        owner = _newOwner;
    }

    // Modifiers can be called before and / or after a function.
    // This modifier prevents a function from being called while
    // it is still executing.
    modifier noReentrancy() {
        require(!locked, "No reentrancy");

        locked = true;
        _;
        locked = false;
    }

    function decrement(uint i) public noReentrancy {
        x -= i;

        if (i > 1) {
            decrement(i - 1);
        }
    }
}

```
## Immutable & Constant
•	Immutable
Variabel yang tidak dapat diubah seperti konstanta. Nilai variabel yang tidak dapat diubah dapat diatur di dalam konstruktor tetapi tidak dapat dimodifikasi setelahnya.
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Immutable {
    // coding convention to uppercase constant variables
    address public immutable MY_ADDRESS;
    uint public immutable MY_UINT;

    constructor(uint _myUint) {
        MY_ADDRESS = msg.sender;
        MY_UINT = _myUint;
    }
}

```
•	Constants
Constants adalah variabel yang tidak dapat diubah.

Nilainya dikodekan dengan keras dan menggunakan konstanta dapat menghemat biaya gas.
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Constants {
    // coding convention to uppercase constant variables
    address public constant MY_ADDRESS = 0x777788889999AaAAbBbbCcccddDdeeeEfFFfCcCc;
    uint public constant MY_UINT = 123;
}

```
## Custom Errors
Mulai dari Solidity v0.8.4, ada cara yang nyaman dan hemat gas untuk menjelaskan kepada pengguna mengapa operasi gagal melalui penggunaan kesalahan khusus. Sampai sekarang, Anda sudah dapat menggunakan string untuk memberikan lebih banyak informasi tentang kegagalan (misalnya, revert("Dana tidak mencukupi.");), tetapi mereka agak mahal, terutama dalam hal biaya penerapan, dan sulit untuk menggunakan informasi dinamis di dalamnya.

Kesalahan khusus didefinisikan menggunakan pernyataan kesalahan, yang dapat digunakan di dalam dan di luar kontrak (termasuk antarmuka dan pustaka).
Contoh :
Kontrak berikut menunjukkan contoh penggunaan kesalahan:
```solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

error Unauthorized();

contract VendingMachine {
    address payable owner = payable(msg.sender);

    function withdraw() public {
        if (msg.sender != owner)
            revert Unauthorized();

        owner.transfer(address(this).balance);
    }
    // ...
}

```
Sintaks kesalahan mirip dengan peristiwa. Mereka harus digunakan bersama dengan pernyataan revert yang menyebabkan semua perubahan dalam panggilan saat ini dikembalikan dan meneruskan data kesalahan kembali ke pemanggil. Menggunakan kesalahan bersama dengan require belum didukung (lihat di bawah).
#### Kesalahan dengan Parameter
Dimungkinkan juga untuk memiliki kesalahan yang mengambil parameter. Sebagai contoh,
```solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

/// Insufficient balance for transfer. Needed `required` but only
/// `available` available.
/// @param available balance available.
/// @param required requested amount to transfer.
error InsufficientBalance(uint256 available, uint256 required);

contract TestToken {
    mapping(address => uint) balance;
    function transfer(address to, uint256 amount) public {
        if (amount > balance[msg.sender])
            // Error call using named parameters. Equivalent to
            // revert InsufficientBalance(balance[msg.sender], amount);
            revert InsufficientBalance({
                available: balance[msg.sender],
                required: amount
            });
        balance[msg.sender] -= amount;
        balance[to] += amount;
    }
    // ...
}

```
Data kesalahan akan dikodekan secara identik sebagai pengkodean ABI untuk panggilan fungsi, yaitu, abi.encodeWithSignature("InsufficientBalance(uint256,uint256)", balance[msg.sender], jumlah).
Kami berharap kerangka kerja akan memberikan dukungan langsung untuk kesalahan khusus. Berikut ini adalah contoh data error decoding menggunakan versi ethers.js saat ini:

```solidity
import { ethers } from "ethers";

// As a workaround, we have a function with the
// same name and parameters as the error in the abi.
const abi = [
    "function InsufficientBalance(uint256 available, uint256 required)"
];

const interface = new ethers.utils.Interface(abi);
const error_data =
    "0xcf479181000000000000000000000000000000000000" +
    "0000000000000000000000000100000000000000000000" +
    "0000000000000000000000000000000000000100000000";

const decoded = interface.decodeFunctionData(
    interface.functions["InsufficientBalance(uint256,uint256)"],
    error_data
);
// Contents of decoded:
// [
//   BigNumber { _hex: '0x0100', _isBigNumber: true },
//   BigNumber { _hex: '0x0100000000', _isBigNumber: true },
//   available: BigNumber { _hex: '0x0100', _isBigNumber: true },
//   required: BigNumber { _hex: '0x0100000000', _isBigNumber: true }
// ]
console.log(
    "Insufficient balance for transfer. " +
    `Needed ${decoded.required.toString()} but only ` +
    `${decoded.available.toString()} available.`
);
// Insufficient balance for transfer. Needed 4294967296 but only 256 available.

```
Kompiler menyertakan semua kesalahan yang dapat ditimbulkan oleh kontrak dalam ABI-JSON kontrak. Perhatikan bahwa ini tidak termasuk kesalahan yang diteruskan melalui panggilan eksternal. Demikian pula, pengembang dapat menyediakan dokumentasi NatSpec untuk kesalahan yang kemudian akan menjadi bagian dari dokumentasi pengguna dan pengembang dan dapat menjelaskan kesalahan secara lebih rinci tanpa biaya.

## Receive & Fallback Functions
-	Solidity Docs Special Functions
Sebuah kontrak dapat memiliki paling banyak satu fungsi penerima, yang dideklarasikan menggunakan penerima() hutang eksternal { ... } (tanpa kata kunci fungsi). Fungsi ini tidak dapat memiliki argumen, tidak dapat mengembalikan apa pun dan harus memiliki visibilitas eksternal dan mutabilitas status hutang. Itu bisa virtual, dapat menimpa dan dapat memiliki pengubah.

Fungsi terima dieksekusi pada panggilan ke kontrak dengan data panggilan kosong. Ini adalah fungsi yang dijalankan pada transfer Ether biasa (misalnya melalui .send() atau .transfer()). Jika tidak ada fungsi seperti itu, tetapi ada fungsi fallback yang dapat dibayar, fungsi fallback akan dipanggil pada transfer Ether biasa. Jika tidak ada Eter penerima maupun fungsi fallback yang dapat dibayarkan, kontrak tidak dapat menerima Eter melalui transaksi reguler dan memberikan pengecualian.

Dalam kasus terburuk, fungsi terima hanya dapat mengandalkan 2300 gas yang tersedia (misalnya ketika mengirim atau mentransfer digunakan), menyisakan sedikit ruang untuk melakukan operasi lain kecuali pencatatan dasar. Operasi berikut akan mengkonsumsi lebih banyak gas daripada tunjangan gas 2300:

•	Menulis ke penyimpanan

•	Membuat kontrak

•	Memanggil fungsi eksternal yang menghabiskan banyak gas

•	Mengirim Eter
Di bawah ini Anda dapat melihat contoh kontrak Sink yang menggunakan fungsi terima.

```solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.0 <0.9.0;

// This contract keeps all Ether sent to it with no way
// to get it back.
contract Sink {
    event Received(address, uint);
    receive() external payable {
        emit Received(msg.sender, msg.value);
    }
}

```
## Fallback Function
Jika Anda ingin mendekode data input, Anda dapat memeriksa empat byte pertama untuk pemilih fungsi dan kemudian Anda dapat menggunakan abi.decode bersama dengan sintaks irisan array untuk mendekode data yang disandikan ABI: (c, d) = abi.decode (masukan[4:], (uint256, uint256)); Perhatikan bahwa ini hanya boleh digunakan sebagai upaya terakhir dan fungsi yang tepat harus digunakan sebagai gantinya.
```solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.2 <0.9.0;

contract Test {
    uint x;
    // This function is called for all messages sent to
    // this contract (there is no other function).
    // Sending Ether to this contract will cause an exception,
    // because the fallback function does not have the `payable`
    // modifier.
    fallback() external { x = 1; }
}

contract TestPayable {
    uint x;
    uint y;
    // This function is called for all messages sent to
    // this contract, except plain Ether transfers
    // (there is no other function except the receive function).
    // Any call with non-empty calldata to this contract will execute
    // the fallback function (even if Ether is sent along with the call).
    fallback() external payable { x = 1; y = msg.value; }

    // This function is called for plain Ether transfers, i.e.
    // for every call with empty calldata.
    receive() external payable { x = 2; y = msg.value; }
}

contract Caller {
    function callTest(Test test) public returns (bool) {
        (bool success,) = address(test).call(abi.encodeWithSignature("nonExistingFunction()"));
        require(success);
        // results in test.x becoming == 1.

        // address(test) will not allow to call ``send`` directly, since ``test`` has no payable
        // fallback function.
        // It has to be converted to the ``address payable`` type to even allow calling ``send`` on it.
        address payable testPayable = payable(address(test));

        // If someone sends Ether to that contract,
        // the transfer will fail, i.e. this returns false here.
        return testPayable.send(2 ether);
    }

    function callTestPayable(TestPayable test) public returns (bool) {
        (bool success,) = address(test).call(abi.encodeWithSignature("nonExistingFunction()"));
        require(success);
        // results in test.x becoming == 1 and test.y becoming 0.
        (success,) = address(test).call{value: 1}(abi.encodeWithSignature("nonExistingFunction()"));
        require(success);
        // results in test.x becoming == 1 and test.y becoming 1.

        // If someone sends Ether to that contract, the receive function in TestPayable will be called.
        // Since that function writes to storage, it takes more gas than is available with a
        // simple ``send`` or ``transfer``. Because of that, we have to use a low-level call.
        (success,) = address(test).call{value: 2 ether}("");
        require(success);
        // results in test.x becoming == 2 and test.y becoming 2 ether.

        return true;
    }
}


```
## Function Overloading
Kontrak dapat memiliki beberapa fungsi dengan nama yang sama tetapi dengan tipe parameter yang berbeda. Proses ini disebut "overloading" dan juga berlaku untuk fungsi yang diwariskan. Contoh berikut menunjukkan kelebihan fungsi f dalam ruang lingkup kontrak
```solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.9.0;

contract A {
    function f(uint value) public pure returns (uint out) {
        out = value;
    }

    function f(uint value, bool really) public pure returns (uint out) {
        if (really)
            out = value;
    }
}

```
Fungsi yang kelebihan beban juga ada di antarmuka eksternal. Ini adalah kesalahan jika dua fungsi yang terlihat secara eksternal berbeda berdasarkan tipe Soliditasnya tetapi tidak berdasarkan tipe eksternalnya.
