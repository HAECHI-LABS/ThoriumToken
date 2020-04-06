pragma solidity 0.6.4;

import "./ERC20Lockable.sol";
import "./ERC20Burnable.sol";
import "./ERC20Mintable.sol";
import "./library/Pausable.sol";
import "./library/Freezable.sol";

contract Thorium is
    ERC20Lockable,
    ERC20Burnable,
    ERC20Mintable,
    Freezable
{
    string constant private _name = "THORIUM";
    string constant private _symbol = "TORM";
    uint8 constant private _decimals = 18;
    uint256 constant private _initial_supply = 1_000_000_000;

    constructor() public Ownable() {
        _mint(msg.sender, _initial_supply * (10**uint256(_decimals)));
    }

    function transfer(address to, uint256 amount)
        override
        external
        whenNotFrozen(msg.sender)
        whenNotPaused
        checkLock(msg.sender, amount)
        returns (bool success)
    {
        require(
            to != address(0),
            "TORM/transfer : Should not send to zero address"
        );
        _transfer(msg.sender, to, amount);
        success = true;
    }

    function transferFrom(address from, address to, uint256 amount)
        override
        external
        whenNotFrozen(from)
        whenNotPaused
        checkLock(from, amount)
        returns (bool success)
    {
        require(
            to != address(0),
            "TORM/transferFrom : Should not send to zero address"
        );
        _transfer(from, to, amount);
        _approve(
            from,
            msg.sender,
            _allowances[from][msg.sender].sub(
                amount,
                "TORM/transferFrom : Cannot send more than allowance"
            )
        );
        success = true;
    }

    function approve(address spender, uint256 amount)
        override
        external
        returns (bool success)
    {
        require(
            spender != address(0),
            "TORM/approve : Should not approve zero address"
        );
        _approve(msg.sender, spender, amount);
        success = true;
    }

    function name() override external view returns (string memory tokenName) {
        tokenName = _name;
    }

    function symbol() override external view returns (string memory tokenSymbol) {
        tokenSymbol = _symbol;
    }

    function decimals() override external view returns (uint8 tokenDecimals) {
        tokenDecimals = _decimals;
    }
}
