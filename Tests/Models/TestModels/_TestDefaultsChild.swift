/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestDefaultsChild : Model {
    public var name = "New Child"

}

extension TestDefaultsChild : Decodable {

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = TestDefaultsChild.performMigrationIfNeeded(decoder)

guard
   let name: String = decoder.decode("name")
   else { return  nil }

        self.name = name
        didFinishDecodingWithDecoder(decoder)
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

