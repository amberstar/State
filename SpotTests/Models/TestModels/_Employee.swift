/************************************************

            MACHINE GENERATED FILE

 ************************************************/

import Spot

public struct Employee {
    var name: String
    var title: String?

public init(name: String, title: String?) {

    self.name = name
    self.title = title

    }
}

extension Employee : Decodable {

    static func create(name: String)(title: String?) -> Employee  {

        return Employee(name: name, title: title)
    }
    public init?(decoder: Decoder) {
        let instance: Employee? = Employee.create
        <^> decoder.decode("name")
        <*> decoder.decode("title") >>> asOptional

        if let i = instance {
            i.didFinishDecodingWithDecoder(decoder)
            self = i
        } else { return nil }
    }
}

extension Employee : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(self.name, forKey: "name")
        encoder.encode(self.title, forKey: "title")

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension Employee {

    static var versionHash: NSData? {
        let hash: NSString = "<a7d3395e 2571c3cc f97901e5 26580a8c a813984e e25ffdd4 40813f22 16357528>"
        return hash.dataUsingEncoding(NSUTF8StringEncoding)
    }

    static var versionHashModifier: String? {
        return nil
    }
}

