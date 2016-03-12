/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestCollections : Model {
    public var arrayOfStrings: [String]
    public var dicOfInts: [String : Int]
    public var setOfStrings: Set<String>

}

extension TestCollections : Decodable {

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = TestCollections.performMigrationIfNeeded(decoder)

        guard
            let arrayOfStrings: [String] = decoder.decode("arrayOfStrings"),
            let dicOfInts: [String : Int] = decoder.decode("dicOfInts"),
            let setOfStrings: Set<String> = decoder.decode("setOfStrings")
        else { return  nil }

        self.arrayOfStrings = arrayOfStrings
        self.dicOfInts = dicOfInts
        self.setOfStrings = setOfStrings
        didFinishDecodingWithDecoder(decoder)
    }
}

extension TestCollections : Encodable {

    public func encode(e: Encoder) {
        var encoder = e
        encoder.encode(arrayOfStrings, "arrayOfStrings")
        encoder.encode(dicOfInts, "dicOfInts")
        encoder.encode(setOfStrings, "setOfStrings")

        TestCollections.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestCollections {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<313ca880 7b444092 cef097e8 0b29feb7 e70ab4b5 3b7298dc 4debc39c 90801887>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

