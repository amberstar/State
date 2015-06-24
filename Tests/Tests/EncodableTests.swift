import XCTest
import State

class EncodableTests: Test {
    
    func testEcodingToAndFromJSON() {
        let inUsers =  UserTypes.decode(jsonData)
        if let inUsers = inUsers {
            inUsers.encodeToJSONFile(tempPathFor("temp.json"))
        }
        let users =  UserTypes.decodeFromJSONFile(tempPathFor("temp.json"))
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
            inUsers.encodeToPlistFile(tempPathFor("temp.plist"))
        }
        let users =  UserTypes.decodeFromPlistFile(tempPathFor("temp.plist"))
        XCTAssert(users != nil)
        XCTAssert(users?.tArr.count == 3)
        XCTAssert(users?.tImp.name == "John Doe")
        XCTAssert(users?.tDicOpt?.count == 3)
        XCTAssert(users?.tDicOpt?["item1"]?.email == "john@unit-testing.com")
        XCTAssert(users?.tArrImp.count == 3)
    }
}