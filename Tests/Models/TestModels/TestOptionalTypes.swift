/************************************************

        HUMAN GENERATED FILE

************************************************/
import State
import Foundation

extension TestOptionalTypes {
    
    static func CreateTestInstance () -> TestOptionalTypes {
        var instance = TestOptionalTypes()
        instance.myBinary = TestOptionalTypes.createBinary()
        instance.myBoolean = true
        instance.myDate = NSDate()
        instance.myDecimal = NSDecimalNumber(double: 3.14)
        instance.myFloat = 4.567
        instance.myDouble = -0.02
        instance.myInt = 5
        instance.myString = "Hello World"
        return instance
    }

    private static func createBinary() -> NSData? {
        if let path = NSBundle(forClass: Test.self).pathForResource("Data", ofType: "plist") {
            return  NSData(contentsOfFile:path)
        }
        return nil
    }
}
