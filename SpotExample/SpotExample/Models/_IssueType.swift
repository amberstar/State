import Spot

/************************************************

            MACHINE GENERATED FILE

 ************************************************/

public enum IssueType: String {

    case bug  = "bug"
    case feature  = "feature"
    case task  = "task"

}

extension IssueType: Decodable {

    static func create(rawValue: String) -> IssueType?{
        return IssueType(rawValue: rawValue)
    }

    public init?(decoder: Decoder) {
    if let rawValue: String  = decoder.decode("value"),
    instance = IssueType(rawValue: rawValue) {
        self = instance
        } else { return nil }

          }
}

extension IssueType: Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(self.rawValue, forKey: "value")
    }
}

