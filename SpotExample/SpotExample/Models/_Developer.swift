/************************************************

            MACHINE GENERATED FILE

 ************************************************/

import Spot

public struct Developer {
    var name: String

public init(name: String) {

    self.name = name

    }
}

extension Developer : Decodable {

    static func create(name: String) -> Developer  {
        return Developer(name: name)
    }

    public init?(var decoder: Decoder) {

        if Developer.shouldMigrateIfNeeded {
            if let dataVersion: AnyObject = decoder.decode(Developer.versionKey) {
                if Developer.needsMigration(dataVersion) {
                   let migratedData = Developer.migrateDataForDecoding(decoder.extractData(), dataVersion: dataVersion)
                    decoder = Decoder(data: migratedData)
                }
            }
        }

        let instance: Developer? = Developer.create
        <^> decoder.decode("name")

        if let i = instance {
            i.didFinishDecodingWithDecoder(decoder)
            self = i
        } else { return nil }
    }
}

extension Developer : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(self.name, forKey: "name")

        if Developer.shouldEncodeVersion {
                encoder.encode(Developer.version, forKey:Developer.versionKey)
        }
        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension Developer {
    /**
    These are provided from the data model designer
    and can be used to determine if the model is
    a different version.
    */
    static var modelVersionHash: String {
        return "<ceb81b44 9b295c6e 48c0d66d 430eb5b8 70441d11 9fbd79a6 4a30d966 365fb82d>"
    }

    static var modelVersionHashModifier: String? {
        return nil
    }
}

