pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";
import {NonMatchingSelectorHelper} from "./test-utils/NonMatchingSelectorHelper.sol";

interface BitwiseOperations {
    function multiplyByTwo(uint256 number) external pure returns (uint256);

    function devideByTwo(uint256 number) external pure returns (uint256);
}

contract MultiplyDivideBy2Test is Test, NonMatchingSelectorHelper {
    BitwiseOperations public bitwiseOp;

    function setUp() public {
        bitwiseOp = BitwiseOperations(HuffDeployer.config().deploy("MultiplyDivideBy2"));
    }

    function testMultiplyBy2() public {
        // Test Case 1
        assertEq(bitwiseOp.multiplyByTwo(8), 16, "Incorrect result for Test Case 1");

        // Test Case 2
        assertEq(bitwiseOp.multiplyByTwo(0), 0, "Incorrect result for Test Case 2");

        // Test Case 3
        assertEq(bitwiseOp.multiplyByTwo(255), 510, "Incorrect result for Test Case 3");

        // Test Case 4
        assertEq(bitwiseOp.multiplyByTwo(2**254), 2**255, "Incorrect result for Test Case 4");

        // Test Case 5
        assertEq(bitwiseOp.multiplyByTwo(123456789), 246913578, "Incorrect result for Test Case 5");
    }

    // Test devideByTwo function
    function testDivideBy2() public {
        // Test Case 1
        assertEq(bitwiseOp.devideByTwo(16), 8, "Incorrect result for Test Case 1");

        // Test Case 2
        assertEq(bitwiseOp.devideByTwo(0), 0, "Incorrect result for Test Case 2");

        // Test Case 3
        assertEq(bitwiseOp.devideByTwo(510), 255, "Incorrect result for Test Case 3");

        // Test Case 4
        assertEq(bitwiseOp.devideByTwo(2**255), 2**254, "Incorrect result for Test Case 4");

        // Test Case 5
        assertEq(bitwiseOp.devideByTwo(987654321), 493827160, "Incorrect result for Test Case 5");
    }

    /// @notice Test that a non-matching selector reverts
    function testNonMatchingSelector(bytes32 callData) public {
        bytes4[] memory func_selectors = new bytes4[](2);
        func_selectors[0] = BitwiseOperations.multiplyByTwo.selector;
        func_selectors[1] = BitwiseOperations.devideByTwo.selector;

        bool success = nonMatchingSelectorHelper(
            func_selectors,
            callData,
            address(bitwiseOp)
        );
        assert(!success);
    }
}

