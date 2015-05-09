/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import Spot

public struct Employee {
    public var name: String
    public var title: String?

    public init(name: String, title: String?) {

    self.name = name
    self.title = title

    }
}

extension Employee : Decodable {

    static func create(name: String)(title: String?) -> Employee  {
        return Employee(name: name, title: title)
    }

    public init?(var decoder: Decoder) {

        if Employee.shouldMigrateIfNeeded {
            if let dataVersion: AnyObject = decoder.decode(Employee.versionKey) {
                if Employee.needsMigration(dataVersion) {
                   let migratedData = Employee.migrateDataForDecoding(decoder.extractData(), dataVersion: dataVersion)
                    decoder = Decoder(data: migratedData)
                }
            }
        }

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

        if Employee.shouldEncodeVersion {
encoder.encode(Employee.version(Employee.modelVersionHash, modelVersionHashModifier: Employee.modelVersionHashModifier), forKey:Employee.versionKey)
        }
        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension Employee {
    /**
    These are provided from the data model designer
    and can be used to determine if the model is
    a different version.
    */
    static var modelVersionHash: String {
        return "<a7d3395e 2571c3cc f97901e5 26580a8c a813984e e25ffdd4 40813f22 16357528>"
    }

    static var modelVersionHashModifier: String? {
        return nil
    }
}

