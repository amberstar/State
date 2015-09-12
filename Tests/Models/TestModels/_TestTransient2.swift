/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestTransient2 : Model {
    public var transient2: Int?
    public var transient1: String?
    public var myNonTransient: Gender?

public init(myNonTransient: Gender?) {

    self.myNonTransient = myNonTransient

    }
}

extension TestTransient2 : Decodable {

    static func create(myNonTransient: Gender?) -> TestTransient2  {
        return TestTransient2(myNonTransient: myNonTransient)
    }

    public init?(var decoder: Decoder) {

    decoder = TestTransient2.performMigrationIfNeeded(decoder)

        let instance: TestTransient2? = TestTransient2.create

        <^> decoder.decodeModel("myNonTransient") >>> asOptional

        if let i = instance {
            i.didFinishDecodingWithDecoder(decoder)
            self = i
        } else { return nil }
    }
}

extension TestTransient2 : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(myNonTransient, "myNonTransient")

        TestTransient2.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestTransient2 {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<3bdb5dca 2d9104fe d8d34881 3d5e8518 763ba9eb 44d3c0b4 c57a65ec 1c4e4924>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

