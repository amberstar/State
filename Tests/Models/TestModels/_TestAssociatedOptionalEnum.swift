/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State
import UIKit

public enum TestAssociatedOptionalEnum : Model  {
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

    public init?(var decoder: Decoder) {

    decoder = TestAssociatedOptionalEnum.performMigrationIfNeeded(decoder)

        if let type: String = decoder.decode("type") {

            switch type {
                case "BinaryType":
                    if let value: NSData? = decoder.decode("value") >>> asOptional {
                        self = TestAssociatedOptionalEnum.BinaryType(value)
                    } else { return nil }
                case "BooleanType":
                    if let value: Bool? = decoder.decode("value") >>> asOptional {
                        self = TestAssociatedOptionalEnum.BooleanType(value)
                    } else { return nil }
                case "DateType":
                    if let value: NSDate? = decoder.decode("value") >>> asOptional {
                        self = TestAssociatedOptionalEnum.DateType(value)
                    } else { return nil }
                case "DecimalType":
                    if let value: NSDecimalNumber? = decoder.decode("value") >>> asOptional {
                        self = TestAssociatedOptionalEnum.DecimalType(value)
                    } else { return nil }
                case "DoubleType":
                    if let value: Double? = decoder.decode("value") >>> asOptional {
                        self = TestAssociatedOptionalEnum.DoubleType(value)
                    } else { return nil }
                case "FloatType":
                    if let value: Float? = decoder.decode("value") >>> asOptional {
                        self = TestAssociatedOptionalEnum.FloatType(value)
                    } else { return nil }
                case "IntType":
                    if let value: Int? = decoder.decode("value") >>> asOptional {
                        self = TestAssociatedOptionalEnum.IntType(value)
                    } else { return nil }
                case "StringType":
                    if let value: String? = decoder.decode("value") >>> asOptional {
                        self = TestAssociatedOptionalEnum.StringType(value)
                    } else { return nil }
                case "TransformableColorType":
                    if let value: UIColor? = decoder.decode("value") >>> UIColorTransform.reverseTransform >>> asOptional {
                        self = TestAssociatedOptionalEnum.TransformableColorType(value)
                    } else { return nil }
                case "DecodableToManyType":
                    if let value: [Employee]? = decoder.decodeModelArray("value") >>> asOptional{
                        self = TestAssociatedOptionalEnum.DecodableToManyType(value)
                    } else { return nil }
                case "DecodableToOneType":
                    if let value: Employee? = decoder.decodeModel("value") >>> asOptional{
                        self = TestAssociatedOptionalEnum.DecodableToOneType(value)
                    } else { return nil }

                default:
                    return nil
            }
        } else { return nil }
    }
}

extension TestAssociatedOptionalEnum: Encodable {

    public func encode(encoder: Encoder) {

        switch self {
            case let .BinaryType(value):
                encoder.encode("BinaryType", "type")
                encoder.encode(value, "value")
            case let .BooleanType(value):
                encoder.encode("BooleanType", "type")
                encoder.encode(value, "value")
            case let .DateType(value):
                encoder.encode("DateType", "type")
                encoder.encode(value, "value")
            case let .DecimalType(value):
                encoder.encode("DecimalType", "type")
                encoder.encode(value, "value")
            case let .DoubleType(value):
                encoder.encode("DoubleType", "type")
                encoder.encode(value, "value")
            case let .FloatType(value):
                encoder.encode("FloatType", "type")
                encoder.encode(value, "value")
            case let .IntType(value):
                encoder.encode("IntType", "type")
                encoder.encode(value, "value")
            case let .StringType(value):
                encoder.encode("StringType", "type")
                encoder.encode(value, "value")
            case let .TransformableColorType(value):
                encoder.encode("TransformableColorType", "type")
                encoder.encode(value >>> UIColorTransform.transform, "value")
            case let .DecodableToManyType(value):
                encoder.encode("DecodableToManyType", "type")
                encoder.encode(value, "value")
            case let .DecodableToOneType(value):
                encoder.encode("DecodableToOneType", "type")
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

