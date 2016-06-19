/************************************************

        HUMAN GENERATED FILE

************************************************/
import State
import Foundation

extension TestImmutableOptionalTypes {

    init() {
        self.myBinary = TestImmutableOptionalTypes.createBinary()!
        self.myBoolean = true
        self.myDate = Date()
        self.myDecimal = NSDecimalNumber(value: 3.14)
        self.myFloat = 4.567
        self.myDouble = -0.02
        self.myInt = 5
        self.myString = "Hello World"
    }
    
    private static func createBinary() -> Data? {
        if let path = Bundle(for: Test.self).pathForResource("Data", ofType: "plist") {
            return  (try? Data(contentsOf: URL(fileURLWithPath: path)))
        }
        return nil
    }
}

