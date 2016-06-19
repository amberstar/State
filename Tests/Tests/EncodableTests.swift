import XCTest
import State

class EncodableTests: Test {
    
    func testEcodingToAndFromJSON() {
        let inUsers =  UserTypes.decode(jsonData)
        if let inUsers = inUsers {
            inUsers.save(.json, path: tempPathFor("temp.json"))
        }
        let users =  UserTypes(.json, path: tempPathFor("temp.json"))
        XCTAssert(users != nil)
        XCTAssert(users?.tArr.count == 3)
        XCTAssert(users?.tImp.name == "John Doe")
        XCTAssert(users?.tDicOpt?.count == 3)
        XCTAssert(users?.tDicOpt?["item1"]?.email == "john@unit-testing.com")
        XCTAssert(users?.tArrImp.count == 3)
    }

    func testEcodingToAndFromPlist() {
        let inUsers = UserTypes.decode(plistData["Users"])
        if let inUsers = inUsers {
            inUsers.save(.plist, path: tempPathFor("temp.plist"))
        }
        let users =  UserTypes(.plist, path: tempPathFor("temp.plist"))
        XCTAssert(users != nil)
        XCTAssert(users?.tArr.count == 3)
        XCTAssert(users?.tImp.name == "John Doe")
        XCTAssert(users?.tDicOpt?.count == 3)
        XCTAssert(users?.tDicOpt?["item1"]?.email == "john@unit-testing.com")
        XCTAssert(users?.tArrImp.count == 3)
    }
}
