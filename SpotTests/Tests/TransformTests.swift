import XCTest
import Spot


class TransformTests: Test {
    
    func testURLTransform() {
        var string = "http://myUrl.com"
        var testURL = NSURL(string:string)
        var stringURL = URLTransform.transform(testURL)
        var sut = URLTransform.reverseTransform(stringURL)
        
        XCTAssert(sut == testURL)
        XCTAssert (string == stringURL)
    }
    
    func testUIColorTransform() {
        var color = UIColor.blueColor()
        var colorTransformed  = UIColorTransform.transform(color)
        var testColor = UIColorTransform.reverseTransform(colorTransformed)
        
        XCTAssert(color == testColor)
    }
}