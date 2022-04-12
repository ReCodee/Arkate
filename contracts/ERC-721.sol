// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;


contract ERC721 {

    event Transfer (
        address indexed from,
        address indexed to,
        uint256 indexed tokenId ); 

    mapping (uint256 => address) tokensOwner;
    mapping (address => uint256) tokensOwnedCount;

    function _exists(uint256 tokenID) internal view returns(bool) {
      address owner = tokensOwner[tokenID];
      return owner != address(0);
    }

    function _mint(address to, uint256 tokenId) internal {
       require(to != address(0), 'ERC721: miniting to the zero address');
       require(!_exists(tokenId), 'Token Already Minted');
       tokensOwner[tokenId] = to;
       tokensOwnedCount[to] = tokensOwnedCount[to] + 1;
       
       emit Transfer(address(0), to, tokenId); 
    } 
}