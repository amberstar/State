/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public enum TestRawEnum  : String, Model {

    case Aim  = "Aim"
    case Fire  = "Fire"
    case Ready  = "Ready"

}

extension TestRawEnum: Decodable {

    public init?(var decoder: Decoder) {

        decoder = TestRawEnum.performMigrationIfNeeded(decoder)

        if let type: String = decoder.decode("type") {

            switch type {
                case "Aim":
                    if let value: String = decoder.decode("value"),
                        instance = TestRawEnum(rawValue: value) {
                        instance.didFinishDecodingWithDecoder(decoder)
                        self = instance
                    } else { return nil }
                case "Fire":
                    if let value: String = decoder.decode("value"),
                        instance = TestRawEnum(rawValue: value) {
                        instance.didFinishDecodingWithDecoder(decoder)
                        self = instance
                    } else { return nil }
                case "Ready":
                    if let value: String = decoder.decode("value"),
                        instance = TestRawEnum(rawValue: value) {
                        instance.didFinishDecodingWithDecoder(decoder)
                        self = instance
                    } else { return nil }

                default:
                    return nil
            }
        } else { return nil }
    }
}

extension TestRawEnum: Encodable {

    public func encode(encoder: Encoder) {

        switch self {
            case  .Aim:
                encoder.encode("Aim", "type")
                encoder.encode(self.rawValue, "value")
            case  .Fire:
                encoder.encode("Fire", "type")
                encoder.encode(self.rawValue, "value")
            case  .Ready:
                encoder.encode("Ready", "type")
                encoder.encode(self.rawValue, "value")

        }

        TestRawEnum.encodeVersionIfNeeded(encoder)

         self.willFinishEncodingWithEncoder(encoder)
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
