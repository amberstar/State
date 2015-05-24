import XCTest
import State
import Foundation

class DataAdapterTests: Test {
    var testPlist : [String : AnyObject]?
    var testJSON  : [String : AnyObject]?
    var testData  : [String : AnyObject]?
    
    override func setUp() {
        super.setUp()
       
        bundlePathFor("Data", ofType: "plist") >>- { self.testPlist = Plist.read($0) }
        bundlePathFor("Data", ofType: "plist") >>- { self.testData = Plist.read($0) }
        bundlePathFor("Data", ofType: "json") >>- { self.testJSON = JSON.read($0) }
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
        let testString : String? = bundlePathFor("Data", ofType: "json") >>- JSON.read >>- JSON.write
        testJSON = nil
        testJSON = JSON.readString(testString!)
        testJSONWasReadCorrectly()
    }
    
    func testParsingPlistFromString() {
        testPlistWasReadCorrectly()
        let testString : String? = bundlePathFor("Data", ofType: "plist") >>- Plist.read >>- Plist.write
        testPlist = nil
        testPlist = Plist.readString(testString!)
        testPlistWasReadCorrectly()
    }
    
    func testWritingPlistString() {
        testPlistWasReadCorrectly()
        let baseString : String? = bundlePathFor("Data", ofType: "plist") >>- Plist.read >>- Plist.write
        var testString: String = ""
        testPlist >>- Plist.write >>- { testString = $0 }
        XCTAssert(testString == baseString!)
    }
    
    func testWritingJSONString() {
        testJSONWasReadCorrectly()
        let baseString : String? = bundlePathFor("Data", ofType: "json") >>- JSON.read >>- JSON.write
        var testString: String = ""
        testJSON >>- JSON.write >>- { testString = $0 }
        XCTAssert(testString == baseString)
    }
    
    func testReadingAndWritingPlistData() {
        testPlistWasReadCorrectly()
        var testData: NSData? = Plist.write(testPlist!)
        testPlist = nil
        testData >>- Plist.read >>- { self.testPlist = $0 }
        testPlistWasReadCorrectly()
    }
    
    func testReadingAndWritingJSONData() {
        testJSONWasReadCorrectly()
        var testData: NSData? = JSON.write(testJSON!)
        testJSON = nil
        testData >>- JSON.read >>- { self.testJSON = $0 }
        testJSONWasReadCorrectly()
    }
    
    func testReadingAndWritingData() {
        testDataWasReadCorrectly()
        var testNSData: NSData? = Data.write(testData!)
        testData = nil
        testNSData >>- Data.read >>- { self.testData = $0 }
        testDataWasReadCorrectly()
    }
    
    func testReadingJSONAndWritingPlist() {
        let users_out : UserTypes? = Decoder.decodeModel(jsonData)
        Plist.write(Encoder.encodeModel(users_out!), path: tempPathFor("users.plist"))
        let users : UserTypes? = Decoder.decodeModel(Plist.read(tempPathFor("users.plist")))
        XCTAssert(users != nil)
        XCTAssert(users?.tArr.count == 3)
        XCTAssert(users?.tImp.name == "John Doe")
        XCTAssert(users?.tDicOpt?.count == 3)
        XCTAssert(users?.tDicOpt?["item1"]?.email == "john@unit-testing.com")
        XCTAssert(users?.tArrImp.count == 3)
    }

///MARK: - PRIVATE
    private func writePlistDataOutToTempFile() {
        let path = tempPathFor("test.plist")
        testPlist >>- { Plist.write($0, path: path) }
    }
    
    private func readPlistDataFromTempFile() {
        let path = tempPathFor("test.plist")
        path >>- { self.testPlist  = Plist.read($0) }
    }
    
    private func writeJSONDataOutToTempFile() {
        let path = tempPathFor("temp.json")
        testJSON >>- { JSON.write($0, path: path) }
    }
        
    private func readJSONDataFromTempFile() {
        let path = tempPathFor("temp.json")
        path >>- { self.testJSON = JSON.read($0) }
    }
        
    private func writeDataOutToTempFile() {
        let path = tempPathFor("temp.data")
        testData >>- { Data.write($0, path: path) }
    }
    
    private func readDataFromTempFile() {
        let path = tempPathFor("temp.data")
        path >>- { self.testData = Data.read($0) }
    }
}