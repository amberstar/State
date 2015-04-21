/************************************************

            MACHINE GENERATED FILE

 ************************************************/

import Spot

public struct TestCollections {
    var arrayOfStrings: [String]
    var dicOfInts: [String : Int]
    var setOfStrings: Set<String>

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
    public init?(decoder: Decoder) {
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

        self.willFinishEncodingWithEncoder(encoder)
    }
}

