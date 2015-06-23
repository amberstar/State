/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestCollections {
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

        if TestCollections.shouldMigrateIfNeeded {
            if let dataVersion: AnyObject = decoder.decode(TestCollections.versionKey) {
                if TestCollections.needsMigration(dataVersion) {
                   let migratedData = TestCollections.migrateDataForDecoding(decoder.extractData(), dataVersion: dataVersion)
                    decoder = Decoder(data: migratedData)
                }
            }
        }

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
        encoder.encode(self.arrayOfStrings, forKey: "arrayOfStrings")
        encoder.encode(self.dicOfInts, forKey: "dicOfInts")
        encoder.encode(self.setOfStrings, forKey: "setOfStrings")

        if TestCollections.shouldEncodeVersion {
encoder.encode(TestCollections.version(TestCollections.modelVersionHash, modelVersionHashModifier: TestCollections.modelVersionHashModifier), forKey:TestCollections.versionKey)
        }
        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestCollections {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    static var modelVersionHash: String {
        return "<313ca880 7b444092 cef097e8 0b29feb7 e70ab4b5 3b7298dc 4debc39c 90801887>"
    }

    static var modelVersionHashModifier: String? {
        return nil
    }
}

