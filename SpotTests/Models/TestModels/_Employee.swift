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
        <*> Optional(decoder.decode("title"))

        if let i = instance { self = i } else { return nil }
    }
}

extension Employee : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(self.name, forKey: "name")
        encoder.encode(self.title, forKey: "title")

    }
}

