/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestTransient2 {
    public var transient1: String?
    public var transient2: Int?
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

        if TestTransient2.shouldMigrateIfNeeded {
            if let dataVersion: AnyObject = decoder.decode(TestTransient2.versionKey) {
                if TestTransient2.needsMigration(dataVersion) {
                   let migratedData = TestTransient2.migrateDataForDecoding(decoder.extractData(), dataVersion: dataVersion)
                    decoder = Decoder(data: migratedData)
                }
            }
        }

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
        encoder.encode(self.myNonTransient, forKey: "myNonTransient")

        if TestTransient2.shouldEncodeVersion {
encoder.encode(TestTransient2.version(TestTransient2.modelVersionHash, modelVersionHashModifier: TestTransient2.modelVersionHashModifier), forKey:TestTransient2.versionKey)
        }
        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestTransient2 {
    /**
    These are provided from the data model designer
    and can be used to determine if the model is
    a different version.
    */
    static var modelVersionHash: String {
        return "<3bdb5dca 2d9104fe d8d34881 3d5e8518 763ba9eb 44d3c0b4 c57a65ec 1c4e4924>"
    }

    static var modelVersionHashModifier: String? {
        return nil
    }
}

