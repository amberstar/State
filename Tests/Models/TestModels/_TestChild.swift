/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestChild : Model {
    public var age: Int?
    public var name: String?
    public var gender: Gender?
    public var myChildren: [Grandchild]?

public init(age: Int?, name: String?, gender: Gender?, myChildren: [Grandchild]?) {

    self.age = age
    self.name = name
    self.gender = gender
    self.myChildren = myChildren

    }
}

extension TestChild : Decodable {

    static func create(age: Int?)(name: String?)(gender: Gender?)(myChildren: [Grandchild]?) -> TestChild  {
        return TestChild(age: age, name: name, gender: gender, myChildren: myChildren)
    }

    public init?(var decoder: Decoder) {

    decoder = TestChild.performMigrationIfNeeded(decoder)

        let instance: TestChild? = TestChild.create
        <^> decoder.decode("age") >>> asOptional
        <*> decoder.decode("name") >>> asOptional
        <*> decoder.decodeModel("gender") >>> asOptional
        <*> decoder.decodeModelArray("myChildren") >>> asOptional

        if let i = instance {
            i.didFinishDecodingWithDecoder(decoder)
            self = i
        } else { return nil }
    }
}

extension TestChild : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(age, "age")
        encoder.encode(name, "name")
        encoder.encode(gender, "gender")
        encoder.encode(myChildren, "myChildren")

        TestChild.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestChild {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<4b2e27e5 53e329ff 69cfb4ba 1573537c 35d26944 7199acfc 729b6b5c c6e0ac88>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

