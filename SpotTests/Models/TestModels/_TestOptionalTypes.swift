/************************************************

            MACHINE GENERATED FILE

 ************************************************/

import Spot

public struct TestOptionalTypes {
    var myBinary: NSData?
    var myBoolean: Bool?
    var myDate: NSDate?
    var myDecimal: NSDecimalNumber?
    var myDouble: Double?
    var myFloat: Float?
    var myInt: Int?
    var myString: String?

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
    public init?(decoder: Decoder) {
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

extension TestOptionalTypes {

    static var versionHash: NSData? {
        let hash: NSString = "<9f253c6d 6eee6daf 0cb47189 ec638d50 fa91dd34 ba49773b 92c39ed1 0d3546a3>"
        return hash.dataUsingEncoding(NSUTF8StringEncoding)
    }

    static var versionHashModifier: String? {
        return nil
    }
}

