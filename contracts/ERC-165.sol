// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import './interface/IERC-165.sol';

contract ERC165 is IERC165 {


    mapping ( bytes4 => bool ) private _supportInterfaces;

    constructor() {
        _registerInterface(bytes4(keccak256('supportsInterface(bytes4)')));
    } 

    function supportsInterface(bytes4 interfaceId) external view override virtual returns (bool) {
        return _supportInterfaces[interfaceId];
    }

    function _registerInterface(bytes4 interfaceId) internal {
        require ( interfaceId != 0xffffffff, 'ERC165: Invalid Interface');
        _supportInterfaces[interfaceId] = true;
    }
}