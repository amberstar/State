/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public enum TestRegEnum {
    case Cold 
    case Hot

}

extension TestRegEnum: Decodable {

    public init?(var decoder: Decoder) {

        if TestRegEnum.shouldMigrateIfNeeded {
            if let dataVersion: AnyObject = decoder.decode(TestRegEnum.versionKey) {
                if TestRegEnum.needsMigration(dataVersion) {
                   let migratedData = TestRegEnum.migrateDataForDecoding(decoder.extractData(), dataVersion: dataVersion)
                    decoder = Decoder(data: migratedData)
                }
            }
        }

        if let type: String = decoder.decode("type") {

            switch type {
                case "Cold":
                    self = TestRegEnum.Cold
                case "Hot":
                    self = TestRegEnum.Hot

                default:
                    return nil
            }
        } else { return nil }
    }
}

extension TestRegEnum: Encodable {

    public func encode(encoder: Encoder) {

        switch self {
            case .Cold:
                encoder.encode("Cold", "type")
            case .Hot:
                encoder.encode("Hot", "type")

        }
         self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestRegEnum {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    static var modelVersionHash: String {
        return "<a3ed22fb 5deb7f55 1bee0f09 d897dfba 9f6b506f da233147 ba5d0c7b 67981e5c>"
    }

    static var modelVersionHashModifier: String? {
        return nil
    }
}

