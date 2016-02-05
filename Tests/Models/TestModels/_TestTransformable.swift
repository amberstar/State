/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestTransformable : Model {
    public var myTransformable: NSURL
    public let myTransformableImmutable: NSURL
    public let myTransformableImmutableOptional: NSURL?
    public var myTransformableOptional: NSURL?

}

extension TestTransformable : Decodable {

    public init?(var decoder: Decoder) {
        decoder = TestTransformable.performMigrationIfNeeded(decoder)

        guard
            let myTransformable: NSURL = URLTransform.reverse(decoder.decode("myTransformable")),
            let myTransformableImmutable: NSURL = URLTransform.reverse(decoder.decode("myTransformableImmutable"))
        else { return  nil }

        let myTransformableImmutableOptional: NSURL? = URLTransform.reverse(decoder.decode("myTransformableImmutableOptional"))
        let myTransformableOptional: NSURL? = URLTransform.reverse(decoder.decode("myTransformableOptional"))

        self.myTransformable = myTransformable
        self.myTransformableImmutable = myTransformableImmutable
        self.myTransformableImmutableOptional = myTransformableImmutableOptional
        self.myTransformableOptional = myTransformableOptional
        didFinishDecodingWithDecoder(decoder)
    }
}

extension TestTransformable : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(myTransformable >>> URLTransform.apply, "myTransformable")
        encoder.encode(myTransformableImmutable >>> URLTransform.apply, "myTransformableImmutable")
        encoder.encode(myTransformableImmutableOptional >>> URLTransform.apply, "myTransformableImmutableOptional")
        encoder.encode(myTransformableOptional >>> URLTransform.apply, "myTransformableOptional")

        TestTransformable.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestTransformable {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<ab73b735 b1201428 cbab765c 5357fbe9 b413a176 90618f51 b3efae27 d31a5116>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

