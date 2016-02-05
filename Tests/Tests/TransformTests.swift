import XCTest
import State
#if os(iOS)
import UIKit
#endif

class TransformTests: Test {
    
    func testURLTransform() {
        let string = "http://myUrl.com"
        let testURL = NSURL(string:string)
        let stringURL = URLTransform.apply(testURL)
        let sut = URLTransform.reverse(stringURL)
        
        XCTAssert(sut == testURL)
        XCTAssert (string == stringURL)
    }
    #if os (iOS)
    func testUIColorTransform() {
        let color = UIColor.blueColor()
        let colorTransformed  = UIColorTransform.apply(color)
        let testColor = UIColorTransform.reverse(colorTransformed)
        
        XCTAssert(color == testColor)
    }
    #endif
}
