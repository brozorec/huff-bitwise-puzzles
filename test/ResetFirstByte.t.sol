pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";
import {NonMatchingSelectorHelper} from "./test-utils/NonMatchingSelectorHelper.sol";

interface ResetFirstByte {
    function resetFirstByte(uint256) external view returns (uint256);
}

contract ResetFirstByteTest is Test, NonMatchingSelectorHelper {
    ResetFirstByte public resetFirstByte;

    function setUp() public {
        resetFirstByte = ResetFirstByte(HuffDeployer.config().deploy("ResetFirstByte"));
    }

    function testResetFirstByte() public {
        // Test Case 1
        assertEq(resetFirstByte.resetFirstByte(33469), 33280, "Incorrect result for Test Case 1");

        // Test Case 2
        assertEq(resetFirstByte.resetFirstByte(0), 0, "Incorrect result for Test Case 2");

        // Test Case 3
        assertEq(resetFirstByte.resetFirstByte(255), 0, "Incorrect result for Test Case 3");

        // Test Case 4
        assertEq(resetFirstByte.resetFirstByte(65536), 65280, "Incorrect result for Test Case 4");

        // Test Case 5
        assertEq(resetFirstByte.resetFirstByte(987654321), 987654176, "Incorrect result for Test Case 5");
    }

    function testNonMatchingSelector(bytes32 callData) public {
        bytes4[] memory func_selectors = new bytes4[](1);
        func_selectors[0] = ResetFirstByte.resetFirstByte.selector;

        bool success = nonMatchingSelectorHelper(func_selectors, callData, address(resetFirstByte));
        assert(!success);
    }
}
