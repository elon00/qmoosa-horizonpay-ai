// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title HorizonPayEscrow
 * @dev HashKey Chain A2A Stablecoin Escrow & x402 Authorization Protocol
 * @notice Provides non-custodial agent-to-agent escrow with automated policy checks.
 */
contract HorizonPayEscrow {
    struct PaymentChannel {
        address buyerAgent;
        address sellerAgent;
        uint256 depositAmount;
        uint256 settledAmount;
        uint256 expiration;
        bool isActive;
    }

    mapping(bytes32 => PaymentChannel) public channels;
    mapping(address => uint256) public agentBalances;
    address public immutable treasury;

    event ChannelOpened(bytes32 indexed channelId, address indexed buyer, address indexed seller, uint256 amount);
    event PaymentSettled(bytes32 indexed channelId, uint256 amount, bytes32 indexed receiptProof);
    event ChannelClosed(bytes32 indexed channelId, uint256 refundedAmount);

    constructor(address _treasury) {
        require(_treasury != address(0), "Invalid treasury");
        treasury = _treasury;
    }

    function openChannel(bytes32 channelId, address sellerAgent, uint256 duration) external payable {
        require(msg.value > 0, "Zero deposit");
        require(!channels[channelId].isActive, "Channel already exists");

        channels[channelId] = PaymentChannel({
            buyerAgent: msg.sender,
            sellerAgent: sellerAgent,
            depositAmount: msg.value,
            settledAmount: 0,
            expiration: block.timestamp + duration,
            isActive: true
        });

        emit ChannelOpened(channelId, msg.sender, sellerAgent, msg.value);
    }

    function settlePayment(bytes32 channelId, uint256 amount, bytes32 receiptProof) external {
        PaymentChannel storage chan = channels[channelId];
        require(chan.isActive, "Channel inactive");
        require(msg.sender == chan.buyerAgent || msg.sender == chan.sellerAgent, "Unauthorized");
        require(chan.settledAmount + amount <= chan.depositAmount, "Exceeds deposit");

        chan.settledAmount += amount;
        payable(chan.sellerAgent).transfer(amount);

        emit PaymentSettled(channelId, amount, receiptProof);
    }

    function closeChannel(bytes32 channelId) external {
        PaymentChannel storage chan = channels[channelId];
        require(chan.isActive, "Channel inactive");
        require(msg.sender == chan.buyerAgent, "Only buyer can close");
        require(block.timestamp >= chan.expiration || chan.settledAmount == chan.depositAmount, "Lock period active");

        chan.isActive = false;
        uint256 refund = chan.depositAmount - chan.settledAmount;
        if (refund > 0) {
            payable(chan.buyerAgent).transfer(refund);
        }

        emit ChannelClosed(channelId, refund);
    }
}
