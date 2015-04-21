/************************************************

            MACHINE GENERATED FILE

 ************************************************/

import Spot

public struct TestOverrideType {
    var myArrayOfString: [String]?
    var myURL: NSURL?

public init(myArrayOfString: [String]?, myURL: NSURL?) {

    self.myArrayOfString = myArrayOfString
    self.myURL = myURL

    }
}

extension TestOverrideType : Decodable {

    static func create(myArrayOfString: [String]?)(myURL: NSURL?) -> TestOverrideType  {

        return TestOverrideType(myArrayOfString: myArrayOfString, myURL: myURL)
    }
    public init?(decoder: Decoder) {
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

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension TestOverrideType {

    static var versionHash: NSData? {
        let hash: NSString = "<cd424c1c d3ddb650 a267a4e2 f4e681f9 69eccc7d 37cbb116 fe69fd11 feb570b5>"
        return hash.dataUsingEncoding(NSUTF8StringEncoding)
    }

    static var versionHashModifier: String? {
        return "1.0"
    }
}

