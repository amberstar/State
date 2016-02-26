/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct Company : Model {
    public var name: String
    public var yearFounded: Double
    public var phoneNumber: String?
    public var employees: [Employee]?

}

extension Company : Decodable {

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = Company.performMigrationIfNeeded(decoder)

        guard
            let name: String = decoder.decode("name"),
            let yearFounded: Double = decoder.decode("yearFounded")
        else { return  nil }

        let phoneNumber: String? = decoder.decode("phoneNumber")
        let employees: [Employee]? = decoder.decodeModelArray("employees")

        self.name = name
        self.yearFounded = yearFounded
        self.phoneNumber = phoneNumber
        self.employees = employees
        didFinishDecodingWithDecoder(decoder)
    }
}

extension Company : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(name, "name")
        encoder.encode(yearFounded, "yearFounded")
        encoder.encode(phoneNumber, "phoneNumber")
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

