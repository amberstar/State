/************************************************

            MACHINE GENERATED FILE

 ************************************************/

import Spot

public enum IssueStatus: Int {

    case Closed
    case Open = 1

}

extension IssueStatus: Decodable {

    static func create(rawValue: Int) -> IssueStatus?{
        return IssueStatus(rawValue: rawValue)
    }

    public init?(var decoder: Decoder) {

        if IssueStatus.shouldMigrateIfNeeded {
            if let dataVersion: AnyObject = decoder.decode(IssueStatus.versionKey) {
                if IssueStatus.needsMigration(dataVersion) {
                   let migratedData = IssueStatus.migrateDataForDecoding(decoder.extractData(), dataVersion: dataVersion)
                    decoder = Decoder(data: migratedData)
                }
            }
        }
        if let rawValue: Int  = decoder.decode("value"),
            instance = IssueStatus(rawValue: rawValue) {
            self = instance
        } else { return nil }
    }
}

extension IssueStatus: Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(self.rawValue, forKey: "value")

        if IssueStatus.shouldEncodeVersion {
                encoder.encode(IssueStatus.version, forKey:IssueStatus.versionKey)
        }
        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension IssueStatus {
    /**
    These are provided from the data model designer
    and can be used to determine if the model is
    a different version.
    */
    static var modelVersionHash: String {
        return "<64391713 e23559e4 cdec5aae b1036123 00715b80 dbb583b4 cee20b15 ce197385>"
    }

    static var modelVersionHashModifier: String? {
        return nil
    }
}

