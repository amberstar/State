/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestDictionaryComposition : Model {
    public var employees: [String : Employee]

}

extension TestDictionaryComposition : Decodable {

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = TestDictionaryComposition.performMigrationIfNeeded(decoder)

        guard
            let employees: [String : Employee] = decoder.decodeModelDictionary("employees")
        else { return  nil }

        self.employees = employees
        didFinishDecodingWithDecoder(decoder)
    }
}

extension TestDictionaryComposition : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(employees, "employees")

        TestDictionaryComposition.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestDictionaryComposition {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<80c11a40 d9a760e9 bfcbb271 8b75d132 c3ac7b52 8d23b6f1 222b79ae b0e4c5f9>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

