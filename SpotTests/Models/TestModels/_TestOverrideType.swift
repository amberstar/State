/************************************************

            MACHINE GENERATED FILE

 ************************************************/

import Spot

public struct TestOverrideType {
    public var myArrayOfString: [String]?
    public var myURL: NSURL?

    public init(myArrayOfString: [String]?, myURL: NSURL?) {

    self.myArrayOfString = myArrayOfString
    self.myURL = myURL

    }
}

extension TestOverrideType : Decodable {

    static func create(myArrayOfString: [String]?)(myURL: NSURL?) -> TestOverrideType  {
        return TestOverrideType(myArrayOfString: myArrayOfString, myURL: myURL)
    }

    public init?(var decoder: Decoder) {

        if TestOverrideType.shouldMigrateIfNeeded {
            if let dataVersion: AnyObject = decoder.decode(TestOverrideType.versionKey) {
                if TestOverrideType.needsMigration(dataVersion) {
                   let migratedData = TestOverrideType.migrateDataForDecoding(decoder.extractData(), dataVersion: dataVersion)
                    decoder = Decoder(data: migratedData)
                }
            }
        }

        let instance: TestOverrideType? = TestOverrideType.create
        <^> decoder.decode("myArrayOfString") >>> asOptional
        <*> decoder.decode("myURL") >>> asOptional

        if let i = instance {
            i.didFinishDecodingWithDecoder(decoder)
            self = i
        } else { return nil }
    }
}

extension TestOverrideType : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(self.myArrayOfString, forKey: "myArrayOfString")
        encoder.encode(self.myURL, forKey: "myURL")

        if TestOverrideType.shouldEncodeVersion {
                encoder.encode(TestOverrideType.version, forKey:TestOverrideType.versionKey)
        }
        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestOverrideType {
    /**
    These are provided from the data model designer
    and can be used to determine if the model is
    a different version.
    */
    static var modelVersionHash: String {
        return "<1b2022d4 1d237610 f72665c6 67dea8a1 a68750de df8625c3 d9495017 916e62c6>"
    }

    static var modelVersionHashModifier: String? {
        return nil
    }
}

