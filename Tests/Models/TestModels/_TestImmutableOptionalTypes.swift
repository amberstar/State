/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestImmutableOptionalTypes : Model {
    public let myDate: NSDate?
    public let myFloat: Float?
    public let myBinary: NSData?
    public let myDouble: Double?
    public let myString: String?
    public let myBoolean: Bool?
    public let myDecimal: NSDecimalNumber?
    public let myInt: Int?

public init(myDate: NSDate?, myFloat: Float?, myBinary: NSData?, myDouble: Double?, myString: String?, myBoolean: Bool?, myDecimal: NSDecimalNumber?, myInt: Int?) {

    self.myDate = myDate
    self.myFloat = myFloat
    self.myBinary = myBinary
    self.myDouble = myDouble
    self.myString = myString
    self.myBoolean = myBoolean
    self.myDecimal = myDecimal
    self.myInt = myInt

    }
}

extension TestImmutableOptionalTypes : Decodable {

    static func create(myDate: NSDate?)(myFloat: Float?)(myBinary: NSData?)(myDouble: Double?)(myString: String?)(myBoolean: Bool?)(myDecimal: NSDecimalNumber?)(myInt: Int?) -> TestImmutableOptionalTypes  {
        return TestImmutableOptionalTypes(myDate: myDate, myFloat: myFloat, myBinary: myBinary, myDouble: myDouble, myString: myString, myBoolean: myBoolean, myDecimal: myDecimal, myInt: myInt)
    }

    public init?(var decoder: Decoder) {

    decoder = TestImmutableOptionalTypes.performMigrationIfNeeded(decoder)

        let instance: TestImmutableOptionalTypes? = TestImmutableOptionalTypes.create
        <^> decoder.decode("myDate") >>> asOptional
        <*> decoder.decode("myFloat") >>> asOptional
        <*> decoder.decode("myBinary") >>> asOptional
        <*> decoder.decode("myDouble") >>> asOptional
        <*> decoder.decode("myString") >>> asOptional
        <*> decoder.decode("myBoolean") >>> asOptional
        <*> decoder.decode("myDecimal") >>> asOptional
        <*> decoder.decode("myInt") >>> asOptional

        if let i = instance {
            i.didFinishDecodingWithDecoder(decoder)
            self = i
        } else { return nil }
    }
}

extension TestImmutableOptionalTypes : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(myDate, "myDate")
        encoder.encode(myFloat, "myFloat")
        encoder.encode(myBinary, "myBinary")
        encoder.encode(myDouble, "myDouble")
        encoder.encode(myString, "myString")
        encoder.encode(myBoolean, "myBoolean")
        encoder.encode(myDecimal, "myDecimal")
        encoder.encode(myInt, "myInt")

        TestImmutableOptionalTypes.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestImmutableOptionalTypes {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<8954c691 e621c6bd bad84d7f 4fb9addd 53ed8e45 053f272c fafd2d9b 63de0acc>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

