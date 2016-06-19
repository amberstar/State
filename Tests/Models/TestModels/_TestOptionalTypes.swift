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

}

extension TestOptionalTypes : Decodable {

   public static func decode(_ decoder: Decoder) -> TestOptionalTypes? {
      return self.init(decoder: decoder)
   }

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = TestOptionalTypes.performMigrationIfNeeded(decoder)

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

extension TestOptionalTypes : Encodable {

    public func encode(_ encoder: Encoder) {
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

//****************************************************************************//
// MARK: UserDefaults support
//****************************************************************************//
extension UserDefaults {

   public func getTestOptionalTypes(forKey key: String) -> TestOptionalTypes? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return TestOptionalTypes.decode(dictionary)
   }

   public func getTestOptionalTypes(forKey key: String) -> [TestOptionalTypes]? {
      guard let array = array(forKey: key) else { return nil }
      return sequence(array.map(TestOptionalTypes.decode))
   }

   public func getTestOptionalTypes(forKey key: String) -> [String : TestOptionalTypes]? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return sequence(dictionary.map { TestOptionalTypes.decode($0) })
   }

   public func getTestOptionalTypes(forKey key: String, defaultValue: TestOptionalTypes) -> TestOptionalTypes {
      return getTestOptionalTypes(forKey: key) ?? defaultValue
   }

   public func getTestOptionalTypes(forKey key: String, defaultValue: [TestOptionalTypes]) -> [TestOptionalTypes] {
      return getDecodable(key) ?? defaultValue
   }

   public func getTestOptionalTypes(forKey key: String,  defaultValue: [String : TestOptionalTypes]
   ) -> [String : TestOptionalTypes] {
      return getTestOptionalTypes(forKey: key) ?? defaultValue
   }

   public func setTestOptionalTypes(value: TestOptionalTypes, forKey key: String) {
      set(value.encode(), forKey: key)
   }

   public func setTestOptionalTypes(value: [TestOptionalTypes], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }

   public func setTestOptionalTypes(value: [String : TestOptionalTypes], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }
}

//****************************************************************************//
// MARK: KVStore support
//****************************************************************************//
extension KVStore {

   public func getTestOptionalTypes(forKey key: String) -> TestOptionalTypes? {
      return getValue(forKey: key)
   }

   public func getTestOptionalTypes(forKey key: String, defaultValue: TestOptionalTypes) -> TestOptionalTypes {
      return getTestOptionalTypes(forKey: key) ?? defaultValue
   }

   public func getTestOptionalTypess(forKey key: String) -> [TestOptionalTypes]? {
      return getValue(forKey: key)
   }

   public func getTestOptionalTypess(forKey key: String, defaultValue: [TestOptionalTypes]) -> [TestOptionalTypes] {
      return getTestOptionalTypess(forKey: key) ?? defaultValue
   }

   public func getTestOptionalTypesDictionary(forKey key: String) -> [String : TestOptionalTypes]? {
      return getValue(forKey: key)
   }

   public func getTestOptionalTypesDictionary(forKey key: String, defaultValue: [String : TestOptionalTypes]) -> [String : TestOptionalTypes] {
      return getTestOptionalTypesDictionary(forKey: key) ?? defaultValue
   }
}

