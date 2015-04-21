/************************************************

            MACHINE GENERATED FILE

 ************************************************/

import Spot

public struct TestImmutableTypes {
    let myBinary: NSData
    let myBoolean: Bool
    let myDate: NSDate
    let myDecimal: NSDecimalNumber
    let myDouble: Double
    let myFloat: Float
    let myInt: Int
    let myString: String

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
    public init?(decoder: Decoder) {
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

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestImmutableTypes {

    static var versionHash: NSData? {
        let hash: NSString = "<053f29fe 14df09a6 b7d222ee 5b611256 e3e3f8d5 0ab9d644 c9a1466a f9293bea>"
        return hash.dataUsingEncoding(NSUTF8StringEncoding)
    }

    static var versionHashModifier: String? {
        return nil
    }
}

