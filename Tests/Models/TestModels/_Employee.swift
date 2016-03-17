/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct Employee : Model {
    public var name: String
    public var title: String?

}

extension Employee : Decodable {

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = Employee.performMigrationIfNeeded(decoder)

guard
   let name: String = decoder.decode("name")
   else { return  nil }

        let title: String? = decoder.decode("title")

        self.name = name
        self.title = title
        didFinishDecodingWithDecoder(decoder)
    }
}

extension Employee : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(name, "name")
        encoder.encode(title, "title")

        Employee.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension Employee {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<a7d3395e 2571c3cc f97901e5 26580a8c a813984e e25ffdd4 40813f22 16357528>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

