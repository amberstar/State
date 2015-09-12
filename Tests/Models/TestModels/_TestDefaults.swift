/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct TestDefaults : Model {
    public var defaultManualString = "defaultManualString"
    public var defaultArray = ["zero", "one", "two"]
    public var defaultString = "defaultString"
    public var noDefaultInt: Int?
    public var defaultInt = 10
    public var noDefaultString: String?
    public var defaultEmptyArray = [String]()
    public var defaultChildren = [TestDefaultsChild]()
    public var defaultChild = TestDefaultsChild()
    public var noDefaultChild: TestDefaultsChild?
    public var noDefaultChildren: TestDefaultsChild?

public init(defaultManualString: String, defaultArray: [String], defaultString: String, noDefaultInt: Int?, defaultInt: Int, noDefaultString: String?, defaultEmptyArray: [String], defaultChildren: [TestDefaultsChild], defaultChild: TestDefaultsChild, noDefaultChild: TestDefaultsChild?, noDefaultChildren: TestDefaultsChild?) {

    self.defaultManualString = defaultManualString
    self.defaultArray = defaultArray
    self.defaultString = defaultString
    self.noDefaultInt = noDefaultInt
    self.defaultInt = defaultInt
    self.noDefaultString = noDefaultString
    self.defaultEmptyArray = defaultEmptyArray
    self.defaultChildren = defaultChildren
    self.defaultChild = defaultChild
    self.noDefaultChild = noDefaultChild
    self.noDefaultChildren = noDefaultChildren

    }
}

extension TestDefaults : Decodable {

    static func create(defaultManualString: String)(defaultArray: [String])(defaultString: String)(noDefaultInt: Int?)(defaultInt: Int)(noDefaultString: String?)(defaultEmptyArray: [String])(defaultChildren: [TestDefaultsChild])(defaultChild: TestDefaultsChild)(noDefaultChild: TestDefaultsChild?)(noDefaultChildren: TestDefaultsChild?) -> TestDefaults  {
        return TestDefaults(defaultManualString: defaultManualString, defaultArray: defaultArray, defaultString: defaultString, noDefaultInt: noDefaultInt, defaultInt: defaultInt, noDefaultString: noDefaultString, defaultEmptyArray: defaultEmptyArray, defaultChildren: defaultChildren, defaultChild: defaultChild, noDefaultChild: noDefaultChild, noDefaultChildren: noDefaultChildren)
    }

    public init?(var decoder: Decoder) {

    decoder = TestDefaults.performMigrationIfNeeded(decoder)

        let instance: TestDefaults? = TestDefaults.create
        <^> decoder.decode("defaultManualString")
        <*> decoder.decode("defaultArray")
        <*> decoder.decode("defaultString")
        <*> decoder.decode("noDefaultInt") >>> asOptional
        <*> decoder.decode("defaultInt")
        <*> decoder.decode("noDefaultString") >>> asOptional
        <*> decoder.decode("defaultEmptyArray")
        <*> decoder.decodeModelArray("defaultChildren")
        <*> decoder.decodeModel("defaultChild")
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
        encoder.encode(defaultManualString, "defaultManualString")
        encoder.encode(defaultArray, "defaultArray")
        encoder.encode(defaultString, "defaultString")
        encoder.encode(noDefaultInt, "noDefaultInt")
        encoder.encode(defaultInt, "defaultInt")
        encoder.encode(noDefaultString, "noDefaultString")
        encoder.encode(defaultEmptyArray, "defaultEmptyArray")
        encoder.encode(defaultChildren, "defaultChildren")
        encoder.encode(defaultChild, "defaultChild")
        encoder.encode(noDefaultChild, "noDefaultChild")
        encoder.encode(noDefaultChildren, "noDefaultChildren")

        TestDefaults.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestDefaults {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<0e8e50ed 18d24253 6a725634 c5478e08 df6549ca 70f50d04 adec849b 3e79bdfc>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

