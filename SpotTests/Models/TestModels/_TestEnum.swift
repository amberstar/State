/************************************************

            MACHINE GENERATED FILE

 ************************************************/

import Spot

public enum TestEnum: String {

    case Aim = "Aim"
    case Fire = "Fire"
    case Ready = "Ready"

}

extension TestEnum: Decodable {

    static func create(rawValue: String) -> TestEnum?{
        return TestEnum(rawValue: rawValue)
    }

    public init?(decoder: Decoder) {
    if let rawValue: String  = decoder.decode("value"),
    instance = TestEnum(rawValue: rawValue) {
        self = instance
        } else { return nil }
    }
}

extension TestEnum: Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(self.rawValue, forKey: "value")
    }
}

extension TestEnum {

    static var versionHash: NSData? {
        let hash: NSString = "<b4993a9f c37c7861 174a6d31 52355952 e30939de e6a219c5 aaea0c6e 2096334c>"
        return hash.dataUsingEncoding(NSUTF8StringEncoding)
    }

    static var versionHashModifier: String? {
        return nil
    }
}

