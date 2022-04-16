// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

 import './ERC-721.sol';
 import './interface/IERC-721Enumerable.sol';

 contract ERC721Enumerable is ERC721, IERC721Enumerable {

     uint256[] private __allTokens;
     
     mapping ( uint256 => uint256 ) _allTokensIndex;
     mapping ( address => uint256[] ) _ownedTokens;
     mapping ( uint256 => uint256 ) private _ownedTokensIndex;

    //function totalSupply() external view returns (uint256);

    //function tokenByIndex(uint256 _index) external view returns (uint256);

    //function tokenOfOwnerByIndex(address _owner, uint256 _index) external view returns (uint256);

    function _mint(address _to, uint256 tokenID) internal override(ERC721) {
        super._mint(_to, tokenID);
        addTokenToAllTokensEnumeration(tokenID);
        addTokenToOwnerEnumeration(_to, tokenID);
    }

    function addTokenToAllTokensEnumeration(uint256 tokenID) private {
       _allTokensIndex[tokenID] = __allTokens.length;
       __allTokens.push(tokenID);
    }

    function addTokenToOwnerEnumeration(address to, uint256 tokenID) private {
        _ownedTokensIndex[tokenID] = _ownedTokens[to].length; 
        _ownedTokens[to].push(tokenID); 
    }
    
    function tokenByIndex(uint index) public view override returns (uint256) {
        require(index < totalSupply(), "Global!, Index Out Of Bound" );
        return __allTokens[index];
    }

    function tokenOfOwnerByIndex(address owner, uint index) public view override returns(uint256) {
        require(index < balanceOf(owner), 'Owner index out of bound');
        return _ownedTokens[owner][index];
    }

    function totalSupply() public view override returns(uint256) {

        return __allTokens.length;
    }

    constructor() {
        _registerInterface(bytes4(keccak256('tokenOfOwnerByIndex(address, address, uint256)') 
                                             ^ keccak256('tokenByIndex(uint256)') 
                                             ^ keccak256('totalSupply()')));
    } 
    
}