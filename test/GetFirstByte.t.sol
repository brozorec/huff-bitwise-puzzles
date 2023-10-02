pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";
import {NonMatchingSelectorHelper} from "./test-utils/NonMatchingSelectorHelper.sol";

interface GetFirstByte {
    function getFirstByte(uint256) external view returns (uint256);
}

contract GetFirstByteTest is Test, NonMatchingSelectorHelper {
    GetFirstByte public getFirstByte;

    function setUp() public {
        getFirstByte = GetFirstByte(HuffDeployer.config().deploy("GetFirstByte"));
    }

    function testGetFirstByte() public {
        // Test Case 1
        assertEq(getFirstByte.getFirstByte(33469), 189, "Incorrect result for Test Case 1");

        // Test Case 2
        assertEq(getFirstByte.getFirstByte(0), 0, "Incorrect result for Test Case 2");

        // Test Case 3
        assertEq(getFirstByte.getFirstByte(255), 255, "Incorrect result for Test Case 3");

        // Test Case 4
        assertEq(getFirstByte.getFirstByte(65536), 0, "Incorrect result for Test Case 4");

        // Test Case 5
        assertEq(getFirstByte.getFirstByte(987654321), 137, "Incorrect result for Test Case 5");
    }

    function testNonMatchingSelector(bytes32 callData) public {
        bytes4[] memory func_selectors = new bytes4[](1);
        func_selectors[0] = GetFirstByte.getFirstByte.selector;

        bool success = nonMatchingSelectorHelper(func_selectors, callData, address(getFirstByte));
        assert(!success);
    }
}
