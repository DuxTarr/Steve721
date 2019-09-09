pragma solidity ^0.5.11;

import "./heartfactory.sol";
import "./stevefactory.sol";

contract Fighting is SteveFactory, HeartFactory {

    event NewFight(uint winnerId, string loserId);

    mapping (uint => uint) public lastFight; //steveId to timestamp

    function fight(uint _steveOneId, uint _steveTwoId) public {
        //TODO check lastFight
        //TODO add fight engine from external contract
        uint = winnerId;
        uint = loserId;
        _createHeart(steveToOwner[winnerId], loserId, steves[loserId].appearanceDna, steves[loserId].skillsDna);
        emit NewFight(id, winnerId, loserId);
        //TODO save lastFight info
    }

}
