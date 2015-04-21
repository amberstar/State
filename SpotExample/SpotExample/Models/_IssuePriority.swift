/************************************************

            MACHINE GENERATED FILE

 ************************************************/

import Spot

public enum IssuePriority: String {

    case High = "High"
    case Low = "Low"

}

extension IssuePriority: Decodable {

    static func create(rawValue: String) -> IssuePriority?{
        return IssuePriority(rawValue: rawValue)
    }

    public init?(var decoder: Decoder) {

        if IssuePriority.shouldMigrateIfNeeded {
            if let dataVersion: AnyObject = decoder.decode(IssuePriority.versionKey) {
                if IssuePriority.needsMigration(dataVersion) {
                   let migratedData = IssuePriority.migrateDataForDecoding(decoder.extractData(), dataVersion: dataVersion)
                    decoder = Decoder(data: migratedData)
                }
            }
        }
        if let rawValue: String  = decoder.decode("value"),
            instance = IssuePriority(rawValue: rawValue) {
            self = instance
        } else { return nil }
    }
}

extension IssuePriority: Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(self.rawValue, forKey: "value")

        if IssuePriority.shouldEncodeVersion {
                encoder.encode(IssuePriority.version, forKey:IssuePriority.versionKey)
        }
        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension IssuePriority {
    /**
    These are provided from the data model designer
    and can be used to determine if the model is
    a different version.
    */
    static var modelVersionHash: String {
        return "<274b4d1b 2ad0ec1c 4453620f 13384b53 ea21e278 3f3a27d8 6c11c48b 2c139e0c>"
    }

    static var modelVersionHashModifier: String? {
        return nil
    }
}

