# Lesson 3 : Remix Storage Factory
-  [Code](https://github.com/PatrickAlphaC/storage-factory-fcc)
## Basic Solidity: Mengimpor Kontrak ke Kontrak lain
### Composibility : 
Pertumbuhan dan perluasan DeFi telah memunculkan ekosistem baru aplikasi dan protokol terdesentralisasi di banyak kasus penggunaan. Dalam pembicaraan teknologi ini, kita akan belajar tentang DePo (agregator multi-pasar), Vesta Finance (protokol pinjaman yang dijamin berlebihan), dan Redacted (protokol yang bertujuan untuk mendemokratisasi agregasi hasil dengan menciptakan aliansi pemungutan suara).
### Solidity new keyword :
Sebuah kontrak dapat membuat kontrak lain menggunakan kata kunci baru. Kode lengkap dari kontrak yang sedang dibuat harus diketahui saat kontrak pembuatan dikompilasi sehingga dependensi pembuatan rekursif tidak dimungkinkan.
```solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
contract D {
    uint public x;
    constructor(uint a) payable {
        x = a;
    }
}

contract C {
    D d = new D(4); // will be executed as part of C's constructor

    function createD(uint arg) public {
        D newD = new D(arg);
        newD.x();
    }

    function createAndEndowD(uint arg, uint amount) public payable {
        // Send ether along with the creation
        D newD = new D{value: amount}(arg);
        newD.x();
    }
}
```
### Importing Code in solidity :
#### Local :
```solidity
├── Import.sol
└── Foo.sol
```
#### Foo.sol
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

struct Point {
    uint x;
    uint y;
}

error Unauthorized(address caller);

function add(uint x, uint y) pure returns (uint) {
    return x + y;
}

contract Foo {
    string public name = "Foo";
}
```
#### Import.sol
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// import Foo.sol from current directory
import "./Foo.sol";

// import {symbol1 as alias, symbol2} from "filename";
import {Unauthorized, add as func, Point} from "./Foo.sol";

contract Import {
    // Initialize Foo.sol
    Foo public foo = new Foo();

    // Test Foo.sol by getting it's name.
    function getFooName() public view returns (string memory) {
        return foo.name();
    }
}
```
#### External : 
Anda juga dapat mengimpor dari GitHub hanya dengan menyalin url
```
// https://github.com/owner/repo/blob/branch/path/to/Contract.sol
import "https://github.com/owner/repo/blob/branch/path/to/Contract.sol";

// Example import ECDSA.sol from openzeppelin-contract repo, release-v4.5 branch
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v4.5/contracts/utils/cryptography/ECDSA.sol
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v4.5/contracts/utils/cryptography/ECDSA.sol";
```
### Basic Solidity: Interacting with other Contracts
Untuk berinteraksi, Anda selalu membutuhkan: ABI + Alamat
-  [Apa itu ABI?](https://docs.soliditylang.org/en/v0.8.14/abi-spec.html?highlight=abi) 

### Basic Solidity: Interacting with other Contracts
####Inheritance
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/* Graph of inheritance
    A
   / \
  B   C
 / \ /
F  D,E

*/

contract A {
    function foo() public pure virtual returns (string memory) {
        return "A";
    }
}

// Contracts inherit other contracts by using the keyword 'is'.
contract B is A {
    // Override A.foo()
    function foo() public pure virtual override returns (string memory) {
        return "B";
    }
}

contract C is A {
    // Override A.foo()
    function foo() public pure virtual override returns (string memory) {
        return "C";
    }
}

// Contracts can inherit from multiple parent contracts.
// When a function is called that is defined multiple times in
// different contracts, parent contracts are searched from
// right to left, and in depth-first manner.

contract D is B, C {
    // D.foo() returns "C"
    // since C is the right most parent contract with function foo()
    function foo() public pure override(B, C) returns (string memory) {
        return super.foo();
    }
}

contract E is C, B {
    // E.foo() returns "B"
    // since B is the right most parent contract with function foo()
    function foo() public pure override(C, B) returns (string memory) {
        return super.foo();
    }
}

// Inheritance must be ordered from “most base-like” to “most derived”.
// Swapping the order of A and B will throw a compilation error.
contract F is A, B {
    function foo() public pure override(A, B) returns (string memory) {
        return super.foo();
    }
}
```
#### Fungsi Ovverriding
```solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Base
{
    function foo() virtual external view {}
}

contract Middle is Base {}

contract Inherited is Middle
{
    function foo() override public pure {}
}
```
Untuk multiple inheritance, kontrak dasar paling turunan yang mendefinisikan fungsi yang sama harus ditentukan secara eksplisit setelah kata kunci override. Dengan kata lain, Anda harus menentukan semua kontrak dasar yang mendefinisikan fungsi yang sama dan belum ditimpa oleh kontrak dasar lain (pada beberapa jalur melalui grafik pewarisan). Selain itu, jika kontrak mewarisi fungsi yang sama dari beberapa basis (tidak terkait), kontrak harus secara eksplisit menimpanya:
```solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.0 <0.9.0;

contract Base1
{
    function foo() virtual public {}
}

contract Base2
{
    function foo() virtual public {}
}

contract Inherited is Base1, Base2
{
    // Derives from multiple bases defining foo(), so we must explicitly
    // override it
    function foo() public override(Base1, Base2) {}
}
```
Penentu override eksplisit tidak diperlukan jika fungsi didefinisikan dalam kontrak dasar umum atau jika ada fungsi unik dalam kontrak dasar umum yang telah menimpa semua fungsi lainnya.
```solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.0 <0.9.0;

contract A { function f() public pure{} }
contract B is A {}
contract C is A {}
// No explicit override required
contract D is B, C {}
```
