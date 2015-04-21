import XCTest
import Spot

class EncodableTests: Test {
    
    func testEcodingToAndFromJSON() {
        let inUsers: UserTypes? = Decoder.decodeModel(jsonData)
        if let inUsers = inUsers {
            JSON.write(Encoder.encodeModel(inUsers), path: tempPathFor("temp.json"))
        }
        let users: UserTypes? = Decoder.decodeModel(JSON.read(tempPathFor("temp.json")))
        XCTAssert(users != nil)
        XCTAssert(users?.tArr.count == 3)
        XCTAssert(users?.tImp.name == "John Doe")
        XCTAssert(users?.tDicOpt?.count == 3)
        XCTAssert(users?.tDicOpt?["item1"]?.email == "john@unit-testing.com")
        XCTAssert(users?.tArrImp.count == 3)
    }

    func testEcodingToAndFromPlist() {
        let inUsers : UserTypes? = Decoder.decodeModel(plistData["Users"])
        if let inUsers = inUsers {
            Plist.write(Encoder.encodeModel(inUsers), path: tempPathFor("temp.plist"))
        }
        let users: UserTypes? = Decoder.decodeModel(Plist.read(tempPathFor("temp.plist")))
        XCTAssert(users != nil)
        XCTAssert(users?.tArr.count == 3)
        XCTAssert(users?.tImp.name == "John Doe")
        XCTAssert(users?.tDicOpt?.count == 3)
        XCTAssert(users?.tDicOpt?["item1"]?.email == "john@unit-testing.com")
        XCTAssert(users?.tArrImp.count == 3)
    }
}