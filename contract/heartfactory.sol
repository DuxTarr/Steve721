pragma solidity ^0.5.11;

contract HeartFactory {

    uint8 constant STATUS_NEW = 0;
    uint8 constant STATUS_POTION = 1;
    uint8 constant STATUS_USED = 2;


    event NewHeart(uint id, uint _userId, uint _steveId, uint _appearanceDna, uint _skillsDna);
    event NewPotion(uint id, uint _userId, uint _appearanceDna, uint _skillsDna);
    event PotionUsed(uint id, uint _userId);

    struct Heart {
        uint steveId;
        uint appearanceDna;
        uint skillsDna;
        uint8 status;
    }

    Heart[] public hearts;

    mapping (uint => uint) public heartToOwner;
    mapping (uint => uint) ownerHeartCount;

    function _createHeart(uint _userId, uint _steveId, uint _appearanceDna, uint _skillsDna) public {
        uint id = hearts.push(Heart(_steveId, _appearanceDna, _skillsDna, STATUS_NEW)) - 1;
        heartToOwner[id] = _userId;
        ownerHeartCount[_userId]++;
        emit NewHeart(id, _userId, _steveId, _appearanceDna, _skillsDna);
    }

    function useHeart(uint id) public {
        require(hearts[id].status == STATUS_NEW);
        //TODO create potion mask
        hearts[id].status = STATUS_POTION;
    }

    function takePotion(uint id) public {
        require(hearts[id].status == STATUS_POTION);
        //TODO change steve genome
        hearts[id].status = STATUS_USED;

    }

}