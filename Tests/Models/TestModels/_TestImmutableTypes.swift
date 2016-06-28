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

}

extension TestImmutableTypes : Decodable {

   public static func decode(_ decoder: Decoder) -> TestImmutableTypes? {
      return self.init(decoder: decoder)
   }

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = TestImmutableTypes.performMigrationIfNeeded(decoder)

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
        didFinishDecoding(decoder: decoder)
    }
}

extension TestImmutableTypes : Encodable {

    public func encode(_ encoder: Encoder) {
        encoder.encode(myDate, "myDate")
        encoder.encode(myFloat, "myFloat")
        encoder.encode(myBinary, "myBinary")
        encoder.encode(myDouble, "myDouble")
        encoder.encode(myString, "myString")
        encoder.encode(myBoolean, "myBoolean")
        encoder.encode(myDecimal, "myDecimal")
        encoder.encode(myInt, "myInt")

        TestImmutableTypes.encodeVersionIfNeeded(encoder)

        self.willFinishEncoding(encoder: encoder)
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

//****************************************************************************//
// MARK: UserDefaults support
//****************************************************************************//
extension UserDefaults {

   public func getTestImmutableTypes(forKey key: String) -> TestImmutableTypes? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return TestImmutableTypes.decode(dictionary)
   }

   public func getTestImmutableTypes(forKey key: String) -> [TestImmutableTypes]? {
      guard let array = array(forKey: key) else { return nil }
      return sequence(array.map(TestImmutableTypes.decode))
   }

   public func getTestImmutableTypes(forKey key: String) -> [String : TestImmutableTypes]? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return sequence(dictionary.map { TestImmutableTypes.decode($0) })
   }

   public func getTestImmutableTypes(forKey key: String, defaultValue: TestImmutableTypes) -> TestImmutableTypes {
      return getTestImmutableTypes(forKey: key) ?? defaultValue
   }

   public func getTestImmutableTypes(forKey key: String, defaultValue: [TestImmutableTypes]) -> [TestImmutableTypes] {
      return getDecodable(key) ?? defaultValue
   }

   public func getTestImmutableTypes(forKey key: String,  defaultValue: [String : TestImmutableTypes]) -> [String : TestImmutableTypes] {
      return getTestImmutableTypes(forKey: key) ?? defaultValue
   }

   public func setTestImmutableTypes(value: TestImmutableTypes, forKey key: String) {
      set(value.encode(), forKey: key)
   }

   public func setTestImmutableTypes(value: [TestImmutableTypes], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }

   public func setTestImmutableTypes(value: [String : TestImmutableTypes], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }
}

//****************************************************************************//
// MARK: KVStore support
//****************************************************************************//
extension KVStore {

   public func getTestImmutableTypes(forKey key: String) -> TestImmutableTypes? {
      return getValue(forKey: key)
   }

   public func getTestImmutableTypes(forKey key: String, defaultValue: TestImmutableTypes) -> TestImmutableTypes {
      return getTestImmutableTypes(forKey: key) ?? defaultValue
   }

   public func getTestImmutableTypess(forKey key: String) -> [TestImmutableTypes]? {
      return getValue(forKey: key)
   }

   public func getTestImmutableTypess(forKey key: String, defaultValue: [TestImmutableTypes]) -> [TestImmutableTypes] {
      return getTestImmutableTypess(forKey: key) ?? defaultValue
   }

   public func getTestImmutableTypesDictionary(forKey key: String) -> [String : TestImmutableTypes]? {
      return getValue(forKey: key)
   }

   public func getTestImmutableTypesDictionary(forKey key: String, defaultValue: [String : TestImmutableTypes]) -> [String : TestImmutableTypes] {
      return getTestImmutableTypesDictionary(forKey: key) ?? defaultValue
   }
}

