// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import './ERC-165.sol';
import './interface/IERC-721.sol';

contract ERC721  is ERC165, IERC721 {

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

    function _mint(address to, uint256 tokenId) internal virtual {
       require(to != address(0), 'ERC721: miniting to the zero address');
       require(!_exists(tokenId), 'Token Already Minted');
       tokensOwner[tokenId] = to;
       tokensOwnedCount[to] = tokensOwnedCount[to] + 1;
       
       emit Transfer(address(0), to, tokenId); 
    } 

    function _transferFrom(address _to, address _from, uint256 _tokenID) internal {
        require(_to == address(0), "Trying to transfer to zero address");
        require(ownerOf(_tokenID) == _from, "Trying to transfer a token that doesn't belong to you");
        tokensOwnedCount[_from] -= 1;
        tokensOwnedCount[_to] += 1;
        tokensOwner[_tokenID] = _to;
        emit Transfer(_from, _to, _tokenID);
    }

    function transferFrom(address to, address from, uint256 tokenID) public override payable  {
        _transferFrom(to, from, tokenID);
    }

    function balanceOf(address _owner) public override view returns(uint256) {
        require(_owner != address(0), "Invalid Owner Detail");
        return tokensOwnedCount[_owner];
    }
    function ownerOf(uint256 _tokenID) public override view returns (address) {
        address owner = tokensOwner[_tokenID];
        return owner;
    }

    constructor() {
        _registerInterface(bytes4(keccak256('transferFrom(address, address, uint256)') 
                                             ^ keccak256('balanceOf(address)') 
                                             ^ keccak256('ownerOf(uint256)')));
    } 
}