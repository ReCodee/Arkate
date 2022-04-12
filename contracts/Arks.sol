// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import './ERC-721Connector.sol';

contract Arks is ERC721Connector {
    
    string[] public arks;
    mapping ( string => bool ) _arksExists;

    constructor () ERC721Connector('Arkate', 'ARKT') {
        
    }

    function mint(string memory _arks) public {
        require(!_arksExists[_arks], 'Already Minted');
       arks.push(_arks);
       uint _id = arks.length - 1;
       _mint(msg.sender, _id);
       _arksExists[_arks] = true;
    }
}