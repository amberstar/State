/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestTypes : Model {
    public var myDate: NSDate
    public var myFloat: Float
    public var myBinary: NSData
    public var myDouble: Double
    public var myString: String
    public var myBoolean: Bool
    public var myDecimal: NSDecimalNumber
    public var myInt: Int

}

extension TestTypes : Decodable {

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = TestTypes.performMigrationIfNeeded(decoder)

guard
   let myDate: NSDate = decoder.decode("myDate"),
   let myFloat: Float = decoder.decode("myFloat"),
   let myBinary: NSData = decoder.decode("myBinary"),
   let myDouble: Double = decoder.decode("myDouble"),
   let myString: String = decoder.decode("myString"),
   let myBoolean: Bool = decoder.decode("myBoolean"),
   let myDecimal: NSDecimalNumber = decoder.decode("myDecimal"),
   let myInt: Int = decoder.decode("myInt")
   else { return  nil }

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

extension TestTypes : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(myDate, "myDate")
        encoder.encode(myFloat, "myFloat")
        encoder.encode(myBinary, "myBinary")
        encoder.encode(myDouble, "myDouble")
        encoder.encode(myString, "myString")
        encoder.encode(myBoolean, "myBoolean")
        encoder.encode(myDecimal, "myDecimal")
        encoder.encode(myInt, "myInt")

        TestTypes.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestTypes {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<a9fa31de ad1cc5f1 d85c3e3e ff64b9b2 3a3c9221 f8f44ba9 75e33daa b277f852>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

