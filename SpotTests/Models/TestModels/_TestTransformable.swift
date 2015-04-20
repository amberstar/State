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
        <^> URLTransform.reverseTransform(decoder.decode("myTransformable"))
        <*> URLTransform.reverseTransform(decoder.decode("myTransformableImmutable"))
        <*> Optional(URLTransform.reverseTransform(decoder.decode("myTransformableImmutableOptional")))
        <*> Optional(URLTransform.reverseTransform(decoder.decode("myTransformableOptional")))

        if let i = instance { self = i } else { return nil }
    }
}

extension TestTransformable : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(URLTransform.transform(self.myTransformable), forKey: "myTransformable")
        encoder.encode(URLTransform.transform(self.myTransformableImmutable), forKey: "myTransformableImmutable")
        encoder.encode(URLTransform.transform(self.myTransformableImmutableOptional), forKey: "myTransformableImmutableOptional")
        encoder.encode(URLTransform.transform(self.myTransformableOptional), forKey: "myTransformableOptional")

    }
}

