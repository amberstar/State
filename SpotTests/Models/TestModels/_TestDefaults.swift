/************************************************

            MACHINE GENERATED FILE

 ************************************************/

import Spot

public struct TestDefaults {
    public var defaultString: String

    public init(defaultString: String) {

    self.defaultString = defaultString

    }
}

extension TestDefaults : Decodable {

    static func create(defaultString: String) -> TestDefaults  {
        return TestDefaults(defaultString: defaultString)
    }

    public init?(var decoder: Decoder) {

        if TestDefaults.shouldMigrateIfNeeded {
            if let dataVersion: AnyObject = decoder.decode(TestDefaults.versionKey) {
                if TestDefaults.needsMigration(dataVersion) {
                   let migratedData = TestDefaults.migrateDataForDecoding(decoder.extractData(), dataVersion: dataVersion)
                    decoder = Decoder(data: migratedData)
                }
            }
        }

        let instance: TestDefaults? = TestDefaults.create
        <^> decoder.decode("defaultString")

        if let i = instance {
            i.didFinishDecodingWithDecoder(decoder)
            self = i
        } else { return nil }
    }
}

extension TestDefaults : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(self.defaultString, forKey: "defaultString")

        if TestDefaults.shouldEncodeVersion {
                encoder.encode(TestDefaults.version, forKey:TestDefaults.versionKey)
        }
        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestDefaults {
    /**
    These are provided from the data model designer
    and can be used to determine if the model is
    a different version.
    */
    static var modelVersionHash: String {
        return "<8dabcce9 da124e86 39475c4b 70999373 7ccf8435 adcb9933 1531d212 1e7e251f>"
    }

    static var modelVersionHashModifier: String? {
        return nil
    }
}

