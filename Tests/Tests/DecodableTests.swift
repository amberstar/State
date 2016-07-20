import XCTest
@testable
import State

class DecodableTests: Test {
    
    func testDecodingDecodableFromJSON() {
        let user = User.read(from: Store(data: jsonData["t"] as! [String : AnyObject]))
        let userNoEmail  = User.read(from: Store(data: jsonData["u"] as! [String : AnyObject]))
        let users = UserTypes.read(from: Store(data: jsonData))
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
        let user = User.read(from: Store(data: plistData["User1"] as! [String : AnyObject]))
        let userNoEmail = User.read(from: Store(data: plistData["User2"] as! [String : AnyObject]))
        let users = UserTypes.read(from: Store(data: plistData["Users"] as! [String : AnyObject]))
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
        let user = User.read(from: Store(data: jsonData["x"] as! [String : AnyObject]))
        XCTAssert(user == nil)
    }
}
