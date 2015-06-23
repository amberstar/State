/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct Grandchild {
    public var age: Int?
    public var name: String?
    public var gender: Gender?

public init(age: Int?, name: String?, gender: Gender?) {

    self.age = age
    self.name = name
    self.gender = gender

    }
}

extension Grandchild : Decodable {

    static func create(age: Int?)(name: String?)(gender: Gender?) -> Grandchild  {
        return Grandchild(age: age, name: name, gender: gender)
    }

    public init?(var decoder: Decoder) {

        if Grandchild.shouldMigrateIfNeeded {
            if let dataVersion: AnyObject = decoder.decode(Grandchild.versionKey) {
                if Grandchild.needsMigration(dataVersion) {
                   let migratedData = Grandchild.migrateDataForDecoding(decoder.extractData(), dataVersion: dataVersion)
                    decoder = Decoder(data: migratedData)
                }
            }
        }

        let instance: Grandchild? = Grandchild.create
        <^> decoder.decode("age") >>> asOptional
        <*> decoder.decode("name") >>> asOptional
        <*> decoder.decodeModel("gender") >>> asOptional

        if let i = instance {
            i.didFinishDecodingWithDecoder(decoder)
            self = i
        } else { return nil }
    }
}

extension Grandchild : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(self.age, forKey: "age")
        encoder.encode(self.name, forKey: "name")
        encoder.encode(self.gender, forKey: "gender")

        if Grandchild.shouldEncodeVersion {
encoder.encode(Grandchild.version(Grandchild.modelVersionHash, modelVersionHashModifier: Grandchild.modelVersionHashModifier), forKey:Grandchild.versionKey)
        }
        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension Grandchild {
    /**
    These are provided from the data model designer
    and can be used to determine if the model is
    a different version.
    */
    static var modelVersionHash: String {
        return "<10d8adcc 35a3ab52 8d11fa17 fbbdb083 23527533 29812594 823e8a17 8e1cb50d>"
    }

    static var modelVersionHashModifier: String? {
        return nil
    }
}

