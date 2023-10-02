pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";
import {NonMatchingSelectorHelper} from "./test-utils/NonMatchingSelectorHelper.sol";

interface BitwiseOperations {
    function countOnBits(uint256 number) external pure returns (uint8);
}

contract CountOnBitsTest is Test, NonMatchingSelectorHelper {
    BitwiseOperations public bitwiseOp;

    function setUp() public {
        bitwiseOp = BitwiseOperations(HuffDeployer.config().deploy("CountOnBits"));
    }

    function testCountOnBits() public {
        // Test Case 1
        assertEq(bitwiseOp.countOnBits(157), 8, "Incorrect result for Test Case 1");

        // Test Case 2
        assertEq(bitwiseOp.countOnBits(0), 1, "Incorrect result for Test Case 2");

        // Test Case 3
        assertEq(bitwiseOp.countOnBits(255), 8, "Incorrect result for Test Case 3");

        // Test Case 4
        assertEq(bitwiseOp.countOnBits(123456789), 27, "Incorrect result for Test Case 4");
    }

    /// @notice Test that a non-matching selector reverts
    function testNonMatchingSelector(bytes32 callData) public {
        bytes4[] memory func_selectors = new bytes4[](1);
        func_selectors[0] = BitwiseOperations.countOnBits.selector;

        bool success = nonMatchingSelectorHelper(
            func_selectors,
            callData,
            address(bitwiseOp)
        );
        assert(!success);
    }
}

