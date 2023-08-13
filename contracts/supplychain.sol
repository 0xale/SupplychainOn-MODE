// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SupplyChain {
    enum State {
        Created,
        InTransit,
        Delivered,
        Completed
    }

    struct Product {
        address creator;
        string name;
        uint256 creationTimestamp;
        State currentState;
        address currentOwner;
        uint256 price;
        address[] shipmentHistory;
    }

    mapping(uint256 => Product) public products;
    uint256 public productCount;

    IERC20 public token; // Token for payments
    address public admin; // Contract administrator

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only the admin can perform this action");
        _;
    }

    modifier onlyOwner(uint256 _productId) {
        require(msg.sender == products[_productId].currentOwner, "Only the current owner can perform this action");
        _;
    }

    modifier onlyInState(uint256 _productId, State _state) {
        require(products[_productId].currentState == _state, "Product is not in the required state");
        _;
    }

    constructor(address _tokenAddress) {
        token = IERC20(_tokenAddress);
        admin = msg.sender;
    }

    function createProduct(string memory _name, uint256 _price) external {
        productCount++;
        products[productCount] = Product({
            creator: msg.sender,
            name: _name,
            creationTimestamp: block.timestamp,
            currentState: State.Created,
            currentOwner: address(0),
            price: _price,
            shipmentHistory: new address[](0)
        });
    }

    function updateProductState(uint256 _productId, State _newState) internal {
        products[_productId].currentState = _newState;
        products[_productId].shipmentHistory.push(msg.sender);
    }

    function transferProductOwnership(uint256 _productId, address _newOwner) external onlyOwner(_productId) {
        products[_productId].currentOwner = _newOwner;
        products[_productId].shipmentHistory.push(_newOwner);
    }

    function updateProductPrice(uint256 _productId, uint256 _newPrice) external onlyAdmin {
        products[_productId].price = _newPrice;
    }

    function makePayment(uint256 _productId) external onlyInState(_productId, State.Created) {
        Product storage product = products[_productId];
        require(product.currentOwner != address(0), "Product owner must be set");
        uint256 price = product.price;
        require(token.transferFrom(msg.sender, product.creator, price), "Payment failed");
        updateProductState(_productId, State.InTransit);
    }

    function completeDelivery(uint256 _productId) external onlyInState(_productId, State.InTransit) onlyOwner(_productId) {
        updateProductState(_productId, State.Delivered);
    }

    function completeProduct(uint256 _productId) external onlyInState(_productId, State.Delivered) onlyOwner(_productId) {
        updateProductState(_productId, State.Completed);
    }

    function getShipmentHistory(uint256 _productId) external view returns (address[] memory) {
        return products[_productId].shipmentHistory;
    }
}
