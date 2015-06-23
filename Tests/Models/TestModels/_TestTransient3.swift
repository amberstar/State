/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestTransient3 {
    public var myNonTransient1: Double?
    public var myNonTransient2: String?
    public var myTransientRelationship: Gender?

public init(myNonTransient1: Double?, myNonTransient2: String?) {

    self.myNonTransient1 = myNonTransient1
    self.myNonTransient2 = myNonTransient2

    }
}

extension TestTransient3 : Decodable {

    static func create(myNonTransient1: Double?)(myNonTransient2: String?) -> TestTransient3  {
        return TestTransient3(myNonTransient1: myNonTransient1, myNonTransient2: myNonTransient2)
    }

    public init?(var decoder: Decoder) {

        if TestTransient3.shouldMigrateIfNeeded {
            if let dataVersion: AnyObject = decoder.decode(TestTransient3.versionKey) {
                if TestTransient3.needsMigration(dataVersion) {
                   let migratedData = TestTransient3.migrateDataForDecoding(decoder.extractData(), dataVersion: dataVersion)
                    decoder = Decoder(data: migratedData)
                }
            }
        }

        let instance: TestTransient3? = TestTransient3.create
        <^> decoder.decode("myNonTransient1") >>> asOptional
        <*> decoder.decode("myNonTransient2") >>> asOptional

        if let i = instance {
            i.didFinishDecodingWithDecoder(decoder)
            self = i
        } else { return nil }
    }
}

extension TestTransient3 : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(self.myNonTransient1, forKey: "myNonTransient1")
        encoder.encode(self.myNonTransient2, forKey: "myNonTransient2")

        if TestTransient3.shouldEncodeVersion {
encoder.encode(TestTransient3.version(TestTransient3.modelVersionHash, modelVersionHashModifier: TestTransient3.modelVersionHashModifier), forKey:TestTransient3.versionKey)
        }
        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestTransient3 {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    static var modelVersionHash: String {
        return "<05b69b5d 1e7b7b56 3e25a035 1e39a111 32b6a4e5 35fd06b5 f81d5fe0 9fbcf182>"
    }

    static var modelVersionHashModifier: String? {
        return nil
    }
}

