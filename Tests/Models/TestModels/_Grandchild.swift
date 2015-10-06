/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import STState

public struct Grandchild : Model {
    public var age: Int?
    public var name: String?
    public var gender: Gender?

}

extension Grandchild : Decodable {

    public init?(var decoder: Decoder) {
        decoder = Grandchild.performMigrationIfNeeded(decoder)

        let age: Int? = decoder.decode("age")
        let name: String? = decoder.decode("name")
        let gender: Gender? = decoder.decodeModel("gender")

        self.age = age
        self.name = name
        self.gender = gender
        didFinishDecodingWithDecoder(decoder)
    }
}

extension Grandchild : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(age, "age")
        encoder.encode(name, "name")
        encoder.encode(gender, "gender")

        Grandchild.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension Grandchild {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<10d8adcc 35a3ab52 8d11fa17 fbbdb083 23527533 29812594 823e8a17 8e1cb50d>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

