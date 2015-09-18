/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestOverrideType : Model {
    public var myURL: NSURL?
    public var myArrayOfString: [String]?

}

extension TestOverrideType : Decodable {

    public init?(var decoder: Decoder) {
        decoder = TestOverrideType.performMigrationIfNeeded(decoder)

        guard
            let myURL: NSURL? = decoder.decode("myURL"),
            let myArrayOfString: [String]? = decoder.decode("myArrayOfString")
        else { return  nil }

        self.myURL = myURL
        self.myArrayOfString = myArrayOfString
        didFinishDecodingWithDecoder(decoder)
    }
}

extension TestOverrideType : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(myURL, "myURL")
        encoder.encode(myArrayOfString, "myArrayOfString")

        TestOverrideType.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestOverrideType {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<1b2022d4 1d237610 f72665c6 67dea8a1 a68750de df8625c3 d9495017 916e62c6>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

