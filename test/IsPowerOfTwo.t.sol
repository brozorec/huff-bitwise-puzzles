pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";
import {NonMatchingSelectorHelper} from "./test-utils/NonMatchingSelectorHelper.sol";

interface BitwiseOperations {
    function isPowerOfTwo(uint256 number) external pure returns (bool);
}

contract IsPowerOfTwoTest is Test, NonMatchingSelectorHelper {
    BitwiseOperations public bitwiseOp;

    function setUp() public {
        bitwiseOp = BitwiseOperations(HuffDeployer.config().deploy("IsPowerOfTwo"));
    }

    function testIsPowerOfTwo() public {
        // Test Case 1
        assertEq(bitwiseOp.isPowerOfTwo(16), true, "Incorrect result for Test Case 1");

        // Test Case 2
        assertEq(bitwiseOp.isPowerOfTwo(17), false, "Incorrect result for Test Case 2");

        // Test Case 3
        assertEq(bitwiseOp.isPowerOfTwo(8), true, "Incorrect result for Test Case 3");

        // Test Case 4
        assertEq(bitwiseOp.isPowerOfTwo(0), false, "Incorrect result for Test Case 4");

        // Test Case 5
        assertEq(bitwiseOp.isPowerOfTwo(1024), true, "Incorrect result for Test Case 5");
    }

    /// @notice Test that a non-matching selector reverts
    function testNonMatchingSelector(bytes32 callData) public {
        bytes4[] memory func_selectors = new bytes4[](1);
        func_selectors[0] = BitwiseOperations.isPowerOfTwo.selector;

        bool success = nonMatchingSelectorHelper(
            func_selectors,
            callData,
            address(bitwiseOp)
        );
        assert(!success);
    }
}

