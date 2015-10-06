/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import STState

public struct TestProtocolContainter : Model {
    public var testProtocols: TestProtocol?

}

extension TestProtocolContainter : Decodable {

    public init?(var decoder: Decoder) {
        decoder = TestProtocolContainter.performMigrationIfNeeded(decoder)

        let testProtocols: TestProtocol? = decoder.decodeTestProtocol("testProtocols")

        self.testProtocols = testProtocols
        didFinishDecodingWithDecoder(decoder)
    }
}

extension TestProtocolContainter : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(testProtocols, "testProtocols")

        TestProtocolContainter.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestProtocolContainter {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<8337fd8b fd2235c6 08073375 65fa17dc b752c0ae e5e7ba56 2c6bf594 61e6f006>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

