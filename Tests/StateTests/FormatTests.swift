import Foundation
import XCTest
@testable import State

class FormatTests: Test {
    var testPlist : [String : Any]?
    var testJSON  : [String : Any]?
    var testData  : [String : Any]?
    
    override func setUp() {
        super.setUp()
        
        let plist = PlistFormat()
        let json = JSONFormat()
        self.testPlist = plist.read(bundleURLFor("Data", ofType: "plist")!) as? [String : Any]
        self.testData = plist.read(bundleURLFor("Data", ofType: "plist")!) as? [String : Any]
        self.testJSON = json.read(bundleURLFor("Data", ofType: "json")!) as? [String : Any]
    }

    func testPlistWasReadCorrectly() {
        XCTAssert(testPlist?.count == 9, "Plist Count should be 9 , is \(testPlist?.count)")
        if let floatData = testPlist?["Float"] as? [String : AnyObject],
            let v = floatData["t"] as? Float {
            XCTAssert(v == -0.345)
        } else {
            XCTFail("Plist was not read correctly")
        }
    }
    
    func testDataWasReadCorrectly() {
        XCTAssert(testData?.count == 9)
        if let floatData = testData?["Float"] as? [String : AnyObject],
            let v = floatData["t"] as? Float {
            XCTAssert(v == -0.345)
        } else {
            XCTFail("Data was not read correctly")
        }
    }
    
    func testJSONWasReadCorrectly() {
        XCTAssert(testJSON?.count == 9)
        if let tArr = testJSON?["t_arr"] as? [AnyObject],
            let u = tArr[1] as? [String : AnyObject],
            let name = u["name"] as? String {
            XCTAssert(u.count == 3)
            XCTAssert(name == "John Doe")
        } else {
            XCTFail("JSON was not read correctly")
        }
    }
    
    func testReadingPlistFileShouldProduceData() {
        testPlistWasReadCorrectly()
        XCTAssert(testPlist != nil)
    }
    
    func testReadingJSONFileShouldProduceData() {
        testJSONWasReadCorrectly()
        XCTAssert(testJSON != nil)
    }


    func testReadingDataFileShouldProduceData() {
        testDataWasReadCorrectly()
        XCTAssert(testData != nil)
    }

    func testWritingPlistFile() {
        testPlistWasReadCorrectly()
        writePlistDataOutToTempFile()
        testPlist = nil
        readPlistDataFromTempFile()
        testPlistWasReadCorrectly()
    }
    
    func testWritingJSONFileShouldMatch() {
        testJSONWasReadCorrectly()
        writeJSONDataOutToTempFile()
        testJSON = nil
        readJSONDataFromTempFile()
        testJSONWasReadCorrectly()
    }
    
    func testWritingDataFile() {
        testDataWasReadCorrectly()
        writeDataOutToTempFile()
        testData = nil
        readDataFromTempFile()
        testDataWasReadCorrectly()
    }
    
    func testParsingJSONFromString() {
        testJSONWasReadCorrectly()
        let json = JSONFormat()
        let testString : String? = bundleURLFor("Data", ofType: "json") >>- json.read >>- json.makeString
        testJSON = nil
        testJSON = json.read(testString!) as? [String : Any]
        testJSONWasReadCorrectly()
    }
    
    func testParsingPlistFromString() {
        testPlistWasReadCorrectly()
        let plist = PlistFormat()
        let testString : String? = bundleURLFor("Data", ofType: "plist") >>- plist.read >>- plist.makeString
        testPlist = nil
        testPlist = plist.read(testString!) as? [String : Any]
        testPlistWasReadCorrectly()
    }
    
    func testWritingPlistString() {
        testPlistWasReadCorrectly()
        let plist = PlistFormat()
        let baseString : String? = bundleURLFor("Data", ofType: "plist") >>- plist.read >>- plist.makeString
        let testString: String? = plist.makeString(from: testPlist! )
        XCTAssert(testString == baseString)
    }
    
    func testWritingJSONString() {
        testJSONWasReadCorrectly()
        let json = JSONFormat()
        let baseString : String? = bundleURLFor("Data", ofType: "json") >>- json.read  >>- { json.makeString(from: $0 as![String : Any]) }
        let testString: String? = json.makeString(from: testJSON!)
        XCTAssert(testString! == baseString!, "testString:\(testString), baseString:\(baseString)")
    }
    
    func testReadingAndWritingPlistData() {
        testPlistWasReadCorrectly()
        let plist = PlistFormat()
        let testData: Data? = plist.makeData(from: testPlist!, prettyPrint: true)
        testPlist = nil
        _ = testData >>- plist.read >>- { self.testPlist = $0 as? [String : AnyObject] }
        testPlistWasReadCorrectly()
    }
    
    func testReadingAndWritingJSONData() {
        testJSONWasReadCorrectly()
        let json = JSONFormat()
        let testData: Data? = json.makeData(from: testJSON!, prettyPrint:  true)
        testJSON = nil
        _ = testData >>- json.read >>- { self.testJSON = $0 as? [String : AnyObject] }
        testJSONWasReadCorrectly()
    }
    
    func testReadingAndWritingData() {
        testDataWasReadCorrectly()
        let binary = State.Format()
        let testNSData: Data? = binary.makeData(from: testData!, prettyPrint: true)
        testData = nil
        _ = testNSData >>- binary.read >>- { self.testData = $0 as? [String : AnyObject] }
        testDataWasReadCorrectly()
    }
    
    func testReadingJSONAndWritingPlist() {
        let users_out = UserTypes.read(from: Store(data: jsonData))
        _ = users_out!.write(to: tempURLFor("users.plist"), format: .plist)
        let users = UserTypes(file: tempURLFor("users.plist"), format:.plist)
        XCTAssert(users != nil)
        XCTAssert(users?.tArr.count == 3)
        XCTAssert(users?.tImp.name == "John Doe")
        XCTAssert(users?.tDicOpt?.count == 3)
        XCTAssert(users?.tDicOpt?["item1"]?.email == "john@unit-testing.com")
        XCTAssert(users?.tArrImp.count == 3)
    }
    
    ///MARK: - PRIVATE
    private func writePlistDataOutToTempFile() {
        let path = tempURLFor("test.plist")
        let plist = PlistFormat()
        _ = testPlist >>- { plist.write($0, to: path) }
    }
    
    private func readPlistDataFromTempFile() {
        let path = tempURLFor("test.plist")
        let plist = PlistFormat()
        _ = path >>- { self.testPlist  = plist.read($0) as? [String : AnyObject] }
    }
    
    private func writeJSONDataOutToTempFile() {
        let path = tempURLFor("temp.json")
        let json = JSONFormat()
        _ = testJSON >>- { json.write($0, to: path) }
    }
    
    private func readJSONDataFromTempFile() {
        let path = tempURLFor("temp.json")
        let json = JSONFormat()
        _ = path >>- { self.testJSON = json.read($0) as? [String : AnyObject] }
    }
    
    private func writeDataOutToTempFile() {
        let path = tempURLFor("temp.data")
        let binary = State.Format()
        _ = testData >>- { binary.write($0, to: path) }
    }
    
    private func readDataFromTempFile() {
        let binary = State.Format()
        let path = tempURLFor("temp.data")
        _ = path >>- { self.testData = binary.read($0) as? [String : AnyObject] }
    }
}
