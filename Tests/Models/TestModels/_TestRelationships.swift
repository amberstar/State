/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestRelationships : Model {
    public var myChildren: [TestChild]?
    public var myGrandChildren: [Grandchild]?
    public var myOneChild: TestChild?

public init(myChildren: [TestChild]?, myGrandChildren: [Grandchild]?, myOneChild: TestChild?) {

    self.myChildren = myChildren
    self.myGrandChildren = myGrandChildren
    self.myOneChild = myOneChild

    }
}

extension TestRelationships : Decodable {

    static func create(myChildren: [TestChild]?)(myGrandChildren: [Grandchild]?)(myOneChild: TestChild?) -> TestRelationships  {
        return TestRelationships(myChildren: myChildren, myGrandChildren: myGrandChildren, myOneChild: myOneChild)
    }

    public init?(var decoder: Decoder) {

    decoder = TestRelationships.performMigrationIfNeeded(decoder)

        let instance: TestRelationships? = TestRelationships.create
        <^> decoder.decodeModelArray("myChildren") >>> asOptional
        <*> decoder.decodeModelArray("myGrandChildren") >>> asOptional
        <*> decoder.decodeModel("myOneChild") >>> asOptional

        if let i = instance {
            i.didFinishDecodingWithDecoder(decoder)
            self = i
        } else { return nil }
    }
}

extension TestRelationships : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(myChildren, "myChildren")
        encoder.encode(myGrandChildren, "myGrandChildren")
        encoder.encode(myOneChild, "myOneChild")

        TestRelationships.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestRelationships {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<4086c709 08537ea3 c28164b3 9e9cbdbf e9d83f02 72d9cd8f cd10f5c7 101fbcbb>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

