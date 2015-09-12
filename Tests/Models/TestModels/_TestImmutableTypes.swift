/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestImmutableTypes : Model {
    public let myDate: NSDate
    public let myFloat: Float
    public let myBinary: NSData
    public let myDouble: Double
    public let myString: String
    public let myBoolean: Bool
    public let myDecimal: NSDecimalNumber
    public let myInt: Int

public init(myDate: NSDate, myFloat: Float, myBinary: NSData, myDouble: Double, myString: String, myBoolean: Bool, myDecimal: NSDecimalNumber, myInt: Int) {

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

extension TestImmutableTypes : Decodable {

    static func create(myDate: NSDate)(myFloat: Float)(myBinary: NSData)(myDouble: Double)(myString: String)(myBoolean: Bool)(myDecimal: NSDecimalNumber)(myInt: Int) -> TestImmutableTypes  {
        return TestImmutableTypes(myDate: myDate, myFloat: myFloat, myBinary: myBinary, myDouble: myDouble, myString: myString, myBoolean: myBoolean, myDecimal: myDecimal, myInt: myInt)
    }

    public init?(var decoder: Decoder) {

    decoder = TestImmutableTypes.performMigrationIfNeeded(decoder)

        let instance: TestImmutableTypes? = TestImmutableTypes.create
        <^> decoder.decode("myDate")
        <*> decoder.decode("myFloat")
        <*> decoder.decode("myBinary")
        <*> decoder.decode("myDouble")
        <*> decoder.decode("myString")
        <*> decoder.decode("myBoolean")
        <*> decoder.decode("myDecimal")
        <*> decoder.decode("myInt")

        if let i = instance {
            i.didFinishDecodingWithDecoder(decoder)
            self = i
        } else { return nil }
    }
}

extension TestImmutableTypes : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(myDate, "myDate")
        encoder.encode(myFloat, "myFloat")
        encoder.encode(myBinary, "myBinary")
        encoder.encode(myDouble, "myDouble")
        encoder.encode(myString, "myString")
        encoder.encode(myBoolean, "myBoolean")
        encoder.encode(myDecimal, "myDecimal")
        encoder.encode(myInt, "myInt")

        TestImmutableTypes.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestImmutableTypes {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<053f29fe 14df09a6 b7d222ee 5b611256 e3e3f8d5 0ab9d644 c9a1466a f9293bea>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

