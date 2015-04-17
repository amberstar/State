import Spot

/************************************************

            MACHINE GENERATED FILE

 ************************************************/

public struct Product {
    var name: String?

    init(name: String?) {

        self.name = name

    }
}

extension Product : Decodable {

    static func create(name: String?) -> Product  {

        return Product(name: name)
    }

    public init?(decoder: Decoder) {
        let instance: Product? = Product.create
        <^> decoder.decodeOptional("name")

        if let i = instance { self = i } else { return nil }
    }
}

extension Product : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(self.name, forKey: "name")

    }
}

