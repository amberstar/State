/************************************************

            MACHINE GENERATED FILE

 ************************************************/

import Spot

public struct Product {
    var name: String?

public init(name: String?) {

    self.name = name

    }
}

extension Product : Decodable {

    static func create(name: String?) -> Product  {
        return Product(name: name)
    }

    public init?(var decoder: Decoder) {

        if Product.shouldMigrateIfNeeded {
            if let dataVersion: AnyObject = decoder.decode(Product.versionKey) {
                if Product.needsMigration(dataVersion) {
                   let migratedData = Product.migrateDataForDecoding(decoder.extractData(), dataVersion: dataVersion)
                    decoder = Decoder(data: migratedData)
                }
            }
        }

        let instance: Product? = Product.create
        <^> decoder.decode("name") >>> asOptional

        if let i = instance {
            i.didFinishDecodingWithDecoder(decoder)
            self = i
        } else { return nil }
    }
}

extension Product : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(self.name, forKey: "name")

        if Product.shouldEncodeVersion {
                encoder.encode(Product.version, forKey:Product.versionKey)
        }
        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension Product {
    /**
    These are provided from the data model designer
    and can be used to determine if the model is
    a different version.
    */
    static var modelVersionHash: String {
        return "<0e1c6b3e 28775162 3d41f6cb 45eff639 01b09dbb c01ee74d 981bd539 728a4f61>"
    }

    static var modelVersionHashModifier: String? {
        return nil
    }
}

