/************************************************

            MACHINE GENERATED FILE

 ************************************************/
import Foundation
import Spot
import UIKit

public enum TestAssociatedOptionalEnum {
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

        if TestAssociatedOptionalEnum.shouldMigrateIfNeeded {
            if let dataVersion: AnyObject = decoder.decode(TestAssociatedOptionalEnum.versionKey) {
                if TestAssociatedOptionalEnum.needsMigration(dataVersion) {
                   let migratedData = TestAssociatedOptionalEnum.migrateDataForDecoding(decoder.extractData(), dataVersion: dataVersion)
                    decoder = Decoder(data: migratedData)
                }
            }
        }

        if let type: String = decoder.decode("type") {

            switch type {
                case "binaryType":
                    if let value: NSData? = decoder.decode("value") >>> asOptional {
                        self = TestAssociatedOptionalEnum.BinaryType(value)
                    } else { return nil }
                case "booleanType":
                    if let value: Bool? = decoder.decode("value") >>> asOptional {
                        self = TestAssociatedOptionalEnum.BooleanType(value)
                    } else { return nil }
                case "dateType":
                    if let value: NSDate? = decoder.decode("value") >>> asOptional {
                        self = TestAssociatedOptionalEnum.DateType(value)
                    } else { return nil }
                case "decimalType":
                    if let value: NSDecimalNumber? = decoder.decode("value") >>> asOptional {
                        self = TestAssociatedOptionalEnum.DecimalType(value)
                    } else { return nil }
                case "doubleType":
                    if let value: Double? = decoder.decode("value") >>> asOptional {
                        self = TestAssociatedOptionalEnum.DoubleType(value)
                    } else { return nil }
                case "floatType":
                    if let value: Float? = decoder.decode("value") >>> asOptional {
                        self = TestAssociatedOptionalEnum.FloatType(value)
                    } else { return nil }
                case "intType":
                    if let value: Int? = decoder.decode("value") >>> asOptional {
                        self = TestAssociatedOptionalEnum.IntType(value)
                    } else { return nil }
                case "stringType":
                    if let value: String? = decoder.decode("value") >>> asOptional {
                        self = TestAssociatedOptionalEnum.StringType(value)
                    } else { return nil }
                case "transformableColorType":
                    if let value: UIColor? = decoder.decode("value") >>> UIColorTransform.reverseTransform >>> asOptional {
                        self = TestAssociatedOptionalEnum.TransformableColorType(value)
                    } else { return nil }
                case "decodableToManyType":
                    if let value: [Employee]? = decoder.decodeModelArray("value") >>> asOptional{
                        self = TestAssociatedOptionalEnum.DecodableToManyType(value)
                    } else { return nil }
                case "decodableToOneType":
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
                encoder.encode("binaryType", forKey: "type")
                encoder.encode(value, forKey: "value")
            case let .BooleanType(value):
                encoder.encode("booleanType", forKey: "type")
                encoder.encode(value, forKey: "value")
            case let .DateType(value):
                encoder.encode("dateType", forKey: "type")
                encoder.encode(value, forKey: "value")
            case let .DecimalType(value):
                encoder.encode("decimalType", forKey: "type")
                encoder.encode(value, forKey: "value")
            case let .DoubleType(value):
                encoder.encode("doubleType", forKey: "type")
                encoder.encode(value, forKey: "value")
            case let .FloatType(value):
                encoder.encode("floatType", forKey: "type")
                encoder.encode(value, forKey: "value")
            case let .IntType(value):
                encoder.encode("intType", forKey: "type")
                encoder.encode(value, forKey: "value")
            case let .StringType(value):
                encoder.encode("stringType", forKey: "type")
                encoder.encode(value, forKey: "value")
            case let .TransformableColorType(value):
                encoder.encode("transformableColorType", forKey: "type")
                encoder.encode(value >>> UIColorTransform.transform, forKey: "value")
            case let .DecodableToManyType(value):
                encoder.encode("decodableToManyType", forKey: "type")
                encoder.encode(value, forKey: "value")
            case let .DecodableToOneType(value):
                encoder.encode("decodableToOneType", forKey: "type")
                encoder.encode(value, forKey: "value")

        }
         self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestAssociatedOptionalEnum {
    /**
    These are provided from the data model designer
    and can be used to determine if the model is
    a different version.
    */
    static var modelVersionHash: String {
        return "<91a6ba56 f3ff3271 c6a947d9 d59ab16f 03cfe13e 869a8894 de84a78a dcfe623f>"
    }

    static var modelVersionHashModifier: String? {
        return nil
    }
}

