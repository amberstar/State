/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestProtocolConformer : TestProtocol {
    public var age: Int?
    public var ss_number: String
    public var isReady: Bool?
    public let name: String
    public var employee: Employee
    public let grandchild: Grandchild
    public var children: [TestChild]

public init(age: Int?, ss_number: String, isReady: Bool?, name: String, employee: Employee, grandchild: Grandchild, children: [TestChild]) {

    self.age = age
    self.ss_number = ss_number
    self.isReady = isReady
    self.name = name
    self.employee = employee
    self.grandchild = grandchild
    self.children = children

    }
}

extension TestProtocolConformer : Decodable {

    static func create(age: Int?)(ss_number: String)(isReady: Bool?)(name: String)(employee: Employee)(grandchild: Grandchild)(children: [TestChild]) -> TestProtocolConformer  {
        return TestProtocolConformer(age: age, ss_number: ss_number, isReady: isReady, name: name, employee: employee, grandchild: grandchild, children: children)
    }

    public init?(var decoder: Decoder) {

    decoder = TestProtocolConformer.performMigrationIfNeeded(decoder)

        let instance: TestProtocolConformer? = TestProtocolConformer.create
        <^> decoder.decode("age") >>> asOptional
        <*> decoder.decode("ss_number")
        <*> decoder.decode("isReady") >>> asOptional
        <*> decoder.decode("name")
        <*> decoder.decodeModel("employee")
        <*> decoder.decodeModel("grandchild")
        <*> decoder.decodeModelArray("children")

        if let i = instance {
            i.didFinishDecodingWithDecoder(decoder)
            self = i
        } else { return nil }
    }
}

extension TestProtocolConformer : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(age, "age")
        encoder.encode(ss_number, "ss_number")
        encoder.encode(isReady, "isReady")
        encoder.encode(name, "name")
        encoder.encode(employee, "employee")
        encoder.encode(grandchild, "grandchild")
        encoder.encode(children, "children")

        TestProtocolConformer.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestProtocolConformer {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<966cf016 9867ea5c 9010a157 7aac4fde b0b6d69f ab1e1461 9aff2c52 2fd1db7f>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

