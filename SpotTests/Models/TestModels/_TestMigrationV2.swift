/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import Spot

public struct TestMigrationV2 {
    public var age: Int?
    public var name: String

    public init(age: Int?, name: String) {

    self.age = age
    self.name = name

    }
}

extension TestMigrationV2 : Decodable {

    static func create(age: Int?)(name: String) -> TestMigrationV2  {
        return TestMigrationV2(age: age, name: name)
    }

    public init?(var decoder: Decoder) {

        if TestMigrationV2.shouldMigrateIfNeeded {
            if let dataVersion: AnyObject = decoder.decode(TestMigrationV2.versionKey) {
                if TestMigrationV2.needsMigration(dataVersion) {
                   let migratedData = TestMigrationV2.migrateDataForDecoding(decoder.extractData(), dataVersion: dataVersion)
                    decoder = Decoder(data: migratedData)
                }
            }
        }

        let instance: TestMigrationV2? = TestMigrationV2.create
        <^> decoder.decode("age") >>> asOptional
        <*> decoder.decode("name")

        if let i = instance {
            i.didFinishDecodingWithDecoder(decoder)
            self = i
        } else { return nil }
    }
}

extension TestMigrationV2 : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(self.age, forKey: "age")
        encoder.encode(self.name, forKey: "name")

        if TestMigrationV2.shouldEncodeVersion {
encoder.encode(TestMigrationV2.version(TestMigrationV2.modelVersionHash, modelVersionHashModifier: TestMigrationV2.modelVersionHashModifier), forKey:TestMigrationV2.versionKey)
        }
        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestMigrationV2 {
    /**
    These are provided from the data model designer
    and can be used to determine if the model is
    a different version.
    */
    static var modelVersionHash: String {
        return "<a72776b0 ed41d0ad 357dc213 d628b690 61fa4fa3 a91c4c0e 941122a8 c581023e>"
    }

    static var modelVersionHashModifier: String? {
        return "2.0"
    }
}

