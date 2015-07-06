/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestProtocolContainter : Model {
    public var amount: Double?
    public var conformers: TestProtocol

public init(amount: Double?, conformers: TestProtocol) {

    self.amount = amount
    self.conformers = conformers

    }
}

extension TestProtocolContainter : Decodable {

    static func create(amount: Double?)(conformers: TestProtocol) -> TestProtocolContainter  {
        return TestProtocolContainter(amount: amount, conformers: conformers)
    }

    public init?(var decoder: Decoder) {

    decoder = TestProtocolContainter.performMigrationIfNeeded(decoder)

        let instance: TestProtocolContainter? = TestProtocolContainter.create
        <^> decoder.decode("amount") >>> asOptional
        <*> (decoder.decodeModel("conformers") as TestProtocol)
        if let i = instance {
            i.didFinishDecodingWithDecoder(decoder)
            self = i
        } else { return nil }
    }
}

extension TestProtocolContainter : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(amount, "amount")
        encoder.encode(conformers, "conformers")

        TestProtocolContainter.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestProtocolContainter {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<24bbf388 4a1b7ca1 7d3fef02 10d00650 728a5989 272d014e a72cf19f 9dc0b42a>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

