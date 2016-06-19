/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public enum TestRegEnum  : Model {

    case cold 
    case hot

}

extension TestRegEnum: Decodable {

   public static func decode(_ decoder: Decoder) -> TestRegEnum? {
      return self.init(decoder: decoder)
   }

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = TestRegEnum.performMigrationIfNeeded(decoder)

        guard let type: String = decoder.decode("TestRegEnum") else { return nil }
        switch type {
                case "cold":
                   self = TestRegEnum.cold
                case "hot":
                   self = TestRegEnum.hot

                default:
                    return nil
        }

    }
}

extension TestRegEnum: Encodable {

    public func encode(_ encoder: Encoder) {

        switch self {
            case .cold:
                encoder.encode("cold", "TestRegEnum")
            case .hot:
                encoder.encode("hot", "TestRegEnum")

        }

        TestRegEnum.encodeVersionIfNeeded(encoder)
        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestRegEnum {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<a3ed22fb 5deb7f55 1bee0f09 d897dfba 9f6b506f da233147 ba5d0c7b 67981e5c>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

//****************************************************************************//
// MARK: UserDefaults support
//****************************************************************************//
extension UserDefaults {

   public func getTestRegEnum(forKey key: String) -> TestRegEnum? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return TestRegEnum.decode(dictionary)
   }

   public func getTestRegEnum(forKey key: String) -> [TestRegEnum]? {
      guard let array = array(forKey: key) else { return nil }
      return sequence(array.map(TestRegEnum.decode))
   }

   public func getTestRegEnum(forKey key: String) -> [String : TestRegEnum]? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return sequence(dictionary.map { TestRegEnum.decode($0) })
   }

   public func getTestRegEnum(forKey key: String, defaultValue: TestRegEnum) -> TestRegEnum {
      return getTestRegEnum(forKey: key) ?? defaultValue
   }

   public func getTestRegEnum(forKey key: String, defaultValue: [TestRegEnum]) -> [TestRegEnum] {
      return getDecodable(key) ?? defaultValue
   }

   public func getTestRegEnum(forKey key: String,  defaultValue: [String : TestRegEnum]
   ) -> [String : TestRegEnum] {
      return getTestRegEnum(forKey: key) ?? defaultValue
   }

   public func setTestRegEnum(value: TestRegEnum, forKey key: String) {
      set(value.encode(), forKey: key)
   }

   public func setTestRegEnum(value: [TestRegEnum], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }

   public func setTestRegEnum(value: [String : TestRegEnum], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }
}

//****************************************************************************//
// MARK: KVStore support
//****************************************************************************//
extension KVStore {

   public func getTestRegEnum(forKey key: String) -> TestRegEnum? {
      return getValue(forKey: key)
   }

   public func getTestRegEnum(forKey key: String, defaultValue: TestRegEnum) -> TestRegEnum {
      return getTestRegEnum(forKey: key) ?? defaultValue
   }

   public func getTestRegEnums(forKey key: String) -> [TestRegEnum]? {
      return getValue(forKey: key)
   }

   public func getTestRegEnums(forKey key: String, defaultValue: [TestRegEnum]) -> [TestRegEnum] {
      return getTestRegEnums(forKey: key) ?? defaultValue
   }

   public func getTestRegEnumDictionary(forKey key: String) -> [String : TestRegEnum]? {
      return getValue(forKey: key)
   }

   public func getTestRegEnumDictionary(forKey key: String, defaultValue: [String : TestRegEnum]) -> [String : TestRegEnum] {
      return getTestRegEnumDictionary(forKey: key) ?? defaultValue
   }
}

