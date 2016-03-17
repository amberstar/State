/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestProtocolContainter : Model {
    public var testProtocol: TestProtocol
    public var testProtocols: [TestParentProtocol]
    public var testProtocolsDict: [String : TestParentProtocol]

}

extension TestProtocolContainter : Decodable {

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = TestProtocolContainter.performMigrationIfNeeded(decoder)

guard
   let testProtocol: TestProtocol = decoder.decodeTestProtocol("testProtocol"),
   let testProtocols: [TestParentProtocol] = decoder.decodeTestParentProtocol("testProtocols"),
   let testProtocolsDict: [String : TestParentProtocol] = decoder.decodeTestParentProtocol("testProtocolsDict")
   else { return  nil }

        self.testProtocol = testProtocol
        self.testProtocols = testProtocols
        self.testProtocolsDict = testProtocolsDict
        didFinishDecodingWithDecoder(decoder)
    }
}

extension TestProtocolContainter : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(testProtocol, "testProtocol")
        encoder.encode(testProtocols, "testProtocols")
        encoder.encode(testProtocolsDict, "testProtocolsDict")

        TestProtocolContainter.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestProtocolContainter {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<c17d56f9 43a9a5b4 345e3428 ed93f4be ca40e0e9 976d037a 6ad6110c db0ae714>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

