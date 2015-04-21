/************************************************

            MACHINE GENERATED FILE

 ************************************************/

import Spot

public struct TestTransformable {
    var myTransformable: NSURL
    let myTransformableImmutable: NSURL
    let myTransformableImmutableOptional: NSURL?
    var myTransformableOptional: NSURL?

public init(myTransformable: NSURL, myTransformableImmutable: NSURL, myTransformableImmutableOptional: NSURL?, myTransformableOptional: NSURL?) {

    self.myTransformable = myTransformable
    self.myTransformableImmutable = myTransformableImmutable
    self.myTransformableImmutableOptional = myTransformableImmutableOptional
    self.myTransformableOptional = myTransformableOptional

    }
}

extension TestTransformable : Decodable {

    static func create(myTransformable: NSURL)(myTransformableImmutable: NSURL)(myTransformableImmutableOptional: NSURL?)(myTransformableOptional: NSURL?) -> TestTransformable  {

        return TestTransformable(myTransformable: myTransformable, myTransformableImmutable: myTransformableImmutable, myTransformableImmutableOptional: myTransformableImmutableOptional, myTransformableOptional: myTransformableOptional)
    }
    public init?(decoder: Decoder) {
        let instance: TestTransformable? = TestTransformable.create
        <^> decoder.decode("myTransformable") >>> URLTransform.reverseTransform
        <*> decoder.decode("myTransformableImmutable") >>> URLTransform.reverseTransform
        <*> decoder.decode("myTransformableImmutableOptional") >>> URLTransform.reverseTransform >>> asOptional
        <*> decoder.decode("myTransformableOptional") >>> URLTransform.reverseTransform >>> asOptional

        if let i = instance {
            i.didFinishDecodingWithDecoder(decoder)
            self = i
        } else { return nil }
    }
}

extension TestTransformable : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(URLTransform.transform(self.myTransformable), forKey: "myTransformable")
        encoder.encode(URLTransform.transform(self.myTransformableImmutable), forKey: "myTransformableImmutable")
        encoder.encode(URLTransform.transform(self.myTransformableImmutableOptional), forKey: "myTransformableImmutableOptional")
        encoder.encode(URLTransform.transform(self.myTransformableOptional), forKey: "myTransformableOptional")

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestTransformable {

    static var versionHash: NSData? {
        let hash: NSString = "<ab73b735 b1201428 cbab765c 5357fbe9 b413a176 90618f51 b3efae27 d31a5116>"
        return hash.dataUsingEncoding(NSUTF8StringEncoding)
    }

    static var versionHashModifier: String? {
        return nil
    }
}

