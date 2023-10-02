pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";
import {NonMatchingSelectorHelper} from "./test-utils/NonMatchingSelectorHelper.sol";

interface GetByteAtOffset {
    function getByteAtOffset(uint256 number, uint8 byteOffset) external pure returns (uint8);
}

contract GetByteAtOffsetTest is Test, NonMatchingSelectorHelper {
    GetByteAtOffset public getByteAtOffset;

    function setUp() public {
        getByteAtOffset = GetByteAtOffset(HuffDeployer.config().deploy("GetByteAtOffset"));
    }

    // Test GetByteAtOffset function
    function testGetByteAtOffset() public {
        // Test Case 1
        assertEq(getByteAtOffset.getByteAtOffset(33469, 8), 189, "Incorrect result for Test Case 1");

        // Test Case 2
        assertEq(getByteAtOffset.getByteAtOffset(65535, 0), 255, "Incorrect result for Test Case 2");

        // Test Case 3
        assertEq(getByteAtOffset.getByteAtOffset(0, 3), 0, "Incorrect result for Test Case 3");

        // Test Case 4
        assertEq(getByteAtOffset.getByteAtOffset(123456789, 16), 151, "Incorrect result for Test Case 4");

        // Test Case 5
        assertEq(getByteAtOffset.getByteAtOffset(255, 4), 0, "Incorrect result for Test Case 5");
    }

    function testNonMatchingSelector(bytes32 callData) public {
        bytes4[] memory func_selectors = new bytes4[](1);
        func_selectors[0] = GetByteAtOffset.getByteAtOffset.selector;

        bool success = nonMatchingSelectorHelper(func_selectors, callData, address(getByteAtOffset));
        assert(!success);
    }
}
