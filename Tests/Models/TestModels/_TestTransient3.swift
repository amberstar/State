/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import STState

public struct TestTransient3 : Model {
    public var myNonTransient1: Double?
    public var myNonTransient2: String?
    public var myTransientRelationship: Gender?

}

extension TestTransient3 : Decodable {

    public init?(var decoder: Decoder) {
        decoder = TestTransient3.performMigrationIfNeeded(decoder)

        let myNonTransient1: Double? = decoder.decode("myNonTransient1")
        let myNonTransient2: String? = decoder.decode("myNonTransient2")

        self.myNonTransient1 = myNonTransient1
        self.myNonTransient2 = myNonTransient2
        didFinishDecodingWithDecoder(decoder)
    }
}

extension TestTransient3 : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(myNonTransient1, "myNonTransient1")
        encoder.encode(myNonTransient2, "myNonTransient2")

        TestTransient3.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestTransient3 {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<05b69b5d 1e7b7b56 3e25a035 1e39a111 32b6a4e5 35fd06b5 f81d5fe0 9fbcf182>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

