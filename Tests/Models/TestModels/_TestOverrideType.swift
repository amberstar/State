/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestOverrideType : Model {
    public var myURL: NSURL?
    public var myArrayOfString: [String]?

}

extension TestOverrideType : Decodable {

   public static func decode(_ decoder: Decoder) -> TestOverrideType? {
      return self.init(decoder: decoder)
   }

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = TestOverrideType.performMigrationIfNeeded(decoder)

        let myURL: NSURL? = decoder.decode("myURL")
        let myArrayOfString: [String]? = decoder.decode("myArrayOfString")

        self.myURL = myURL
        self.myArrayOfString = myArrayOfString
        didFinishDecoding(decoder: decoder)
    }
}

extension TestOverrideType : Encodable {

    public func encode(_ encoder: Encoder) {
        encoder.encode(myURL, "myURL")
        encoder.encode(myArrayOfString, "myArrayOfString")

        TestOverrideType.encodeVersionIfNeeded(encoder)

        self.willFinishEncoding(encoder: encoder)
    }
}

extension TestOverrideType {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<1b2022d4 1d237610 f72665c6 67dea8a1 a68750de df8625c3 d9495017 916e62c6>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

//****************************************************************************//
// MARK: UserDefaults support
//****************************************************************************//
extension UserDefaults {

   public func getTestOverrideType(forKey key: String) -> TestOverrideType? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return TestOverrideType.decode(dictionary)
   }

   public func getTestOverrideType(forKey key: String) -> [TestOverrideType]? {
      guard let array = array(forKey: key) else { return nil }
      return sequence(array.map(TestOverrideType.decode))
   }

   public func getTestOverrideType(forKey key: String) -> [String : TestOverrideType]? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return sequence(dictionary.map { TestOverrideType.decode($0) })
   }

   public func getTestOverrideType(forKey key: String, defaultValue: TestOverrideType) -> TestOverrideType {
      return getTestOverrideType(forKey: key) ?? defaultValue
   }

   public func getTestOverrideType(forKey key: String, defaultValue: [TestOverrideType]) -> [TestOverrideType] {
      return getDecodable(key) ?? defaultValue
   }

   public func getTestOverrideType(forKey key: String,  defaultValue: [String : TestOverrideType]) -> [String : TestOverrideType] {
      return getTestOverrideType(forKey: key) ?? defaultValue
   }

   public func setTestOverrideType(value: TestOverrideType, forKey key: String) {
      set(value.encode(), forKey: key)
   }

   public func setTestOverrideType(value: [TestOverrideType], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }

   public func setTestOverrideType(value: [String : TestOverrideType], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }
}

//****************************************************************************//
// MARK: KVStore support
//****************************************************************************//
extension KVStore {

   public func getTestOverrideType(forKey key: String) -> TestOverrideType? {
      return getValue(forKey: key)
   }

   public func getTestOverrideType(forKey key: String, defaultValue: TestOverrideType) -> TestOverrideType {
      return getTestOverrideType(forKey: key) ?? defaultValue
   }

   public func getTestOverrideTypes(forKey key: String) -> [TestOverrideType]? {
      return getValue(forKey: key)
   }

   public func getTestOverrideTypes(forKey key: String, defaultValue: [TestOverrideType]) -> [TestOverrideType] {
      return getTestOverrideTypes(forKey: key) ?? defaultValue
   }

   public func getTestOverrideTypeDictionary(forKey key: String) -> [String : TestOverrideType]? {
      return getValue(forKey: key)
   }

   public func getTestOverrideTypeDictionary(forKey key: String, defaultValue: [String : TestOverrideType]) -> [String : TestOverrideType] {
      return getTestOverrideTypeDictionary(forKey: key) ?? defaultValue
   }
}

