/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestProtocolConformer2 : TestParentProtocol {
    public var name: String
    public var ss_number: String

}

extension TestProtocolConformer2 : Decodable {

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = TestProtocolConformer2.performMigrationIfNeeded(decoder)

guard
   let name: String = decoder.decode("name"),
   let ss_number: String = decoder.decode("ss_number")
   else { return  nil }

        self.name = name
        self.ss_number = ss_number
        didFinishDecodingWithDecoder(decoder)
    }
}

extension TestProtocolConformer2 : Encodable {

    public func encode(e: Encoder) {
        var encoder = e
        encoder.encode(name, "name")
        encoder.encode(ss_number, "ss_number")

        encoder.encode("TestProtocolConformer2", "TestParentProtocol")

        TestProtocolConformer2.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestProtocolConformer2 {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<b03219a4 91869ac1 514d01f7 d3a1fca3 a52a8792 70710403 99f3e557 9da2f273>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

