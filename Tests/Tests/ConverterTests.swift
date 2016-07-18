import XCTest
@testable
import State
import Foundation

infix operator >>- { associativity left precedence 100 }
infix operator -<< { associativity right precedence 100 }

/**
 flatMap a function over an optional value (left associative)
 
 - If the value is .None, the function will not be evaluated and this will return .None
 - If the value is .Some, the function will be applied to the unwrapped value
 
 - parameter f: A transformation function from type T to type Optional<U>
 - parameter a: A value of type Optional<T>
 
 - returns: A value of type Optional<U>
 */
func >>-<T, U>(a: T?, f: @noescape (T) -> U?) -> U? {
   return a.flatMap(f)
}

class ConverterTests: Test {
    var testPlist : [String : AnyObject]?
    var testJSON  : [String : AnyObject]?
    var testData  : [String : AnyObject]?
    
    override func setUp() {
        super.setUp()
    
        let plist = PlistFormatter()
        let json = JSONFormatter()
        self.testPlist = plist.read(bundleURLFor("Data", ofType: "plist")!)
        self.testData = plist.read(bundleURLFor("Data", ofType: "plist")!)
        self.testJSON = json.read(bundleURLFor("Data", ofType: "json")!)
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
        let json = JSONFormatter()
        let testString : String? = bundleURLFor("Data", ofType: "json") >>- json.read >>- json.makeString
        testJSON = nil
        testJSON = json.read(testString!)
        testJSONWasReadCorrectly()
    }
    
    func testParsingPlistFromString() {
        testPlistWasReadCorrectly()
        let plist = PlistFormatter()
        let testString : String? = bundleURLFor("Data", ofType: "plist") >>- plist.read >>- plist.makeString
        testPlist = nil
        testPlist = plist.read(testString!)
        testPlistWasReadCorrectly()
    }
    
    func testWritingPlistString() {
        testPlistWasReadCorrectly()
        let plist = PlistFormatter()
        let baseString : String? = bundleURLFor("Data", ofType: "plist") >>- plist.read >>- plist.makeString
        var testString: String = ""
        _ = testPlist >>- plist.makeString >>- { testString = $0 }
        XCTAssert(testString == baseString!)
    }
    
    func testWritingJSONString() {
        testJSONWasReadCorrectly()
        let json = JSONFormatter()
        let baseString : String? = bundleURLFor("Data", ofType: "json") >>- json.read >>- json.makeString
        var testString: String = ""
        _ = testJSON >>- json.makeString >>- { testString = $0 }
        XCTAssert(testString == baseString)
    }
    
    func testReadingAndWritingPlistData() {
        testPlistWasReadCorrectly()
        let plist = PlistFormatter()
        let testData: Data? = plist.makeData(from: testPlist!, prettyPrint: true)
        testPlist = nil
        _ = testData >>- plist.read >>- { self.testPlist = $0 }
        testPlistWasReadCorrectly()
    }
    
    func testReadingAndWritingJSONData() {
        testJSONWasReadCorrectly()
        let json = JSONFormatter()
        let testData: Data? = json.makeData(from: testJSON!, prettyPrint:  true)
        testJSON = nil
        _ = testData >>- json.read >>- { self.testJSON = $0 }
        testJSONWasReadCorrectly()
    }
    
    func testReadingAndWritingData() {
        testDataWasReadCorrectly()
        let binary = State.Formatter()
        let testNSData: Data? = binary.makeData(from: testData!, prettyPrint: true)
        testData = nil
        _ = testNSData >>- binary.read >>- { self.testData = $0 }
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
        let plist = PlistFormatter()
        _ = testPlist >>- { plist.write($0, to: path) }
    }
    
    private func readPlistDataFromTempFile() {
        let path = tempURLFor("test.plist")
        let plist = PlistFormatter()
        _ = path >>- { self.testPlist  = plist.read($0) }
    }
    
    private func writeJSONDataOutToTempFile() {
        let path = tempURLFor("temp.json")
        let json = JSONFormatter()
        _ = testJSON >>- { json.write($0, to: path) }
    }
        
    private func readJSONDataFromTempFile() {
        let path = tempURLFor("temp.json")
        let json = JSONFormatter()
        _ = path >>- { self.testJSON = json.read($0) }
    }
        
    private func writeDataOutToTempFile() {
        let path = tempURLFor("temp.data")
        let binary = State.Formatter()
        _ = testData >>- { binary.write($0, to: path) }
    }
    
    private func readDataFromTempFile() {
        let binary = State.Formatter()
        let path = tempURLFor("temp.data")
        _ = path >>- { self.testData = binary.read($0) }
    }
}
