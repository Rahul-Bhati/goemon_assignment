// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../lib/forge-std/src/Test.sol";
import "../lib/forge-std/src/console.sol";
import "../src/Core.sol";
import "../src/ExamplePlugin.sol";
import "../src/VaultPlugin.sol";

contract CoreTest is Test {
    Core core;
    ExamplePlugin examplePlugin;
    VaultPlugin vaultPlugin;

    function setUp() public {
        core = new Core();
        examplePlugin = new ExamplePlugin();
        vaultPlugin = new VaultPlugin();
        core.addPlugin(1, address(examplePlugin));
        core.addPlugin(2, address(vaultPlugin));
    }

    function testExamplePlugin() public {
        uint256 result = core.executePlugin(1, 5);
        // assertEq(uint16(10), uint16(10));
        assertEq(result, 25);
    }

   function testVaultPlugin() public {
        uint256 vaultId = core.executePlugin(2, 100);
        (address owner, uint256 balance) = vaultPlugin.vaults(vaultId);
        console.log("Vault ID:", vaultId);
        console.log("Owner:", owner);
        assertEq(owner, address(core)); // <- Corrected
        assertEq(balance, 100);
    }

}
