/************************************************

            MACHINE GENERATED FILE

 ************************************************/

import Spot

public struct TestDefaults {
    public var defaultArray = ["zero", "one", "two"]
    public var defaultEmptyArray = [String]()
    public var defaultInt = 10
    public var defaultManualString = "defaultManualString"
    public var defaultString = "defaultString"
    public var noDefaultInt: Int?
    public var noDefaultString: String?
    public var defaultChild = TestDefaultsChild()
    public var defaultChildren = [TestDefaultsChild]()
    public var noDefaultChild: TestDefaultsChild?
    public var noDefaultChildren: TestDefaultsChild?

    public init(defaultArray: [String], defaultEmptyArray: [String], defaultInt: Int, defaultManualString: String, defaultString: String, noDefaultInt: Int?, noDefaultString: String?, defaultChild: TestDefaultsChild, defaultChildren: [TestDefaultsChild], noDefaultChild: TestDefaultsChild?, noDefaultChildren: TestDefaultsChild?) {

    self.defaultArray = defaultArray
    self.defaultEmptyArray = defaultEmptyArray
    self.defaultInt = defaultInt
    self.defaultManualString = defaultManualString
    self.defaultString = defaultString
    self.noDefaultInt = noDefaultInt
    self.noDefaultString = noDefaultString
    self.defaultChild = defaultChild
    self.defaultChildren = defaultChildren
    self.noDefaultChild = noDefaultChild
    self.noDefaultChildren = noDefaultChildren

    }
}

extension TestDefaults : Decodable {

    static func create(defaultArray: [String])(defaultEmptyArray: [String])(defaultInt: Int)(defaultManualString: String)(defaultString: String)(noDefaultInt: Int?)(noDefaultString: String?)(defaultChild: TestDefaultsChild)(defaultChildren: [TestDefaultsChild])(noDefaultChild: TestDefaultsChild?)(noDefaultChildren: TestDefaultsChild?) -> TestDefaults  {
        return TestDefaults(defaultArray: defaultArray, defaultEmptyArray: defaultEmptyArray, defaultInt: defaultInt, defaultManualString: defaultManualString, defaultString: defaultString, noDefaultInt: noDefaultInt, noDefaultString: noDefaultString, defaultChild: defaultChild, defaultChildren: defaultChildren, noDefaultChild: noDefaultChild, noDefaultChildren: noDefaultChildren)
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
        <^> decoder.decode("defaultArray")
        <*> decoder.decode("defaultEmptyArray")
        <*> decoder.decode("defaultInt")
        <*> decoder.decode("defaultManualString")
        <*> decoder.decode("defaultString")
        <*> decoder.decode("noDefaultInt") >>> asOptional
        <*> decoder.decode("noDefaultString") >>> asOptional
        <*> decoder.decodeModel("defaultChild")
        <*> decoder.decodeModelArray("defaultChildren")
        <*> decoder.decodeModel("noDefaultChild") >>> asOptional
        <*> decoder.decodeModel("noDefaultChildren") >>> asOptional

        if let i = instance {
            i.didFinishDecodingWithDecoder(decoder)
            self = i
        } else { return nil }
    }
}

extension TestDefaults : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(self.defaultArray, forKey: "defaultArray")
        encoder.encode(self.defaultEmptyArray, forKey: "defaultEmptyArray")
        encoder.encode(self.defaultInt, forKey: "defaultInt")
        encoder.encode(self.defaultManualString, forKey: "defaultManualString")
        encoder.encode(self.defaultString, forKey: "defaultString")
        encoder.encode(self.noDefaultInt, forKey: "noDefaultInt")
        encoder.encode(self.noDefaultString, forKey: "noDefaultString")
        encoder.encode(self.defaultChild, forKey: "defaultChild")
        encoder.encode(self.defaultChildren, forKey: "defaultChildren")
        encoder.encode(self.noDefaultChild, forKey: "noDefaultChild")
        encoder.encode(self.noDefaultChildren, forKey: "noDefaultChildren")

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
        return "<0e8e50ed 18d24253 6a725634 c5478e08 df6549ca 70f50d04 adec849b 3e79bdfc>"
    }

    static var modelVersionHashModifier: String? {
        return nil
    }
}

