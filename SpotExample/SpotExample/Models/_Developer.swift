import Spot

/************************************************

            MACHINE GENERATED FILE

 ************************************************/

public struct Developer {
    var name: String

    init(name: String) {

        self.name = name

    }
}

extension Developer : Decodable {

    static func create(name: String) -> Developer  {

        return Developer(name: name)
    }

    public init?(decoder: Decoder) {
        let instance: Developer? = Developer.create
        <^> decoder.decode("name")

        if let i = instance { self = i } else { return nil }
    }
}

extension Developer : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(self.name, forKey: "name")

    }
}

