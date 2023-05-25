// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./interfaces/Uniswap.sol";

contract Swap {
    // router provides a variety of methods to safely swap to and from different assets

    address private constant UNISWAP_V2_ROUTER = 
        0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;

    //tokens to swap
    address private constant WETH = 
        0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address private constant DAI = 
        0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address private constant USDC = 
        0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;


    // implement this interface
    IUniSwapV2Router private router = IUniSwapV2Router(UNISWAP_V2_ROUTER);


    function swap(
        address _tokenIn,
        address _tokenOut,
        uint256 _amountIn,
        uint256 _amountOutMin, // ?
        address to
    ) external {
        /// https://docs.openzeppelin.com/contracts/2.x/api/token/erc20#IERC20-transferFrom-address-address-uint256-
        IERC20(_tokenIn).transferFrom(msg.sender, address(this), _amountIn);

        // https://docs.openzeppelin.com/contracts/2.x/api/token/erc20#IERC20-approve-address-uint256-
        IERC20(_tokenIn).approve(UNISWAP_V2_ROUTER, _amountIn);

        address[] memory path; //this path gets the best deal, also needed as input for swapExactTokensForTokens
        if (_tokenIn == WETH || _tokenOut == WETH) {
            path = new address[](2);
            path[0] = _tokenIn;
            path[1] = _tokenOut;
        }
        else {
            path = new address[](3);
            path[0] = _tokenIn;
            path[1] = WETH;
            path[2] = _tokenOut;
        }
        

    }
    
}