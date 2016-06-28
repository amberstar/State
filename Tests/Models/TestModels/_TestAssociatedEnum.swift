/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State
import UIKit

public enum TestAssociatedEnum  : Model {

    case binaryType (NSData)
    case booleanType (Bool)
    case dateType (NSDate)
    case decimalType (NSDecimalNumber)
    case doubleType (Double)
    case floatType (Float)
    case intType (Int)
    case stringType (String)
    case transformableColorType (UIColor)
    case decodableToManyType ([Employee])
    case decodableToOneType (Employee)

}

extension TestAssociatedEnum: Decodable {

   public static func decode(_ decoder: Decoder) -> TestAssociatedEnum? {
      return self.init(decoder: decoder)
   }

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = TestAssociatedEnum.performMigrationIfNeeded(decoder)

        guard let type: String = decoder.decode("TestAssociatedEnum") else { return nil }
        switch type {
                case "binaryType":
                   if let value: NSData = decoder.decode("value") {
self = TestAssociatedEnum.binaryType(value)
} else { return nil }

                case "booleanType":
                   if let value: Bool = decoder.decode("value") {
self = TestAssociatedEnum.booleanType(value)
} else { return nil }

                case "dateType":
                   if let value: NSDate = decoder.decode("value") {
self = TestAssociatedEnum.dateType(value)
} else { return nil }

                case "decimalType":
                   if let value: NSDecimalNumber = decoder.decode("value") {
self = TestAssociatedEnum.decimalType(value)
} else { return nil }

                case "doubleType":
                   if let value: Double = decoder.decode("value") {
self = TestAssociatedEnum.doubleType(value)
} else { return nil }

                case "floatType":
                   if let value: Float = decoder.decode("value") {
self = TestAssociatedEnum.floatType(value)
} else { return nil }

                case "intType":
                   if let value: Int = decoder.decode("value") {
self = TestAssociatedEnum.intType(value)
} else { return nil }

                case "stringType":
                   if let value: String = decoder.decode("value") {
self = TestAssociatedEnum.stringType(value)
} else { return nil }

                case "transformableColorType":
                   if let value: UIColor = decoder.decode("value") {
self = TestAssociatedEnum.transformableColorType(value)
} else { return nil }

                case "decodableToManyType":
                    if let value: [Employee] = decoder.decode("value") {
self = TestAssociatedEnum.decodableToManyType(value)
} else { return nil } 
                case "decodableToOneType":
                    if let value: Employee = decoder.decode("value") {
self = TestAssociatedEnum.decodableToOneType(value)
} else { return nil }

                default:
                    return nil
        }

    }
}

extension TestAssociatedEnum: Encodable {

    public func encode(_ encoder: Encoder) {

        switch self {
            case let .binaryType(value):
                encoder.encode("binaryType", "TestAssociatedEnum")
                encoder.encode(value, "value")
            case let .booleanType(value):
                encoder.encode("booleanType", "TestAssociatedEnum")
                encoder.encode(value, "value")
            case let .dateType(value):
                encoder.encode("dateType", "TestAssociatedEnum")
                encoder.encode(value, "value")
            case let .decimalType(value):
                encoder.encode("decimalType", "TestAssociatedEnum")
                encoder.encode(value, "value")
            case let .doubleType(value):
                encoder.encode("doubleType", "TestAssociatedEnum")
                encoder.encode(value, "value")
            case let .floatType(value):
                encoder.encode("floatType", "TestAssociatedEnum")
                encoder.encode(value, "value")
            case let .intType(value):
                encoder.encode("intType", "TestAssociatedEnum")
                encoder.encode(value, "value")
            case let .stringType(value):
                encoder.encode("stringType", "TestAssociatedEnum")
                encoder.encode(value, "value")
            case let .transformableColorType(value):
                encoder.encode("transformableColorType", "TestAssociatedEnum")
                encoder.encode(value, "value")
            case let .decodableToManyType(value):
                encoder.encode("decodableToManyType", "TestAssociatedEnum")
                encoder.encode(value, "value")
            case let .decodableToOneType(value):
                encoder.encode("decodableToOneType", "TestAssociatedEnum")
                encoder.encode(value, "value")

        }

        TestAssociatedEnum.encodeVersionIfNeeded(encoder)
        self.willFinishEncoding(encoder: encoder)
    }
}

extension TestAssociatedEnum {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<6da9f98e 37df6363 56b14e25 3100b317 ea72bc42 9578573b 17427080 0a824a73>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

//****************************************************************************//
// MARK: UserDefaults support
//****************************************************************************//
extension UserDefaults {

   public func getTestAssociatedEnum(forKey key: String) -> TestAssociatedEnum? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return TestAssociatedEnum.decode(dictionary)
   }

   public func getTestAssociatedEnum(forKey key: String) -> [TestAssociatedEnum]? {
      guard let array = array(forKey: key) else { return nil }
      return sequence(array.map(TestAssociatedEnum.decode))
   }

   public func getTestAssociatedEnum(forKey key: String) -> [String : TestAssociatedEnum]? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return sequence(dictionary.map { TestAssociatedEnum.decode($0) })
   }

   public func getTestAssociatedEnum(forKey key: String, defaultValue: TestAssociatedEnum) -> TestAssociatedEnum {
      return getTestAssociatedEnum(forKey: key) ?? defaultValue
   }

   public func getTestAssociatedEnum(forKey key: String, defaultValue: [TestAssociatedEnum]) -> [TestAssociatedEnum] {
      return getDecodable(key) ?? defaultValue
   }

   public func getTestAssociatedEnum(forKey key: String,  defaultValue: [String : TestAssociatedEnum]) -> [String : TestAssociatedEnum] {
      return getTestAssociatedEnum(forKey: key) ?? defaultValue
   }

   public func setTestAssociatedEnum(value: TestAssociatedEnum, forKey key: String) {
      set(value.encode(), forKey: key)
   }

   public func setTestAssociatedEnum(value: [TestAssociatedEnum], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }

   public func setTestAssociatedEnum(value: [String : TestAssociatedEnum], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }
}

//****************************************************************************//
// MARK: KVStore support
//****************************************************************************//
extension KVStore {

   public func getTestAssociatedEnum(forKey key: String) -> TestAssociatedEnum? {
      return getValue(forKey: key)
   }

   public func getTestAssociatedEnum(forKey key: String, defaultValue: TestAssociatedEnum) -> TestAssociatedEnum {
      return getTestAssociatedEnum(forKey: key) ?? defaultValue
   }

   public func getTestAssociatedEnums(forKey key: String) -> [TestAssociatedEnum]? {
      return getValue(forKey: key)
   }

   public func getTestAssociatedEnums(forKey key: String, defaultValue: [TestAssociatedEnum]) -> [TestAssociatedEnum] {
      return getTestAssociatedEnums(forKey: key) ?? defaultValue
   }

   public func getTestAssociatedEnumDictionary(forKey key: String) -> [String : TestAssociatedEnum]? {
      return getValue(forKey: key)
   }

   public func getTestAssociatedEnumDictionary(forKey key: String, defaultValue: [String : TestAssociatedEnum]) -> [String : TestAssociatedEnum] {
      return getTestAssociatedEnumDictionary(forKey: key) ?? defaultValue
   }
}

