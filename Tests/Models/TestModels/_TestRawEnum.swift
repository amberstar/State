/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public enum TestRawEnum  : String, Model {

    case aim  = "Aim"
    case fire  = "Fire"
    case ready  = "Ready"

}

extension TestRawEnum: Decodable {

   public static func decode(_ decoder: Decoder) -> TestRawEnum? {
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

    public func encode(_ encoder: Encoder) {
        encoder.encode(self.rawValue, "value")
        TestRawEnum.encodeVersionIfNeeded(encoder)
        self.willFinishEncoding(encoder: encoder)
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

//****************************************************************************//
// MARK: UserDefaults support
//****************************************************************************//
extension UserDefaults {

   public func getTestRawEnum(forKey key: String) -> TestRawEnum? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return TestRawEnum.decode(dictionary)
   }

   public func getTestRawEnum(forKey key: String) -> [TestRawEnum]? {
      guard let array = array(forKey: key) else { return nil }
      return sequence(array.map(TestRawEnum.decode))
   }

   public func getTestRawEnum(forKey key: String) -> [String : TestRawEnum]? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return sequence(dictionary.map { TestRawEnum.decode($0) })
   }

   public func getTestRawEnum(forKey key: String, defaultValue: TestRawEnum) -> TestRawEnum {
      return getTestRawEnum(forKey: key) ?? defaultValue
   }

   public func getTestRawEnum(forKey key: String, defaultValue: [TestRawEnum]) -> [TestRawEnum] {
      return getDecodable(key) ?? defaultValue
   }

   public func getTestRawEnum(forKey key: String,  defaultValue: [String : TestRawEnum]) -> [String : TestRawEnum] {
      return getTestRawEnum(forKey: key) ?? defaultValue
   }

   public func setTestRawEnum(value: TestRawEnum, forKey key: String) {
      set(value.encode(), forKey: key)
   }

   public func setTestRawEnum(value: [TestRawEnum], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }

   public func setTestRawEnum(value: [String : TestRawEnum], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }
}

//****************************************************************************//
// MARK: KVStore support
//****************************************************************************//
extension KVStore {

   public func getTestRawEnum(forKey key: String) -> TestRawEnum? {
      return getValue(forKey: key)
   }

   public func getTestRawEnum(forKey key: String, defaultValue: TestRawEnum) -> TestRawEnum {
      return getTestRawEnum(forKey: key) ?? defaultValue
   }

   public func getTestRawEnums(forKey key: String) -> [TestRawEnum]? {
      return getValue(forKey: key)
   }

   public func getTestRawEnums(forKey key: String, defaultValue: [TestRawEnum]) -> [TestRawEnum] {
      return getTestRawEnums(forKey: key) ?? defaultValue
   }

   public func getTestRawEnumDictionary(forKey key: String) -> [String : TestRawEnum]? {
      return getValue(forKey: key)
   }

   public func getTestRawEnumDictionary(forKey key: String, defaultValue: [String : TestRawEnum]) -> [String : TestRawEnum] {
      return getTestRawEnumDictionary(forKey: key) ?? defaultValue
   }
}

