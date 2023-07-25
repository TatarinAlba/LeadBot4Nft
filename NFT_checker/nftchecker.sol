// SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NFTCHecker is ERC721URIStorage {
   using Counters for Counters.Counter;
   Counters.Counter public _tokenIds;
   address private owner;
   string[] tokenUris = ["https://ibb.co/zf6XHFz", "https://ibb.co/02LtD2Y", "https://ibb.co/y4KK4SC"];

   constructor() public ERC721("LeadBotItem", "LBI") {owner = msg.sender; }

   function buyNFT(uint256 id) public payable
    {
       require(msg.sender.balance >= msg.value, "You have no enough money");
       _tokenIds.increment();
       uint256 newItemId = _tokenIds.current();
       _mint(address(this), newItemId);
       _setTokenURI(newItemId, tokenUris[id - 1]);
    }

    function withdrawMoney() public {
       require(msg.sender == owner, "You are not allowed to do this operation");
       payable(msg.sender).transfer(address(this).balance);
   }
}