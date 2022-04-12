// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import './ERC-721Metadata.sol';
import './ERC-721.sol';

contract ERC721Connector is ERC721Metadata, ERC721 {
  
constructor( string memory name, string memory  symbol ) ERC721Metadata(name, symbol) {
 
}

}