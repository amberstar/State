import XCTest
import State

class DecodableTests: Test {
    
    func testDecodingDecodableFromJSON() {
        let user = User.decode(jsonData["t"])
        let userNoEmail  = User.decode(jsonData["u"])
        let users = UserTypes.decode(jsonData)
        XCTAssert(user != nil)
        XCTAssert(user?.id == 10)
        XCTAssert(user?.name == "John Doe")
        XCTAssert(user?.email == "john@unit-testing.com")
        XCTAssert(userNoEmail != nil)
        XCTAssert(userNoEmail?.id == 10)
        XCTAssert(userNoEmail?.name == "John Doe")
        XCTAssert(userNoEmail?.email == nil)
        XCTAssert(users != nil)
        XCTAssert(users?.tArr.count == 3)
        XCTAssert(users?.tImp.name == "John Doe")
        XCTAssert(users?.tDicOpt?.count == 3)
        XCTAssert(users?.tDicOpt?["item1"]?.email == "john@unit-testing.com")
        XCTAssert(users?.tArrImp.count == 3)
    }
    
    func testDecodingDecodableFromPlist() {
        let user = User.decode(plistData["User1"])
        let userNoEmail = User.decode(plistData["User2"])
        let users = UserTypes.decode(plistData["Users"])
        XCTAssert(user != nil)
        XCTAssert(user?.id == 10)
        XCTAssert(user?.name == "John Doe")
        XCTAssert(user?.email == "john@unit-testing.com")
        XCTAssert(userNoEmail != nil)
        XCTAssert(userNoEmail?.id == 10)
        XCTAssert(userNoEmail?.name == "John Doe")
        XCTAssert(userNoEmail?.email == nil)
        XCTAssert(users != nil)
        XCTAssert(users?.tArr.count == 3)
        XCTAssert(users?.tImp.name == "John Doe")
        XCTAssert(users?.tDicOpt?.count == 3)
        XCTAssert(users?.tDicOpt?["item1"]?.email == "john@unit-testing.com")
        XCTAssert(users?.tArrImp.count == 3)
    }
    
    func testDecodingInvalidDecodableShouldFail() {
        let user = User.decode(jsonData["x"])
        XCTAssert(user == nil)
    }
}
