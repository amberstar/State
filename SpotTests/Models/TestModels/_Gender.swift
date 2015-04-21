/************************************************

            MACHINE GENERATED FILE

 ************************************************/

import Spot

public enum Gender: String {

    case Female = "Female"
    case Male = "Male"

}

extension Gender: Decodable {

    static func create(rawValue: String) -> Gender?{
        return Gender(rawValue: rawValue)
    }

    public init?(var decoder: Decoder) {

        if Gender.shouldMigrateIfNeeded {
            if let dataVersion: AnyObject = decoder.decode(Gender.versionKey) {
                if Gender.needsMigration(dataVersion) {
                   let migratedData = Gender.migrateDataForDecoding(decoder.extractData(), dataVersion: dataVersion)
                    decoder = Decoder(data: migratedData)
                }
            }
        }
        if let rawValue: String  = decoder.decode("value"),
            instance = Gender(rawValue: rawValue) {
            self = instance
        } else { return nil }
    }
}

extension Gender: Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(self.rawValue, forKey: "value")

        if Gender.shouldEncodeVersion {
                encoder.encode(Gender.version, forKey:Gender.versionKey)
        }
        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension Gender {
    /**
    These are provided from the data model designer
    and can be used to determine if the model is
    a different version.
    */
    static var modelVersionHash: String {
        return "<ffba7348 838d3758 c6b41d57 ad7ea1b5 7c0a7ae4 0a9ead14 a727496b e503f5c2>"
    }

    static var modelVersionHashModifier: String? {
        return nil
    }
}

