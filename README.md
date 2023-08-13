# Supply Chain Management Smart Contract

This repository contains a Solidity smart contract for a supply chain management system. The contract allows tracking the lifecycle of products from creation to delivery using the MODE blockchain.

##

**contract deployed on mode**: https://sepolia.explorer.mode.network/address/0xb1e52226fB72585BFA3e63bA8Cb12b4D6EeFd255
**Token Contract** : https://sepolia.explorer.mode.network/address/0x16624074F5cFff83F51E9bA40F1e34FbA6fa90A5

## Features

- Product creation with creator's details, name, price, and creation timestamp.
- State management with various states (Created, InTransit, Delivered, Completed).
- Ownership transfer between participants.
- Payment handling using an ERC20 token.
- Shipment history tracking.
- Admin role for managing contract-related actions.

## Getting Started

### Prerequisites

- Solidity development environment (Truffle, Remix, etc.)
- An ERC20 token contract (for payment handling)

### Deployment

1. Deploy the ERC20 token contract on the Ethereum network.
2. Deploy the Supply Chain Management smart contract, providing the address of the deployed ERC20 token contract.

### Usage

1. **Create a Product**: Call the `createProduct` function to create a new product. Provide the product name and price in ETH.

2. **Update State**: Call the `updateProductState` function to update the state of a product. This function should be used to move the product through its lifecycle.

3. **Transfer Ownership**: Call the `transferProductOwnership` function to transfer ownership of a product to another address.

4. **Update Price**: Call the `updateProductPrice` function (admin-only) to update the price of a product.

5. **Make Payment**: Call the `makePayment` function to make a payment for a product using the ERC20 token.

6. **Complete Delivery**: Call the `completeDelivery` function to mark the delivery of a product as completed.

7. **Complete Product**: Call the `completeProduct` function to mark a product as completed.

8. **Get Shipment History**: Call the `getShipmentHistory` function to retrieve the shipment history of a product.

## Contributing

Contributions to this project are welcome! To contribute:

1. Fork the repository.
2. Create a new branch for your feature: `git checkout -b feature-name`
3. Commit your changes: `git commit -m "Add feature"`
4. Push to the branch: `git push origin feature-name`
5. Create a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
