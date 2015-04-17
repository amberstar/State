import Spot

/************************************************

            MACHINE GENERATED FILE

 ************************************************/

public enum IssueStatus: Int {

    case closed 
    case open  = 1

}

extension IssueStatus: Decodable {

    static func create(rawValue: Int) -> IssueStatus?{
        return IssueStatus(rawValue: rawValue)
    }

    public init?(decoder: Decoder) {
    if let rawValue: Int  = decoder.decode("value"),
    instance = IssueStatus(rawValue: rawValue) {
        self = instance
        } else { return nil }

          }
}

extension IssueStatus: Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(self.rawValue, forKey: "value")
    }
}

