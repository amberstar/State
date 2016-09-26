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
        var tested = Store(propertyList: testPlist!)
        let removed = tested.remove(key: "Float") as! [String : AnyObject]
        XCTAssert(removed.count == 7)
        XCTAssert(!tested.propertyList.keys.contains("Float"))
    }
    
    func testMakeDataWillInitWithData() {
        let source = Store(propertyList: testPlist!)
        let tested = source.store(forKey: "Float")
        let data = tested?.makeData()
        XCTAssertNotNil(data)
        let testedIn = Store(data: data!)
        XCTAssert(testedIn?.propertyList.keys.count == 7)
    }
    
    func testWriteToFileInitWithFile() {
        let testFileURL = tempURLFor("temp_store_write_to_file.plist")
        let tested = Store(propertyList: testPlist!)
        let result = tested.write(to: testFileURL , format: .plist)
        XCTAssertTrue(result)
        let testedIn = Store(plistFile: testFileURL)
        XCTAssert(tested.propertyList.count == testedIn?.propertyList.count)
    }
    
    func testURLStorage() {
        var tested = Store()
        let testURL = tempURLFor("Some_Test_URL.json")
        tested.set(testURL, forKey: "tested")
        _ = tested.write(to: testURL, format: .json)
        let testedIn = Store(jsonFile: tested.value(forKey: "tested")!)
        let testURLIn : URL? = testedIn?.value(forKey: "tested")
        XCTAssert(testURLIn! == testURL)
    }
}
