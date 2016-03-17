/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestProtocolConformer : TestProtocol {
    public var age: Int?
    public var ss_number: String
    public var isReady: Bool?
    public var employee: Employee

    public var children: [TestChild]

}

extension TestProtocolConformer : Decodable {

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = TestProtocolConformer.performMigrationIfNeeded(decoder)

guard
   let ss_number: String = decoder.decode("ss_number"),
   let employee: Employee = decoder.decode("employee"),
   let children: [TestChild] = decoder.decode("children")
   else { return  nil }

        let age: Int? = decoder.decode("age")

        let isReady: Bool? = decoder.decode("isReady")

        self.age = age
        self.ss_number = ss_number
        self.isReady = isReady
        self.employee = employee
        self.children = children
        didFinishDecodingWithDecoder(decoder)
    }
}

extension TestProtocolConformer : Encodable {

    public func encode(e: Encoder) {
        var encoder = e
        encoder.encode(age, "age")
        encoder.encode(ss_number, "ss_number")
        encoder.encode(isReady, "isReady")
        encoder.encode(employee, "employee")
        encoder.encode(children, "children")

        encoder.encode("TestProtocolConformer", "TestParentProtocol")

        TestProtocolConformer.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestProtocolConformer {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<d32fcba3 281d4cc9 b37e5db7 913bf809 201719ca af7abe39 905ab5fe 694ab08b>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

