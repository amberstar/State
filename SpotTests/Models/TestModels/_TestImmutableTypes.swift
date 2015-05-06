/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import Spot

public struct TestImmutableTypes {
    public let myBinary: NSData
    public let myBoolean: Bool
    public let myDate: NSDate
    public let myDecimal: NSDecimalNumber
    public let myDouble: Double
    public let myFloat: Float
    public let myInt: Int
    public let myString: String

    public init(myBinary: NSData, myBoolean: Bool, myDate: NSDate, myDecimal: NSDecimalNumber, myDouble: Double, myFloat: Float, myInt: Int, myString: String) {

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

extension TestImmutableTypes : Decodable {

    static func create(myBinary: NSData)(myBoolean: Bool)(myDate: NSDate)(myDecimal: NSDecimalNumber)(myDouble: Double)(myFloat: Float)(myInt: Int)(myString: String) -> TestImmutableTypes  {
        return TestImmutableTypes(myBinary: myBinary, myBoolean: myBoolean, myDate: myDate, myDecimal: myDecimal, myDouble: myDouble, myFloat: myFloat, myInt: myInt, myString: myString)
    }

    public init?(var decoder: Decoder) {

        if TestImmutableTypes.shouldMigrateIfNeeded {
            if let dataVersion: AnyObject = decoder.decode(TestImmutableTypes.versionKey) {
                if TestImmutableTypes.needsMigration(dataVersion) {
                   let migratedData = TestImmutableTypes.migrateDataForDecoding(decoder.extractData(), dataVersion: dataVersion)
                    decoder = Decoder(data: migratedData)
                }
            }
        }

        let instance: TestImmutableTypes? = TestImmutableTypes.create
        <^> decoder.decode("myBinary")
        <*> decoder.decode("myBoolean")
        <*> decoder.decode("myDate")
        <*> decoder.decode("myDecimal")
        <*> decoder.decode("myDouble")
        <*> decoder.decode("myFloat")
        <*> decoder.decode("myInt")
        <*> decoder.decode("myString")

        if let i = instance {
            i.didFinishDecodingWithDecoder(decoder)
            self = i
        } else { return nil }
    }
}

extension TestImmutableTypes : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(self.myBinary, forKey: "myBinary")
        encoder.encode(self.myBoolean, forKey: "myBoolean")
        encoder.encode(self.myDate, forKey: "myDate")
        encoder.encode(self.myDecimal, forKey: "myDecimal")
        encoder.encode(self.myDouble, forKey: "myDouble")
        encoder.encode(self.myFloat, forKey: "myFloat")
        encoder.encode(self.myInt, forKey: "myInt")
        encoder.encode(self.myString, forKey: "myString")

        if TestImmutableTypes.shouldEncodeVersion {
                encoder.encode(TestImmutableTypes.version, forKey:TestImmutableTypes.versionKey)
        }
        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestImmutableTypes {
    /**
    These are provided from the data model designer
    and can be used to determine if the model is
    a different version.
    */
    static var modelVersionHash: String {
        return "<053f29fe 14df09a6 b7d222ee 5b611256 e3e3f8d5 0ab9d644 c9a1466a f9293bea>"
    }

    static var modelVersionHashModifier: String? {
        return nil
    }
}

