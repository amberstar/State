import Foundation
import XCTest
@testable import State

class StoreTests: Test {
    
    var testPlist : [String : AnyObject]?
    var testJSON  : [String : AnyObject]?
    var testData  : [String : AnyObject]?
    
    override func setUp() {
        super.setUp()
        
        let plist = PlistFormat()
        let json = JSONFormat()
        self.testPlist = plist.read(bundleURLFor("Data", ofType: "plist")!) as? [String : AnyObject]
        self.testData = plist.read(bundleURLFor("Data", ofType: "plist")!) as? [String : AnyObject]
        self.testJSON = json.read(bundleURLFor("Data", ofType: "json")!) as? [String : AnyObject]
    }
    
    func testRemoveKey() {
        var tested = Store(data: testPlist!)
        let removed = tested.remove(key: "Float") as! [String : AnyObject]
        XCTAssert(removed.count == 7)
        XCTAssert(!tested.data.keys.contains("Float"))
    }
    
    func testMakeDataWillInitWithData() {
        let source = Store(data: testPlist!)
        let tested = source.store(forKey: "Float")
        let data = tested?.makeData(format: .binary)
        XCTAssertNotNil(data)
        let testedIn = Store(content: data!, format: .binary)
        XCTAssert(testedIn?.data.keys.count == 7)
    }
    
    func testMakeStringWillInitWithString() {
        let tested = Store(data: testJSON!)
        let str = tested.makeString(format: .json)
        XCTAssertNotNil(str)
        let testedIn = Store(content: str!, format: .json)
        XCTAssert(testedIn?.data.keys.count == 9)
    }
    
    func testWriteToFileInitWithFile() {
        let testFileURL = tempURLFor("temp_store_write_to_file.plist")
        let tested = Store(data: testPlist!)
        let result = tested.write(to: testFileURL , format: .plist)
        XCTAssertTrue(result)
        let testedIn = Store(file: testFileURL, format: .plist)
        XCTAssert(tested.data.count == testedIn?.data.count)
    }
    
    func testURLStorage() {
        var tested = Store()
        let testURL = tempURLFor("Some_Test_URL.json")
        tested.set(testURL, forKey: "tested")
        _ = tested.write(to: testURL, format: .json)
        let testedIn = Store(file: tested.value(forKey: "tested")!, format: .json)
        let testURLIn : URL? = testedIn?.value(forKey: "tested")
        XCTAssert(testURLIn! == testURL)
    }
}
