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

}

extension TestImmutableOptionalTypes : Decodable {

   public static func decode(decoder: Decoder) -> TestImmutableOptionalTypes? {
      return self.init(decoder: decoder)
   }

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = TestImmutableOptionalTypes.performMigrationIfNeeded(decoder)

        let myDate: NSDate? = decoder.decode("myDate")
        let myFloat: Float? = decoder.decode("myFloat")
        let myBinary: NSData? = decoder.decode("myBinary")
        let myDouble: Double? = decoder.decode("myDouble")
        let myString: String? = decoder.decode("myString")
        let myBoolean: Bool? = decoder.decode("myBoolean")
        let myDecimal: NSDecimalNumber? = decoder.decode("myDecimal")
        let myInt: Int? = decoder.decode("myInt")

        self.myDate = myDate
        self.myFloat = myFloat
        self.myBinary = myBinary
        self.myDouble = myDouble
        self.myString = myString
        self.myBoolean = myBoolean
        self.myDecimal = myDecimal
        self.myInt = myInt
        didFinishDecodingWithDecoder(decoder)
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

