/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct Company : Model {
    public var name: String
    public var phoneNumber: String?
    public var yearFounded: Double
    public var employees: [Employee]?

public init(name: String, phoneNumber: String?, yearFounded: Double, employees: [Employee]?) {

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

    public init?(var decoder: Decoder) {

    decoder = Company.performMigrationIfNeeded(decoder)

        let instance: Company? = Company.create
        <^> decoder.decode("name")
        <*> decoder.decode("phoneNumber") >>> asOptional
        <*> decoder.decode("yearFounded")
        <*> decoder.decodeModelArray("employees") >>> asOptional

        if let i = instance {
            i.didFinishDecodingWithDecoder(decoder)
            self = i
        } else { return nil }
    }
}

extension Company : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(name, "name")
        encoder.encode(phoneNumber, "phoneNumber")
        encoder.encode(yearFounded, "yearFounded")
        encoder.encode(employees, "employees")

        Company.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension Company {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<96a6f843 e4004fa9 5be7cca8 25260494 31324f8c 67a0643f 53096004 e1f9e4f0>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

