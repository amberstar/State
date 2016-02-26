/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public enum TestRegEnum  : Model {

    case Cold 
    case Hot

}

extension TestRegEnum: Decodable {

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = TestRegEnum.performMigrationIfNeeded(decoder)

        guard let type: String = decoder.decode("TestRegEnum") else { return nil }
        switch type {
                case "Cold":
                   self = TestRegEnum.Cold
                case "Hot":
                   self = TestRegEnum.Hot

                default:
                    return nil
        }

    }
}

extension TestRegEnum: Encodable {

    public func encode(encoder: Encoder) {

        switch self {
            case .Cold:
                encoder.encode("Cold", "TestRegEnum")
            case .Hot:
                encoder.encode("Hot", "TestRegEnum")

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
