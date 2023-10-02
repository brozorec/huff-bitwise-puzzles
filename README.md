# huff-puzzles with bitwise operations

Dealing with a EVM bytecode often requires a good knowledge of bitwise operations (`&`, `|`, `<<`, `>>`, `~`). This series of puzzles is heavily inspired by [RareSkills Huff Puzzles](https://github.com/rareskills/huff-puzzles). Besides the hands-on introduction to the [huff language](https://huff.sh), this repo refreshes your mind on the magic of the bitwise operations. 

## Pre-requisites

Make sure you've installed the Huff Compiler as outlined in the [Huff Docs](https://docs.huff.sh/get-started/installing/#installing-huff).

TLDR:

    curl -L get.huff.sh | bash

then:

     huffup

To verify your installation, run `huffc --help`. This should print a list of available commands for the huff compiler cli.

## Installation

To install dependencies, run:

    forge install

## How to play

Go to [GetBitAt.huff](https://github.com/brozorec/huff-bitwise-puzzles/blob/main/src/GetBitAt.huff) in the src folder and edit it as follows

```c
#define macro MAIN() = takes(0) returns(0) {
    // your Huff code goes here
}
```

Then run the test with

    forge test -vvv --mc GetBitAt

You should see something like this

    Running 1 test for test/GetBitAt.t.sol:GetBitAt
    [PASS] testGetBitAt() (gas: 5358)
    Test result: ok. 1 passed; 0 failed; finished in 4.56s

## More resources

- [Huff Documentation 🐴](https://docs.huff.sh/)
- [Bitwise Operations Tutorial](https://medium.com/@jeremythen16/master-bitwise-operations-once-and-for-all-f5283e3c9a11) (the assignments follow this tutorial)
- [Evm codes](https://evm.codes)
- [Huff Console.log](https://github.com/AmadiMichael/Huff-Console)

