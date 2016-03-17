/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestTransient : Model {
    public var myNonTransient: String
    public var myTransientOptional: Double?
    public var myTransientRelationship = Gender.Female

}

extension TestTransient : Decodable {

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = TestTransient.performMigrationIfNeeded(decoder)

guard
   let myNonTransient: String = decoder.decode("myNonTransient")
   else { return  nil }

        self.myNonTransient = myNonTransient
        didFinishDecodingWithDecoder(decoder)
    }
}

extension TestTransient : Encodable {

    public func encode(e: Encoder) {
        var encoder = e
        encoder.encode(myNonTransient, "myNonTransient")

        TestTransient.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestTransient {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<fb68fb70 311dfea6 b694df51 4fd77810 97ab74b7 37a7d6fb 6cad86c8 f6d15ca2>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

