## Technologies

- Solidity `^0.8.0`
- Remix IDE (for testing & deployment)
- Ethereum Virtual Machine (EVM)

## Contracts Overview

### `IERC20.sol`
Standard ERC-20 interface with required functions and events.

### `Owned.sol`
Adds ownership logic to restrict access to admin-only functions.

### `ERC20.sol`
Main token contract implementing:
- `transfer`, `approve`, `transferFrom`
- `mint()` — internal, owner-only
- `burn()` — user-controlled
- `balanceOf`, `totalSupply`, `allowance`

### `MyToken.sol`
ERC-20 token with preset name (`"My token"`), symbol (`"Mt"`), and supply (`5000`). All tokens are minted to the distributor contract.

### `MyTokenDistributor.sol`
A simple distributor contract that:
- Accepts Ether and sends tokens (`buy()`)
- Receives tokens and sends Ether back (`sell()`)
- Allows owner to withdraw all ETH from contract
- Uses `receive()` fallback to trigger `buy()`


## License

MIT License.  
This code is for educational and demonstration purposes.
