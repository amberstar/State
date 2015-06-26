/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestTransient : Model {
    public var myNonTransient: String
    public var myTransientOptional: Double?
    public var myTransientRelationship = Gender.Female

public init(myNonTransient: String) {

    self.myNonTransient = myNonTransient

    }
}

extension TestTransient : Decodable {

    static func create(myNonTransient: String) -> TestTransient  {
        return TestTransient(myNonTransient: myNonTransient)
    }

    public init?(var decoder: Decoder) {

    decoder = TestTransient.performMigrationIfNeeded(decoder)

        let instance: TestTransient? = TestTransient.create
        <^> decoder.decode("myNonTransient")

        if let i = instance {
            i.didFinishDecodingWithDecoder(decoder)
            self = i
        } else { return nil }
    }
}

extension TestTransient : Encodable {

    public func encode(encoder: Encoder) {
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

