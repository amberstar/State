import XCTest
import State
#if os(iOS)
import UIKit
#endif


class TransformTests: Test {
    
    func testURLTransform() {
        let string = "http://myUrl.com"
        let testURL = NSURL(string:string)
        let stringURL = URLTransform.transform(testURL)
        let sut = URLTransform.reverseTransform(stringURL)
        
        XCTAssert(sut == testURL)
        XCTAssert (string == stringURL)
    }
    #if os (iOS)
    func testUIColorTransform() {
        let color = UIColor.blueColor()
        let colorTransformed  = UIColorTransform.transform(color)
        let testColor = UIColorTransform.reverseTransform(colorTransformed)
        
        XCTAssert(color == testColor)
    }
    #endif
}