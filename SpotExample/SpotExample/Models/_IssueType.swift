/************************************************

            MACHINE GENERATED FILE

 ************************************************/

import Spot

public enum IssueType: String {

    case Bug = "Bug"
    case Feature = "Feature"
    case Task = "Task"

}

extension IssueType: Decodable {

    static func create(rawValue: String) -> IssueType?{
        return IssueType(rawValue: rawValue)
    }

    public init?(var decoder: Decoder) {

        if IssueType.shouldMigrateIfNeeded {
            if let dataVersion: AnyObject = decoder.decode(IssueType.versionKey) {
                if IssueType.needsMigration(dataVersion) {
                   let migratedData = IssueType.migrateDataForDecoding(decoder.extractData(), dataVersion: dataVersion)
                    decoder = Decoder(data: migratedData)
                }
            }
        }
        if let rawValue: String  = decoder.decode("value"),
            instance = IssueType(rawValue: rawValue) {
            self = instance
        } else { return nil }
    }
}

extension IssueType: Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(self.rawValue, forKey: "value")

        if IssueType.shouldEncodeVersion {
                encoder.encode(IssueType.version, forKey:IssueType.versionKey)
        }
        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension IssueType {
    /**
    These are provided from the data model designer
    and can be used to determine if the model is
    a different version.
    */
    static var modelVersionHash: String {
        return "<a1be1c70 d38d1def c77942ce 9beed201 6b256847 00088797 c0aadde6 f42be16a>"
    }

    static var modelVersionHashModifier: String? {
        return nil
    }
}

