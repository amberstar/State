/************************************************

        HUMAN GENERATED FILE

************************************************/

import Foundation

extension TestOptionalTypes {

    init() {
        self.myBinary = TestOptionalTypes.createBinary()
        self.myBoolean = true
        self.myDate = NSDate()
        self.myDecimal = NSDecimalNumber(double: 3.14)
        self.myFloat = 4.567
        self.myDouble = -0.02
        self.myInt = 5
        self.myString = "Hello World"
    }
    
    private static func createBinary() -> NSData? {
        if let path = NSBundle(forClass: Test.self).pathForResource("Data", ofType: "plist") {
            return  NSData(contentsOfFile:path)
        }
        return nil
    }

}
