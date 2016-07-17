import XCTest
@testable
import State

class EncodableTests: Test {
    
    func testEcodingToAndFromJSON() {
        let inUsers =  UserTypes.read(from: Store(data: jsonData))
        if let inUsers = inUsers {
            _ = inUsers.write(to: tempURLFor("temp.json"), format: .json)
        }
        let users =  UserTypes(file: tempURLFor("temp.json"), format: .json)
        XCTAssert(users != nil)
        XCTAssert(users?.tArr.count == 3)
        XCTAssert(users?.tImp.name == "John Doe")
        XCTAssert(users?.tDicOpt?.count == 3)
        XCTAssert(users?.tDicOpt?["item1"]?.email == "john@unit-testing.com")
        XCTAssert(users?.tArrImp.count == 3)
    }

    func testEcodingToAndFromPlist() {
        let inUsers = UserTypes.read(from: Store(data: plistData["Users"]))
        if let inUsers = inUsers {
            _ = inUsers.write(to: tempURLFor("temp.plist"), format: .plist)
        }
        let users =  UserTypes(file: tempURLFor("temp.plist"), format: .plist)
        XCTAssert(users != nil)
        XCTAssert(users?.tArr.count == 3)
        XCTAssert(users?.tImp.name == "John Doe")
        XCTAssert(users?.tDicOpt?.count == 3)
        XCTAssert(users?.tDicOpt?["item1"]?.email == "john@unit-testing.com")
        XCTAssert(users?.tArrImp.count == 3)
    }
}
