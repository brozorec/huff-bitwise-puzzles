pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";
import {NonMatchingSelectorHelper} from "./test-utils/NonMatchingSelectorHelper.sol";

interface BitwiseOperations {
    function isEven(uint256 number) external pure returns (bool);
}

contract IsEvenTest is Test, NonMatchingSelectorHelper {
    BitwiseOperations public bitwiseOp;

    function setUp() public {
        bitwiseOp = BitwiseOperations(HuffDeployer.config().deploy("IsEven"));
    }

    // Test isEven function
    function testIsEven() public {
        // Test Case 1
        assertEq(bitwiseOp.isEven(157), false, "Incorrect result for Test Case 1");

        // Test Case 2
        assertEq(bitwiseOp.isEven(156), true, "Incorrect result for Test Case 2");

        // Test Case 3
        assertEq(bitwiseOp.isEven(0), true, "Incorrect result for Test Case 3");

        // Test Case 4
        assertEq(bitwiseOp.isEven(255), false, "Incorrect result for Test Case 4");

        // Test Case 5
        assertEq(bitwiseOp.isEven(2**255), true, "Incorrect result for Test Case 5");
    }

    /// @notice Test that a non-matching selector reverts
    function testNonMatchingSelector(bytes32 callData) public {
        bytes4[] memory func_selectors = new bytes4[](1);
        func_selectors[0] = BitwiseOperations.isEven.selector;

        bool success = nonMatchingSelectorHelper(
            func_selectors,
            callData,
            address(bitwiseOp)
        );
        assert(!success);
    }
}

