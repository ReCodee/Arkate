// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

 import './ERC-721.sol';

 contract ERC721Enumerable is ERC721 {

     uint256[] private __allTokens;
     
     mapping ( uint256 => uint256 ) _allTokensIndex;
     mapping ( address => uint256[] ) _ownedTokens;
     mapping ( uint256 => uint256 ) private _ownedTokensIndex;

    //function totalSupply() external view returns (uint256);

    //function tokenByIndex(uint256 _index) external view returns (uint256);

    //function tokenOfOwnerByIndex(address _owner, uint256 _index) external view returns (uint256);

    function _mint(address _to, uint256 tokenID) internal override(ERC721) {
        super._mint(_to, tokenID);
        addTokenToTotalSupply(tokenID);
    }

    function addTokenToTotalSupply(uint256 tokenID) private {
       __allTokens.push(tokenID);
    }

    function totalSuppy() external view returns(uint256) {
        return __allTokens.length;
    }
}