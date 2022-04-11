// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import './ERC-721Connector.sol';

contract Arks is ERC721Connector {
    
    constructor () ERC721Connector('Arkate', 'ARKT') {
        
    }
}