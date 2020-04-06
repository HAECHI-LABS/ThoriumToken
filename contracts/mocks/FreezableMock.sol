pragma solidity 0.6.4;

import "../library/Freezable.sol";

contract FreezableMock is Freezable {

    constructor() Freezable() public {

	  }

    function whenNotFrozenMock(address target) whenNotFrozen(target) public {
        
    }
}