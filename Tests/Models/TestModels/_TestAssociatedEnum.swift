/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State
import UIKit

public enum TestAssociatedEnum  : Model {

    case BinaryType (NSData)
    case BooleanType (Bool)
    case DateType (NSDate)
    case DecimalType (NSDecimalNumber)
    case DoubleType (Double)
    case FloatType (Float)
    case IntType (Int)
    case StringType (String)
    case TransformableColorType (UIColor)
    case DecodableToManyType ([Employee])
    case DecodableToOneType (Employee)

}

extension TestAssociatedEnum: Decodable {

   public static func decode(decoder: Decoder) -> TestAssociatedEnum? {
      return self.init(decoder: decoder)
   }

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = TestAssociatedEnum.performMigrationIfNeeded(decoder)

        guard let type: String = decoder.decode("TestAssociatedEnum") else { return nil }
        switch type {
                case "BinaryType":
                   if let value: NSData = decoder.decode("value") {
self = TestAssociatedEnum.BinaryType(value)
} else { return nil }

                case "BooleanType":
                   if let value: Bool = decoder.decode("value") {
self = TestAssociatedEnum.BooleanType(value)
} else { return nil }

                case "DateType":
                   if let value: NSDate = decoder.decode("value") {
self = TestAssociatedEnum.DateType(value)
} else { return nil }

                case "DecimalType":
                   if let value: NSDecimalNumber = decoder.decode("value") {
self = TestAssociatedEnum.DecimalType(value)
} else { return nil }

                case "DoubleType":
                   if let value: Double = decoder.decode("value") {
self = TestAssociatedEnum.DoubleType(value)
} else { return nil }

                case "FloatType":
                   if let value: Float = decoder.decode("value") {
self = TestAssociatedEnum.FloatType(value)
} else { return nil }

                case "IntType":
                   if let value: Int = decoder.decode("value") {
self = TestAssociatedEnum.IntType(value)
} else { return nil }

                case "StringType":
                   if let value: String = decoder.decode("value") {
self = TestAssociatedEnum.StringType(value)
} else { return nil }

                case "TransformableColorType":
                   if let value: UIColor = decoder.decode("value") {
self = TestAssociatedEnum.TransformableColorType(value)
} else { return nil }

                case "DecodableToManyType":
                    if let value: [Employee] = decoder.decode("value") {
self = TestAssociatedEnum.DecodableToManyType(value)
} else { return nil } 
                case "DecodableToOneType":
                    if let value: Employee = decoder.decode("value") {
self = TestAssociatedEnum.DecodableToOneType(value)
} else { return nil }

                default:
                    return nil
        }

    }
}

extension TestAssociatedEnum: Encodable {

    public func encode(encoder: Encoder) {

        switch self {
            case let .BinaryType(value):
                encoder.encode("BinaryType", "TestAssociatedEnum")
                encoder.encode(value, "value")
            case let .BooleanType(value):
                encoder.encode("BooleanType", "TestAssociatedEnum")
                encoder.encode(value, "value")
            case let .DateType(value):
                encoder.encode("DateType", "TestAssociatedEnum")
                encoder.encode(value, "value")
            case let .DecimalType(value):
                encoder.encode("DecimalType", "TestAssociatedEnum")
                encoder.encode(value, "value")
            case let .DoubleType(value):
                encoder.encode("DoubleType", "TestAssociatedEnum")
                encoder.encode(value, "value")
            case let .FloatType(value):
                encoder.encode("FloatType", "TestAssociatedEnum")
                encoder.encode(value, "value")
            case let .IntType(value):
                encoder.encode("IntType", "TestAssociatedEnum")
                encoder.encode(value, "value")
            case let .StringType(value):
                encoder.encode("StringType", "TestAssociatedEnum")
                encoder.encode(value, "value")
            case let .TransformableColorType(value):
                encoder.encode("TransformableColorType", "TestAssociatedEnum")
                encoder.encode(value, "value")
            case let .DecodableToManyType(value):
                encoder.encode("DecodableToManyType", "TestAssociatedEnum")
                encoder.encode(value, "value")
            case let .DecodableToOneType(value):
                encoder.encode("DecodableToOneType", "TestAssociatedEnum")
                encoder.encode(value, "value")

        }

        TestAssociatedEnum.encodeVersionIfNeeded(encoder)
        self.willFinishEncodingWithEncoder(encoder)
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

extension NSUserDefaults {

   //****************************************************************************//
   // MARK: NSUserDefault Getters
   //****************************************************************************//

   public func getTestAssociatedEnum(key: String) -> TestAssociatedEnum? {
      guard let dictionary = dictionaryForKey(key) else { return nil }
      return TestAssociatedEnum.decode(dictionary)
   }

   public func getTestAssociatedEnum(key: String) -> [TestAssociatedEnum]? {
      guard let array = arrayForKey(key) else { return nil }
      return sequence(array.map(TestAssociatedEnum.decode))
   }

   public func getTestAssociatedEnum(key: String) -> [String : TestAssociatedEnum]? {
      guard let dictionary = dictionaryForKey(key) else { return nil }
      return sequence(dictionary.map { TestAssociatedEnum.decode($0) })
   }

   public func getTestAssociatedEnum(key: String, defaultValue: TestAssociatedEnum) -> TestAssociatedEnum {
      return getTestAssociatedEnum(key) ?? defaultValue
   }

   public func getTestAssociatedEnum(key: String, defaultValue: [TestAssociatedEnum]) -> [TestAssociatedEnum] {
      return getDecodable(key) ?? defaultValue
   }

   public func getTestAssociatedEnum(key: String,  defaultValue: [String : TestAssociatedEnum]
   ) -> [String : TestAssociatedEnum] {
      return getTestAssociatedEnum(key) ?? defaultValue
   }

   //****************************************************************************//
   // MARK: NSUserDefault Setters
   //****************************************************************************//

   public func setTestAssociatedEnum(value: TestAssociatedEnum, forKey key: String) {
      setObject(value.encode(), forKey: key)
   }

   public func setTestAssociatedEnum(value: [TestAssociatedEnum], forKey key: String) {
      setObject(value.map { $0.encode() }, forKey: key)
   }

   public func setTestAssociatedEnum(value: [String : TestAssociatedEnum], forKey key: String) {
      setObject(value.map { $0.encode() }, forKey: key)
   }
}

extension KVStore {

   public func getTestAssociatedEnum(key: String) -> TestAssociatedEnum? {
      return getValue(key)
   }

   public func getTestAssociatedEnum(key: String, defaultValue: TestAssociatedEnum) -> TestAssociatedEnum {
      return getTestAssociatedEnum(key) ?? defaultValue
   }

   public func getTestAssociatedEnums(key: String) -> [TestAssociatedEnum]? {
      return getValue(key)
   }

   public func getTestAssociatedEnums(key: String, defaultValue: [TestAssociatedEnum]) -> [TestAssociatedEnum] {
      return getTestAssociatedEnums(key) ?? defaultValue
   }

   public func getTestAssociatedEnumDictionary(key: String) -> [String : TestAssociatedEnum]? {
      return getValue(key)
   }

   public func getTestAssociatedEnumDictionary(key: String, defaultValue: [String : TestAssociatedEnum]) -> [String : TestAssociatedEnum] {
      return getTestAssociatedEnumDictionary(key) ?? defaultValue
   }
}

