pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";
import {NonMatchingSelectorHelper} from "./test-utils/NonMatchingSelectorHelper.sol";

interface GetBitAt {
    function getBitAt(uint256, uint8) external pure returns (uint256);
}

contract GetBitAtTest is Test, NonMatchingSelectorHelper {
    GetBitAt public getBitAt;

    function setUp() public {
        getBitAt = GetBitAt(HuffDeployer.config().deploy("GetBitAt"));
    }

    function testGetBitAt() public {
        // Test Case 1
        assertEq(getBitAt.getBitAt(10, 2), 1, "Incorrect result for Test Case 1");

        // Test Case 2
        assertEq(getBitAt.getBitAt(5, 1), 0, "Incorrect result for Test Case 2");

        // Test Case 3
        assertEq(getBitAt.getBitAt(255, 7), 1, "Incorrect result for Test Case 3");

        // Test Case 4
        assertEq(getBitAt.getBitAt(0, 0), 0, "Incorrect result for Test Case 4");

        // Test Case 5
        assertEq(getBitAt.getBitAt(17, 4), 1, "Incorrect result for Test Case 5");
    }

    function testNonMatchingSelector(bytes32 callData) public {
        bytes4[] memory func_selectors = new bytes4[](1);
        func_selectors[0] = GetBitAt.getBitAt.selector;

        bool success = nonMatchingSelectorHelper(func_selectors, callData, address(getBitAt));
        assert(!success);
    }
}
