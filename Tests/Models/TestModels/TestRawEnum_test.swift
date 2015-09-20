/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public enum TestRawEnum2  : String, Model {

    case Aim  = "Aim"
    case Fire  = "Fire"
    case Ready  = "Ready"

}

extension TestRawEnum2: Decodable {

    public init?( decoder: Decoder) {
        guard let value: String = decoder.decode("value") else { return nil }
        self.init(rawValue: value)
    }
}

extension TestRawEnum2: Encodable {

    public func encode(encoder: Encoder) {
         encoder.encode(self.rawValue, "value")
        
        TestRawEnum2.encodeVersionIfNeeded(encoder)

        
    }
}

extension TestRawEnum2 {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<4a42ad80 0164503c a7c17d8c 2a24bcf5 f44a5730 0fab6252 969f7b23 e3ff6822>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}
