/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestCollections : Model {
    public var arrayOfStrings: [String]
    public var dicOfInts: [String : Int]
    public var setOfStrings: Set<String>

public init(arrayOfStrings: [String], dicOfInts: [String : Int], setOfStrings: Set<String>) {

    self.arrayOfStrings = arrayOfStrings
    self.dicOfInts = dicOfInts
    self.setOfStrings = setOfStrings

    }
}

extension TestCollections : Decodable {

    static func create(arrayOfStrings: [String])(dicOfInts: [String : Int])(setOfStrings: Set<String>) -> TestCollections  {
        return TestCollections(arrayOfStrings: arrayOfStrings, dicOfInts: dicOfInts, setOfStrings: setOfStrings)
    }

    public init?(var decoder: Decoder) {

    decoder = TestCollections.performMigrationIfNeeded(decoder)

        let instance: TestCollections? = TestCollections.create
        <^> decoder.decode("arrayOfStrings")
        <*> decoder.decode("dicOfInts")
        <*> decoder.decode("setOfStrings")

        if let i = instance {
            i.didFinishDecodingWithDecoder(decoder)
            self = i
        } else { return nil }
    }
}

extension TestCollections : Encodable {

    public func encode(encoder: Encoder) {
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

