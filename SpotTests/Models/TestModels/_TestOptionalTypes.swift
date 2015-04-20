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
        <^> Optional(decoder.decode("myBinary"))
        <*> Optional(decoder.decode("myBoolean"))
        <*> Optional(decoder.decode("myDate"))
        <*> Optional(decoder.decode("myDecimal"))
        <*> Optional(decoder.decode("myDouble"))
        <*> Optional(decoder.decode("myFloat"))
        <*> Optional(decoder.decode("myInt"))
        <*> Optional(decoder.decode("myString"))

        if let i = instance { self = i } else { return nil }
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

    }
}

