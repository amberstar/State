/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State
import UIKit

public enum TestAssociatedOptionalEnum  : Model {

    case BinaryType (NSData?)
    case BooleanType (Bool?)
    case DateType (NSDate?)
    case DecimalType (NSDecimalNumber?)
    case DoubleType (Double?)
    case FloatType (Float?)
    case IntType (Int?)
    case StringType (String?)
    case TransformableColorType (UIColor?)
    case DecodableToManyType ([Employee]?)
    case DecodableToOneType (Employee?)

}

extension TestAssociatedOptionalEnum: Decodable {

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = TestAssociatedOptionalEnum.performMigrationIfNeeded(decoder)

        guard let type: String = decoder.decode("TestAssociatedOptionalEnum") else { return nil }
        switch type {
                case "BinaryType":
                   let value: NSData? = decoder.decode("value")
self = TestAssociatedOptionalEnum.BinaryType(value)

                case "BooleanType":
                   let value: Bool? = decoder.decode("value")
self = TestAssociatedOptionalEnum.BooleanType(value)

                case "DateType":
                   let value: NSDate? = decoder.decode("value")
self = TestAssociatedOptionalEnum.DateType(value)

                case "DecimalType":
                   let value: NSDecimalNumber? = decoder.decode("value")
self = TestAssociatedOptionalEnum.DecimalType(value)

                case "DoubleType":
                   let value: Double? = decoder.decode("value")
self = TestAssociatedOptionalEnum.DoubleType(value)

                case "FloatType":
                   let value: Float? = decoder.decode("value")
self = TestAssociatedOptionalEnum.FloatType(value)

                case "IntType":
                   let value: Int? = decoder.decode("value")
self = TestAssociatedOptionalEnum.IntType(value)

                case "StringType":
                   let value: String? = decoder.decode("value")
self = TestAssociatedOptionalEnum.StringType(value)

                case "TransformableColorType":
                   let value: UIColor? = decoder.decode("value") >>> UIColorTransform.reverse
self = TestAssociatedOptionalEnum.TransformableColorType(value)

                case "DecodableToManyType":
                    let value: [Employee]? = decoder.decode("value")
self = TestAssociatedOptionalEnum.DecodableToManyType(value)

                case "DecodableToOneType":
                    let value: Employee? = decoder.decode("value")
self = TestAssociatedOptionalEnum.DecodableToOneType(value)

                default:
                    return nil
        }

    }
}

extension TestAssociatedOptionalEnum: Encodable {

    public func encode(encoder: Encoder) {

        switch self {
            case let .BinaryType(value):
                encoder.encode("BinaryType", "TestAssociatedOptionalEnum")
                encoder.encode(value, "value")
            case let .BooleanType(value):
                encoder.encode("BooleanType", "TestAssociatedOptionalEnum")
                encoder.encode(value, "value")
            case let .DateType(value):
                encoder.encode("DateType", "TestAssociatedOptionalEnum")
                encoder.encode(value, "value")
            case let .DecimalType(value):
                encoder.encode("DecimalType", "TestAssociatedOptionalEnum")
                encoder.encode(value, "value")
            case let .DoubleType(value):
                encoder.encode("DoubleType", "TestAssociatedOptionalEnum")
                encoder.encode(value, "value")
            case let .FloatType(value):
                encoder.encode("FloatType", "TestAssociatedOptionalEnum")
                encoder.encode(value, "value")
            case let .IntType(value):
                encoder.encode("IntType", "TestAssociatedOptionalEnum")
                encoder.encode(value, "value")
            case let .StringType(value):
                encoder.encode("StringType", "TestAssociatedOptionalEnum")
                encoder.encode(value, "value")
            case let .TransformableColorType(value):
                encoder.encode("TransformableColorType", "TestAssociatedOptionalEnum")
                encoder.encode(value >>> UIColorTransform.apply, "value")
            case let .DecodableToManyType(value):
                encoder.encode("DecodableToManyType", "TestAssociatedOptionalEnum")
                encoder.encode(value, "value")
            case let .DecodableToOneType(value):
                encoder.encode("DecodableToOneType", "TestAssociatedOptionalEnum")
                encoder.encode(value, "value")

        }

        TestAssociatedOptionalEnum.encodeVersionIfNeeded(encoder)
        self.willFinishEncodingWithEncoder(encoder)
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
