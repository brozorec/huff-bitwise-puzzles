pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";
import {NonMatchingSelectorHelper} from "./test-utils/NonMatchingSelectorHelper.sol";

interface ResetFirst8Bits {
    function resetFirst8Bits(uint256) external view returns (uint256);
}

contract ResetFirst8BitsTest is Test, NonMatchingSelectorHelper {
    ResetFirst8Bits public resetFirst8Bits;

    function setUp() public {
        resetFirst8Bits = ResetFirst8Bits(HuffDeployer.config().deploy("ResetFirst8Bits"));
    }

    function testResetFirst8Bits() public {
        // Test Case 1
        assertEq(resetFirst8Bits.resetFirst8Bits(33469), 33280, "Incorrect result for Test Case 1");

        // Test Case 2
        assertEq(resetFirst8Bits.resetFirst8Bits(0), 0, "Incorrect result for Test Case 2");

        // Test Case 3
        assertEq(resetFirst8Bits.resetFirst8Bits(255), 0, "Incorrect result for Test Case 3");

        // Test Case 4
        assertEq(resetFirst8Bits.resetFirst8Bits(65536), 65280, "Incorrect result for Test Case 4");

        // Test Case 5
        assertEq(resetFirst8Bits.resetFirst8Bits(987654321), 987654176, "Incorrect result for Test Case 5");
    }

    function testNonMatchingSelector(bytes32 callData) public {
        bytes4[] memory func_selectors = new bytes4[](1);
        func_selectors[0] = ResetFirst8Bits.resetFirst8Bits.selector;

        bool success = nonMatchingSelectorHelper(func_selectors, callData, address(resetFirst8Bits));
        assert(!success);
    }
}
