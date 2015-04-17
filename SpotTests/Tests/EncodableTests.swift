import XCTest
import Spot

class EncodableTests: Test {
    
    func testEcodingToAndFromJSON() {
        let inUsers: UserTypes? = Decoder.decode(jsonData)
        if let inUsers = inUsers {
            JSON.write(Encoder.encode(inUsers), path: tempPathFor("temp.json"))
        }
        let users: UserTypes? = Decoder.decode(JSON.read(tempPathFor("temp.json")))
        XCTAssert(users != nil)
        XCTAssert(users?.tArr.count == 3)
        XCTAssert(users?.tImp.name == "John Doe")
        XCTAssert(users?.tDicOpt?.count == 3)
        XCTAssert(users?.tDicOpt?["item1"]?.email == "john@unit-testing.com")
        XCTAssert(users?.tArrImp.count == 3)
    }

    func testEcodingToAndFromPlist() {
        let inUsers : UserTypes? = Decoder.decode(plistData["Users"])
        if let inUsers = inUsers {
            Plist.write(Encoder.encode(inUsers), path: tempPathFor("temp.plist"))
        }
        let users: UserTypes? = Decoder.decode(Plist.read(tempPathFor("temp.plist")))
        XCTAssert(users != nil)
        XCTAssert(users?.tArr.count == 3)
        XCTAssert(users?.tImp.name == "John Doe")
        XCTAssert(users?.tDicOpt?.count == 3)
        XCTAssert(users?.tDicOpt?["item1"]?.email == "john@unit-testing.com")
        XCTAssert(users?.tArrImp.count == 3)
    }
}