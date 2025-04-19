// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IPlugin.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Core is Ownable {
    constructor() Ownable(msg.sender) {} // Pass initial owner to Ownable constructor
    mapping(uint256 => address) public plugins;

    function addPlugin(uint256 pluginId, address pluginAddress) external onlyOwner {
        require(pluginAddress != address(0), "Invalid address");
        plugins[pluginId] = pluginAddress;
    }

    function removePlugin(uint256 pluginId) external onlyOwner {
        require(plugins[pluginId] != address(0), "Plugin does not exist");
        delete plugins[pluginId];
    }

    function executePlugin(uint256 pluginId, uint256 input) external returns (uint256) {
        address plugin = plugins[pluginId];
        require(plugin != address(0), "Plugin not found");
        return IPlugin(plugin).performAction(input);
    }
}
