/************************************************

            MACHINE GENERATED FILE

 ************************************************/

import Spot

public enum TestRawEnum: String {
    case Aim  = "Aim"
    case Fire  = "Fire"
    case Ready  = "Ready"

}

extension TestRawEnum: Decodable {

    public init?(var decoder: Decoder) {

        if TestRawEnum.shouldMigrateIfNeeded {
            if let dataVersion: AnyObject = decoder.decode(TestRawEnum.versionKey) {
                if TestRawEnum.needsMigration(dataVersion) {
                   let migratedData = TestRawEnum.migrateDataForDecoding(decoder.extractData(), dataVersion: dataVersion)
                    decoder = Decoder(data: migratedData)
                }
            }
        }

        if let type: String = decoder.decode("type") {

            switch type {
                case "aim":
                    if let value: String = decoder.decode("value"),
                        instance = TestRawEnum(rawValue: value) {
                        instance.didFinishDecodingWithDecoder(decoder)
                        self = instance
                    } else { return nil }
                case "fire":
                    if let value: String = decoder.decode("value"),
                        instance = TestRawEnum(rawValue: value) {
                        instance.didFinishDecodingWithDecoder(decoder)
                        self = instance
                    } else { return nil }
                case "ready":
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
            case let .Aim:
                encoder.encode("aim", forKey: "type")
                encoder.encode(self.rawValue, forKey: "value")
            case let .Fire:
                encoder.encode("fire", forKey: "type")
                encoder.encode(self.rawValue, forKey: "value")
            case let .Ready:
                encoder.encode("ready", forKey: "type")
                encoder.encode(self.rawValue, forKey: "value")

        }
         self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestRawEnum {
    /**
    These are provided from the data model designer
    and can be used to determine if the model is
    a different version.
    */
    static var modelVersionHash: String {
        return "<4a42ad80 0164503c a7c17d8c 2a24bcf5 f44a5730 0fab6252 969f7b23 e3ff6822>"
    }

    static var modelVersionHashModifier: String? {
        return nil
    }
}

