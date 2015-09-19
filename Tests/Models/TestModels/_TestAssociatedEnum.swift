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

    public init?(var decoder: Decoder) {

        decoder = TestAssociatedEnum.performMigrationIfNeeded(decoder)

        if let type: String = decoder.decode("type") {

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
                    if let value: UIColor = decoder.decode("value") >>> UIColorTransform.reverseTransform {
                        self = TestAssociatedEnum.TransformableColorType(value)
                    } else { return nil }
                case "DecodableToManyType":
                    if let value: [Employee] = decoder.decodeModelArray("value") {
                        self = TestAssociatedEnum.DecodableToManyType(value)
                    } else { return nil }
                case "DecodableToOneType":
                    if let value: Employee = decoder.decodeModel("value") {
                        self = TestAssociatedEnum.DecodableToOneType(value)
                    } else { return nil }

                default:
                    return nil
            }
        } else { return nil }
    }
}

extension TestAssociatedEnum: Encodable {

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
