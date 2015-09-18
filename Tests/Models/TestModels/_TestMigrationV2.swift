/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestMigrationV2 : Model {
    public var age: Int?
    public var name: String

}

extension TestMigrationV2 : Decodable {

    public init?(var decoder: Decoder) {
        decoder = TestMigrationV2.performMigrationIfNeeded(decoder)

        guard
            let age: Int? = decoder.decode("age"),
            let name: String = decoder.decode("name")
        else { return  nil }

        self.age = age
        self.name = name
        didFinishDecodingWithDecoder(decoder)
    }
}

extension TestMigrationV2 : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(age, "age")
        encoder.encode(name, "name")

        TestMigrationV2.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestMigrationV2 {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<a72776b0 ed41d0ad 357dc213 d628b690 61fa4fa3 a91c4c0e 941122a8 c581023e>"
    }

    public static func modelVersionHashModifier() -> String? {
        return "2.0"
    }
}

