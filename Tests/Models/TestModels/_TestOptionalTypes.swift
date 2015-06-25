/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestOptionalTypes {
    public var myBinary: NSData?
    public var myBoolean: Bool?
    public var myDate: NSDate?
    public var myDecimal: NSDecimalNumber?
    public var myDouble: Double?
    public var myFloat: Float?
    public var myInt: Int?
    public var myString: String?

public init(myBinary: NSData?, myBoolean: Bool?, myDate: NSDate?, myDecimal: NSDecimalNumber?, myDouble: Double?, myFloat: Float?, myInt: Int?, myString: String?) {

    self.myBinary = myBinary
    self.myBoolean = myBoolean
    self.myDate = myDate
    self.myDecimal = myDecimal
    self.myDouble = myDouble
    self.myFloat = myFloat
    self.myInt = myInt
    self.myString = myString

    }
}

extension TestOptionalTypes : Decodable {

    static func create(myBinary: NSData?)(myBoolean: Bool?)(myDate: NSDate?)(myDecimal: NSDecimalNumber?)(myDouble: Double?)(myFloat: Float?)(myInt: Int?)(myString: String?) -> TestOptionalTypes  {
        return TestOptionalTypes(myBinary: myBinary, myBoolean: myBoolean, myDate: myDate, myDecimal: myDecimal, myDouble: myDouble, myFloat: myFloat, myInt: myInt, myString: myString)
    }

    public init?(var decoder: Decoder) {

        if TestOptionalTypes.shouldMigrateIfNeeded {
            if let dataVersion: AnyObject = decoder.decode(TestOptionalTypes.versionKey) {
                if TestOptionalTypes.needsMigration(dataVersion) {
                   let migratedData = TestOptionalTypes.migrateDataForDecoding(decoder.extractData(), dataVersion: dataVersion)
                    decoder = Decoder(data: migratedData)
                }
            }
        }

        let instance: TestOptionalTypes? = TestOptionalTypes.create
        <^> decoder.decode("myBinary") >>> asOptional
        <*> decoder.decode("myBoolean") >>> asOptional
        <*> decoder.decode("myDate") >>> asOptional
        <*> decoder.decode("myDecimal") >>> asOptional
        <*> decoder.decode("myDouble") >>> asOptional
        <*> decoder.decode("myFloat") >>> asOptional
        <*> decoder.decode("myInt") >>> asOptional
        <*> decoder.decode("myString") >>> asOptional

        if let i = instance {
            i.didFinishDecodingWithDecoder(decoder)
            self = i
        } else { return nil }
    }
}

extension TestOptionalTypes : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(myBinary, "myBinary")
        encoder.encode(myBoolean, "myBoolean")
        encoder.encode(myDate, "myDate")
        encoder.encode(myDecimal, "myDecimal")
        encoder.encode(myDouble, "myDouble")
        encoder.encode(myFloat, "myFloat")
        encoder.encode(myInt, "myInt")
        encoder.encode(myString, "myString")

        if TestOptionalTypes.shouldEncodeVersion {
encoder.encode(TestOptionalTypes.version(TestOptionalTypes.modelVersionHash, modelVersionHashModifier: TestOptionalTypes.modelVersionHashModifier), TestOptionalTypes.versionKey)
        }
        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestOptionalTypes {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    static var modelVersionHash: String {
        return "<9f253c6d 6eee6daf 0cb47189 ec638d50 fa91dd34 ba49773b 92c39ed1 0d3546a3>"
    }

    static var modelVersionHashModifier: String? {
        return nil
    }
}

