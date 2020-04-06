pragma solidity 0.6.4;

import "./Ownable.sol";

contract Pausable is Ownable {
    bool internal paused;

    event Paused();
    event Unpaused();

    modifier whenPaused() {
        require(paused);
        _;
    }

    modifier whenNotPaused() {
        require(!paused);
        _;
    }

    function pause() external onlyOwner whenNotPaused returns (bool success) {
        paused = true;
        emit Paused();
        success = true;
    }

    function unPause() external onlyOwner whenPaused returns (bool success) {
        paused = false;
        emit Unpaused();
        success = true;
    }

    function getPaused() external view returns (bool success) {
        return paused;
    }
}
