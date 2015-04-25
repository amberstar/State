/************************************************

            MACHINE GENERATED FILE

 ************************************************/

import Spot

public enum TestAssociatedEnum {
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

        if TestAssociatedEnum.shouldMigrateIfNeeded {
            if let dataVersion: AnyObject = decoder.decode(TestAssociatedEnum.versionKey) {
                if TestAssociatedEnum.needsMigration(dataVersion) {
                   let migratedData = TestAssociatedEnum.migrateDataForDecoding(decoder.extractData(), dataVersion: dataVersion)
                    decoder = Decoder(data: migratedData)
                }
            }
        }

        if let type: String = decoder.decode("type") {

            switch type {
                case "binaryType":
                    if let value: NSData = decoder.decode("value") {
                        self = TestAssociatedEnum.BinaryType(value)
                    } else { return nil }
                case "booleanType":
                    if let value: Bool = decoder.decode("value") {
                        self = TestAssociatedEnum.BooleanType(value)
                    } else { return nil }
                case "dateType":
                    if let value: NSDate = decoder.decode("value") {
                        self = TestAssociatedEnum.DateType(value)
                    } else { return nil }
                case "decimalType":
                    if let value: NSDecimalNumber = decoder.decode("value") {
                        self = TestAssociatedEnum.DecimalType(value)
                    } else { return nil }
                case "doubleType":
                    if let value: Double = decoder.decode("value") {
                        self = TestAssociatedEnum.DoubleType(value)
                    } else { return nil }
                case "floatType":
                    if let value: Float = decoder.decode("value") {
                        self = TestAssociatedEnum.FloatType(value)
                    } else { return nil }
                case "intType":
                    if let value: Int = decoder.decode("value") {
                        self = TestAssociatedEnum.IntType(value)
                    } else { return nil }
                case "stringType":
                    if let value: String = decoder.decode("value") {
                        self = TestAssociatedEnum.StringType(value)
                    } else { return nil }
                case "transformableColorType":
                    if let value: UIColor = decoder.decode("value") >>> UIColorTransform.reverseTransform {
                        self = TestAssociatedEnum.TransformableColorType(value)
                    } else { return nil }
                case "decodableToManyType":
                    if let value: [Employee] = decoder.decodeModelArray("value") {
                        self = TestAssociatedEnum.DecodableToManyType(value)
                    } else { return nil }
                case "decodableToOneType":
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

extension TestAssociatedEnum {
    /**
    These are provided from the data model designer
    and can be used to determine if the model is
    a different version.
    */
    static var modelVersionHash: String {
        return "<6da9f98e 37df6363 56b14e25 3100b317 ea72bc42 9578573b 17427080 0a824a73>"
    }

    static var modelVersionHashModifier: String? {
        return nil
    }
}

