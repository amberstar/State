/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestMigrationV2 : Model {
    public var age: Int?
    public var name: String

public init(age: Int?, name: String) {

    self.age = age
    self.name = name

    }
}

extension TestMigrationV2 : Decodable {

    static func create(age: Int?)(name: String) -> TestMigrationV2  {
        return TestMigrationV2(age: age, name: name)
    }

    public init?(var decoder: Decoder) {

    decoder = TestMigrationV2.performMigrationIfNeeded(decoder)

        let instance: TestMigrationV2? = TestMigrationV2.create
        <^> decoder.decode("age") >>> asOptional
        <*> decoder.decode("name")

        if let i = instance {
            i.didFinishDecodingWithDecoder(decoder)
            self = i
        } else { return nil }
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

