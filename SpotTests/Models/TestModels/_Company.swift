import Spot

/************************************************

            MACHINE GENERATED FILE

 ************************************************/

public struct Company {
var name: String
    var phoneNumber: String?
    var yearFounded: Double
    var employees: [Employee]?

    init(name: String, phoneNumber: String?, yearFounded: Double, employees: [Employee]?) {

        self.name = name
        self.phoneNumber = phoneNumber
        self.yearFounded = yearFounded
        self.employees = employees

    }
}

extension Company : Decodable {

    static func create(name: String)(phoneNumber: String?)(yearFounded: Double)(employees: [Employee]?) -> Company  {

        return Company(name: name, phoneNumber: phoneNumber, yearFounded: yearFounded, employees: employees)
    }

    public init?(decoder: Decoder) {
        let instance: Company? = Company.create
        <^> decoder.decode("name")
        <*> decoder.decodeOptional("phoneNumber")
        <*> decoder.decode("yearFounded")
        <*> decoder.decodeOptionalObjectArray("employees")

        if let i = instance { self = i } else { return nil }
    }
}

extension Company : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(self.name, forKey: "name")
        encoder.encode(self.phoneNumber, forKey: "phoneNumber")
        encoder.encode(self.yearFounded, forKey: "yearFounded")
        encoder.encode(self.employees, forKey: "employees")

    }
}

