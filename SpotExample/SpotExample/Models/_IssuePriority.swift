import Spot

/************************************************

            MACHINE GENERATED FILE

 ************************************************/

public enum IssuePriority: String {

    case high  = "High"
    case low  = "Low"

}

extension IssuePriority: Decodable {

    static func create(rawValue: String) -> IssuePriority?{
        return IssuePriority(rawValue: rawValue)
    }

    public init?(decoder: Decoder) {
    if let rawValue: String  = decoder.decode("value"),
    instance = IssuePriority(rawValue: rawValue) {
        self = instance
        } else { return nil }

          }
}

extension IssuePriority: Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(self.rawValue, forKey: "value")
    }
}

