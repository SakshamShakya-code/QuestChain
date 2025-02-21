// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ScavengerHuntNFT {
    address private owner;
    mapping(address => bool) private winners;
    mapping(uint256 => address) private tokenOwners;
    uint256 private tokenIdCounter;
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Not contract owner");
        _;
    }
    
    modifier onlyWinner() {
        require(winners[msg.sender], "Not a winner");
        _;
    }

    function claimReward() public onlyWinner {
        uint256 tokenId = tokenIdCounter;
        tokenOwners[tokenId] = msg.sender;
        tokenIdCounter++;
        winners[msg.sender] = false; // Prevent double claiming
    }

    function checkWinner(address participant) public view returns (bool) {
        return winners[participant];
    }

    function checkNFT(uint256 tokenId) public view returns (address) {
        return tokenOwners[tokenId];
    }
    
    function addWinners(address[] memory _winners) public onlyOwner {
        for (uint256 i = 0; i < _winners.length; i++) {
            winners[_winners[i]] = true;
        }
    }
    
    function totalMinted() public view returns (uint256) {
        return tokenIdCounter;
    }
}
