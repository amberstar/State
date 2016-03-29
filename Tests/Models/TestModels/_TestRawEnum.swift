/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public enum TestRawEnum  : String, Model {

    case Aim  = "Aim"
    case Fire  = "Fire"
    case Ready  = "Ready"

}

extension TestRawEnum: Decodable {

   public static func decode(decoder: Decoder) -> TestRawEnum? {
      return self.init(decoder: decoder)
   }

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = TestRawEnum.performMigrationIfNeeded(decoder)
        guard let value: String = decoder.decode("value") else { return nil }
        self.init(rawValue: value)
    }
}

extension TestRawEnum: Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(self.rawValue, "value")
        TestRawEnum.encodeVersionIfNeeded(encoder)
        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestRawEnum {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<4a42ad80 0164503c a7c17d8c 2a24bcf5 f44a5730 0fab6252 969f7b23 e3ff6822>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

extension NSUserDefaults {

   //****************************************************************************//
   // MARK: NSUserDefault Getters
   //****************************************************************************//

   public func getTestRawEnum(key: String) -> TestRawEnum? {
      guard let dictionary = dictionaryForKey(key) else { return nil }
      return TestRawEnum.decode(dictionary)
   }

   public func getTestRawEnum(key: String) -> [TestRawEnum]? {
      guard let array = arrayForKey(key) else { return nil }
      return sequence(array.map(TestRawEnum.decode))
   }

   public func getTestRawEnum(key: String) -> [String : TestRawEnum]? {
      guard let dictionary = dictionaryForKey(key) else { return nil }
      return sequence(dictionary.map { TestRawEnum.decode($0) })
   }

   public func getTestRawEnum(key: String, defaultValue: TestRawEnum) -> TestRawEnum {
      return getTestRawEnum(key) ?? defaultValue
   }

   public func getTestRawEnum(key: String, defaultValue: [TestRawEnum]) -> [TestRawEnum] {
      return getDecodable(key) ?? defaultValue
   }

   public func getTestRawEnum(key: String,  defaultValue: [String : TestRawEnum]
   ) -> [String : TestRawEnum] {
      return getTestRawEnum(key) ?? defaultValue
   }

   //****************************************************************************//
   // MARK: NSUserDefault Setters
   //****************************************************************************//

   public func setTestRawEnum(value: TestRawEnum, forKey key: String) {
      setObject(value.encode(), forKey: key)
   }

   public func setTestRawEnum(value: [TestRawEnum], forKey key: String) {
      setObject(value.map { $0.encode() }, forKey: key)
   }

   public func setTestRawEnum(value: [String : TestRawEnum], forKey key: String) {
      setObject(value.map { $0.encode() }, forKey: key)
   }
}

extension KVStore {

   public func getTestRawEnum(key: String) -> TestRawEnum? {
      return getValue(key)
   }

   public func getTestRawEnum(key: String, defaultValue: TestRawEnum) -> TestRawEnum {
      return getTestRawEnum(key) ?? defaultValue
   }

   public func getTestRawEnums(key: String) -> [TestRawEnum]? {
      return getValue(key)
   }

   public func getTestRawEnums(key: String, defaultValue: [TestRawEnum]) -> [TestRawEnum] {
      return getTestRawEnums(key) ?? defaultValue
   }

   public func getTestRawEnumDictionary(key: String) -> [String : TestRawEnum]? {
      return getValue(key)
   }

   public func getTestRawEnumDictionary(key: String, defaultValue: [String : TestRawEnum]) -> [String : TestRawEnum] {
      return getTestRawEnumDictionary(key) ?? defaultValue
   }
}

