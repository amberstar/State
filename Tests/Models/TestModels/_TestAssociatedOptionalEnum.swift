/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State
import UIKit

public enum TestAssociatedOptionalEnum  : Model {

    case binaryType (NSData?)
    case booleanType (Bool?)
    case dateType (NSDate?)
    case decimalType (NSDecimalNumber?)
    case doubleType (Double?)
    case floatType (Float?)
    case intType (Int?)
    case stringType (String?)
    case transformableColorType (UIColor?)
    case decodableToManyType ([Employee]?)
    case decodableToOneType (Employee?)

}

extension TestAssociatedOptionalEnum: Decodable {

   public static func decode(_ decoder: Decoder) -> TestAssociatedOptionalEnum? {
      return self.init(decoder: decoder)
   }

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = TestAssociatedOptionalEnum.performMigrationIfNeeded(decoder)

        guard let type: String = decoder.decode("TestAssociatedOptionalEnum") else { return nil }
        switch type {
                case "binaryType":
                   let value: NSData? = decoder.decode("value")
self = TestAssociatedOptionalEnum.binaryType(value)

                case "booleanType":
                   let value: Bool? = decoder.decode("value")
self = TestAssociatedOptionalEnum.booleanType(value)

                case "dateType":
                   let value: NSDate? = decoder.decode("value")
self = TestAssociatedOptionalEnum.dateType(value)

                case "decimalType":
                   let value: NSDecimalNumber? = decoder.decode("value")
self = TestAssociatedOptionalEnum.decimalType(value)

                case "doubleType":
                   let value: Double? = decoder.decode("value")
self = TestAssociatedOptionalEnum.doubleType(value)

                case "floatType":
                   let value: Float? = decoder.decode("value")
self = TestAssociatedOptionalEnum.floatType(value)

                case "intType":
                   let value: Int? = decoder.decode("value")
self = TestAssociatedOptionalEnum.intType(value)

                case "stringType":
                   let value: String? = decoder.decode("value")
self = TestAssociatedOptionalEnum.stringType(value)

                case "transformableColorType":
                   let value: UIColor? = decoder.decode("value")
self = TestAssociatedOptionalEnum.transformableColorType(value)

                case "decodableToManyType":
                    let value: [Employee]? = decoder.decode("value")
self = TestAssociatedOptionalEnum.decodableToManyType(value)

                case "decodableToOneType":
                    let value: Employee? = decoder.decode("value")
self = TestAssociatedOptionalEnum.decodableToOneType(value)

                default:
                    return nil
        }

    }
}

extension TestAssociatedOptionalEnum: Encodable {

    public func encode(_ encoder: Encoder) {

        switch self {
            case let .binaryType(value):
                encoder.encode("binaryType", "TestAssociatedOptionalEnum")
                encoder.encode(value, "value")
            case let .booleanType(value):
                encoder.encode("booleanType", "TestAssociatedOptionalEnum")
                encoder.encode(value, "value")
            case let .dateType(value):
                encoder.encode("dateType", "TestAssociatedOptionalEnum")
                encoder.encode(value, "value")
            case let .decimalType(value):
                encoder.encode("decimalType", "TestAssociatedOptionalEnum")
                encoder.encode(value, "value")
            case let .doubleType(value):
                encoder.encode("doubleType", "TestAssociatedOptionalEnum")
                encoder.encode(value, "value")
            case let .floatType(value):
                encoder.encode("floatType", "TestAssociatedOptionalEnum")
                encoder.encode(value, "value")
            case let .intType(value):
                encoder.encode("intType", "TestAssociatedOptionalEnum")
                encoder.encode(value, "value")
            case let .stringType(value):
                encoder.encode("stringType", "TestAssociatedOptionalEnum")
                encoder.encode(value, "value")
            case let .transformableColorType(value):
                encoder.encode("transformableColorType", "TestAssociatedOptionalEnum")
                encoder.encode(value, "value")
            case let .decodableToManyType(value):
                encoder.encode("decodableToManyType", "TestAssociatedOptionalEnum")
                encoder.encode(value, "value")
            case let .decodableToOneType(value):
                encoder.encode("decodableToOneType", "TestAssociatedOptionalEnum")
                encoder.encode(value, "value")

        }

        TestAssociatedOptionalEnum.encodeVersionIfNeeded(encoder)
        self.willFinishEncoding(encoder: encoder)
    }
}

extension TestAssociatedOptionalEnum {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<91a6ba56 f3ff3271 c6a947d9 d59ab16f 03cfe13e 869a8894 de84a78a dcfe623f>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

//****************************************************************************//
// MARK: UserDefaults support
//****************************************************************************//
extension UserDefaults {

   public func getTestAssociatedOptionalEnum(forKey key: String) -> TestAssociatedOptionalEnum? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return TestAssociatedOptionalEnum.decode(dictionary)
   }

   public func getTestAssociatedOptionalEnum(forKey key: String) -> [TestAssociatedOptionalEnum]? {
      guard let array = array(forKey: key) else { return nil }
      return sequence(array.map(TestAssociatedOptionalEnum.decode))
   }

   public func getTestAssociatedOptionalEnum(forKey key: String) -> [String : TestAssociatedOptionalEnum]? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return sequence(dictionary.map { TestAssociatedOptionalEnum.decode($0) })
   }

   public func getTestAssociatedOptionalEnum(forKey key: String, defaultValue: TestAssociatedOptionalEnum) -> TestAssociatedOptionalEnum {
      return getTestAssociatedOptionalEnum(forKey: key) ?? defaultValue
   }

   public func getTestAssociatedOptionalEnum(forKey key: String, defaultValue: [TestAssociatedOptionalEnum]) -> [TestAssociatedOptionalEnum] {
      return getDecodable(key) ?? defaultValue
   }

   public func getTestAssociatedOptionalEnum(forKey key: String,  defaultValue: [String : TestAssociatedOptionalEnum]) -> [String : TestAssociatedOptionalEnum] {
      return getTestAssociatedOptionalEnum(forKey: key) ?? defaultValue
   }

   public func setTestAssociatedOptionalEnum(value: TestAssociatedOptionalEnum, forKey key: String) {
      set(value.encode(), forKey: key)
   }

   public func setTestAssociatedOptionalEnum(value: [TestAssociatedOptionalEnum], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }

   public func setTestAssociatedOptionalEnum(value: [String : TestAssociatedOptionalEnum], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }
}

//****************************************************************************//
// MARK: KVStore support
//****************************************************************************//
extension KVStore {

   public func getTestAssociatedOptionalEnum(forKey key: String) -> TestAssociatedOptionalEnum? {
      return getValue(forKey: key)
   }

   public func getTestAssociatedOptionalEnum(forKey key: String, defaultValue: TestAssociatedOptionalEnum) -> TestAssociatedOptionalEnum {
      return getTestAssociatedOptionalEnum(forKey: key) ?? defaultValue
   }

   public func getTestAssociatedOptionalEnums(forKey key: String) -> [TestAssociatedOptionalEnum]? {
      return getValue(forKey: key)
   }

   public func getTestAssociatedOptionalEnums(forKey key: String, defaultValue: [TestAssociatedOptionalEnum]) -> [TestAssociatedOptionalEnum] {
      return getTestAssociatedOptionalEnums(forKey: key) ?? defaultValue
   }

   public func getTestAssociatedOptionalEnumDictionary(forKey key: String) -> [String : TestAssociatedOptionalEnum]? {
      return getValue(forKey: key)
   }

   public func getTestAssociatedOptionalEnumDictionary(forKey key: String, defaultValue: [String : TestAssociatedOptionalEnum]) -> [String : TestAssociatedOptionalEnum] {
      return getTestAssociatedOptionalEnumDictionary(forKey: key) ?? defaultValue
   }
}

