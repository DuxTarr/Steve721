pragma solidity ^0.5.11;

contract SteveFactory {

    //TODO add ownership

    event NewSteve(uint id, uint userId, string name, uint _appearanceDna, uint _skillsDna);

    uint dnaDigits = 16;
    uint dnaModulus = 16 ** dnaDigits;

    struct Steve {
        string name;
        uint appearanceDna;
        uint skillsDna;
        bool active;
    }

    Steve[] public steves;

    mapping (uint => uint) public steveToOwner;
    mapping (uint => uint) public ownerSteveCount;

    function getSteve(uint _id)
    public
    view
    returns(
        string memory name,
        uint appearanceDna,
        uint skillsDna,
        bool active
    ) {
        name = steves[_id].name;
        appearanceDna = steves[_id].appearanceDna;
        skillsDna = steves[_id].skillsDna;
        active = steves[_id].active;
    }

    function _createSteve(uint _userId, string memory _name, uint _appearanceDna, uint _skillsDna) internal {
        uint id = steves.push(Steve(_name, _appearanceDna, _skillsDna, true)) - 1;
        steveToOwner[id] = _userId;
        ownerSteveCount[_userId]++;
        emit NewSteve(id, _userId, _name, _appearanceDna, _skillsDna);
    }

    function _generateRandomDna(string memory _str) internal view returns (uint, uint) {
        uint appearanceDna = uint(keccak256(abi.encodePacked(_str)));
        uint skillsDna = uint(keccak256(abi.encodePacked(block.timestamp)));
        return (appearanceDna % dnaModulus, skillsDna % dnaModulus);
    }

    function createRandomSteve(uint _userId, string memory _name) public {
        require(ownerSteveCount[_userId] < 10);
        (uint appearanceDna, uint skillsDna)  = _generateRandomDna(_name);
        _createSteve(_userId, _name, appearanceDna, skillsDna);
    }

    function deleteSteve(uint _id, uint _userId) public {
        steves[_id].active = false;
        ownerSteveCount[_userId]--;
    }

    function transferSteve(uint _id, uint _userId) public {
        ownerSteveCount[steveToOwner[_id]]--;
        steveToOwner[_id] = _userId;
        ownerSteveCount[_userId]++;
    }

}
