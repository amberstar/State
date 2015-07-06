/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestOptionalTypes : Model {
    public var myDate: NSDate?
    public var myFloat: Float?
    public var myBinary: NSData?
    public var myDouble: Double?
    public var myString: String?
    public var myBoolean: Bool?
    public var myDecimal: NSDecimalNumber?
    public var myInt: Int?

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

extension TestOptionalTypes : Decodable {

    static func create(myDate: NSDate?)(myFloat: Float?)(myBinary: NSData?)(myDouble: Double?)(myString: String?)(myBoolean: Bool?)(myDecimal: NSDecimalNumber?)(myInt: Int?) -> TestOptionalTypes  {
        return TestOptionalTypes(myDate: myDate, myFloat: myFloat, myBinary: myBinary, myDouble: myDouble, myString: myString, myBoolean: myBoolean, myDecimal: myDecimal, myInt: myInt)
    }

    public init?(var decoder: Decoder) {

    decoder = TestOptionalTypes.performMigrationIfNeeded(decoder)

        let instance: TestOptionalTypes? = TestOptionalTypes.create
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

extension TestOptionalTypes : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(myDate, "myDate")
        encoder.encode(myFloat, "myFloat")
        encoder.encode(myBinary, "myBinary")
        encoder.encode(myDouble, "myDouble")
        encoder.encode(myString, "myString")
        encoder.encode(myBoolean, "myBoolean")
        encoder.encode(myDecimal, "myDecimal")
        encoder.encode(myInt, "myInt")

        TestOptionalTypes.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestOptionalTypes {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<9f253c6d 6eee6daf 0cb47189 ec638d50 fa91dd34 ba49773b 92c39ed1 0d3546a3>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

