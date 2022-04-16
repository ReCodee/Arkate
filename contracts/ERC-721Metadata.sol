// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import './interface/IERC-721Metadata.sol';
import './ERC-165.sol';

contract ERC721Metadata is IERC721Metadata, ERC165 {
    string private _name;
    string private _symbol;

    constructor ( string memory named, string memory symbolified ) {
           _name = named;
           _symbol = symbolified;
           _registerInterface(bytes4(keccak256('name()') 
                                             ^ keccak256('symbol()')));
    }

    function name() external view override returns ( string memory ) {
         return _name;
    }

    function symbol() external view override returns ( string memory ) {
         return _symbol;
    }
}