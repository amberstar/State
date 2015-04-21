/************************************************

            MACHINE GENERATED FILE

 ************************************************/

import Spot

public struct Issues {
    var closedIssues: [Issue]
    var openIssues: [Issue]

public init(closedIssues: [Issue], openIssues: [Issue]) {

    self.closedIssues = closedIssues
    self.openIssues = openIssues

    }
}

extension Issues : Decodable {

    static func create(closedIssues: [Issue])(openIssues: [Issue]) -> Issues  {
        return Issues(closedIssues: closedIssues, openIssues: openIssues)
    }

    public init?(var decoder: Decoder) {

        if Issues.shouldMigrateIfNeeded {
            if let dataVersion: AnyObject = decoder.decode(Issues.versionKey) {
                if Issues.needsMigration(dataVersion) {
                   let migratedData = Issues.migrateDataForDecoding(decoder.extractData(), dataVersion: dataVersion)
                    decoder = Decoder(data: migratedData)
                }
            }
        }

        let instance: Issues? = Issues.create
        <*> decoder.decodeModelArray("closedIssues")
        <*> decoder.decodeModelArray("openIssues")

        if let i = instance {
            i.didFinishDecodingWithDecoder(decoder)
            self = i
        } else { return nil }
    }
}

extension Issues : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(self.closedIssues, forKey: "closedIssues")
        encoder.encode(self.openIssues, forKey: "openIssues")

        if Issues.shouldEncodeVersion {
                encoder.encode(Issues.version, forKey:Issues.versionKey)
        }
        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension Issues {
    /**
    These are provided from the data model designer
    and can be used to determine if the model is
    a different version.
    */
    static var modelVersionHash: String {
        return "<f823d45a 99524a06 2b268c7f 1eb5fdaf a309efcb 0db572a8 3d30475f 0876ab79>"
    }

    static var modelVersionHashModifier: String? {
        return nil
    }
}

