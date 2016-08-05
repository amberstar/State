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
        instance.myDate = Date()
        instance.myDecimal = NSDecimalNumber(value: 3.14)
        instance.myFloat = 4.567
        instance.myDouble = -0.02
        instance.myInt = 5
        instance.myString = "Hello World"
        return instance
    }

    private static func createBinary() -> Data? {
        if let path = Bundle(for: Test.self).path(forResource: "Data", ofType: "plist") {
            return  (try? Data(contentsOf: URL(fileURLWithPath: path)))
        }
        return nil
    }
}
