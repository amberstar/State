import XCTest
import Spot


class DefaultTests: Test {

    func testDefaults() {
        var test = TestDefaults()
        
        XCTAssert(test.defaultArray.count == 3 )
        XCTAssert(test.defaultString == "defaultString")
        XCTAssertNotNil(test.defaultEmptyArray)
        XCTAssert(test.defaultChild.name == "New Child")
        XCTAssert(test.defaultChildren.count == 0)
    }
    
}
