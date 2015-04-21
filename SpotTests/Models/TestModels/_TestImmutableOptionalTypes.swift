/************************************************

            MACHINE GENERATED FILE

 ************************************************/

import Spot

public struct TestImmutableOptionalTypes {
    let myBinary: NSData?
    let myBoolean: Bool?
    let myDate: NSDate?
    let myDecimal: NSDecimalNumber?
    let myDouble: Double?
    let myFloat: Float?
    let myInt: Int?
    let myString: String?

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

extension TestImmutableOptionalTypes : Decodable {

    static func create(myBinary: NSData?)(myBoolean: Bool?)(myDate: NSDate?)(myDecimal: NSDecimalNumber?)(myDouble: Double?)(myFloat: Float?)(myInt: Int?)(myString: String?) -> TestImmutableOptionalTypes  {

        return TestImmutableOptionalTypes(myBinary: myBinary, myBoolean: myBoolean, myDate: myDate, myDecimal: myDecimal, myDouble: myDouble, myFloat: myFloat, myInt: myInt, myString: myString)
    }
    public init?(decoder: Decoder) {
        let instance: TestImmutableOptionalTypes? = TestImmutableOptionalTypes.create
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

extension TestImmutableOptionalTypes : Encodable {

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

