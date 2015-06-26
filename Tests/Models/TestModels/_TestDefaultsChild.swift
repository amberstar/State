/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestDefaultsChild : Model {
    public var name = "New Child"

public init(name: String) {

    self.name = name

    }
}

extension TestDefaultsChild : Decodable {

    static func create(name: String) -> TestDefaultsChild  {
        return TestDefaultsChild(name: name)
    }

    public init?(var decoder: Decoder) {

    decoder = TestDefaultsChild.performMigrationIfNeeded(decoder)

        let instance: TestDefaultsChild? = TestDefaultsChild.create
        <^> decoder.decode("name")

        if let i = instance {
            i.didFinishDecodingWithDecoder(decoder)
            self = i
        } else { return nil }
    }
}

extension TestDefaultsChild : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(name, "name")

        TestDefaultsChild.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestDefaultsChild {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<6b3afe9f ee54b7fc e944c82f 03ec6569 96cbe98a c3f4b991 13e91cf9 2abea4f9>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

