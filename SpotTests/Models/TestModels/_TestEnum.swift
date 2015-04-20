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

