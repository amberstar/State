/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import Spot

public struct TestRelationships {
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

        if TestRelationships.shouldMigrateIfNeeded {
            if let dataVersion: AnyObject = decoder.decode(TestRelationships.versionKey) {
                if TestRelationships.needsMigration(dataVersion) {
                   let migratedData = TestRelationships.migrateDataForDecoding(decoder.extractData(), dataVersion: dataVersion)
                    decoder = Decoder(data: migratedData)
                }
            }
        }

        let instance: TestRelationships? = TestRelationships.create
        <*> decoder.decodeModelArray("myChildren") >>> asOptional
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
        encoder.encode(self.myChildren, forKey: "myChildren")
        encoder.encode(self.myGrandChildren, forKey: "myGrandChildren")
        encoder.encode(self.myOneChild, forKey: "myOneChild")

        if TestRelationships.shouldEncodeVersion {
                encoder.encode(TestRelationships.version, forKey:TestRelationships.versionKey)
        }
        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestRelationships {
    /**
    These are provided from the data model designer
    and can be used to determine if the model is
    a different version.
    */
    static var modelVersionHash: String {
        return "<4086c709 08537ea3 c28164b3 9e9cbdbf e9d83f02 72d9cd8f cd10f5c7 101fbcbb>"
    }

    static var modelVersionHashModifier: String? {
        return nil
    }
}

