import Spot

/************************************************

            MACHINE GENERATED FILE

 ************************************************/

public struct Issues {
    var closedIssues: [Issue]
    var openIssues: [Issue]

    init(closedIssues: [Issue], openIssues: [Issue]) {

        self.closedIssues = closedIssues
        self.openIssues = openIssues

    }
}

extension Issues : Decodable {

    static func create(closedIssues: [Issue])(openIssues: [Issue]) -> Issues  {

        return Issues(closedIssues: closedIssues, openIssues: openIssues)
    }

    public init?(decoder: Decoder) {
        let instance: Issues? = Issues.create
        <^> decoder.decodeObjectArray("closedIssues")
        <*> decoder.decodeObjectArray("openIssues")

        if let i = instance { self = i } else { return nil }
    }
}

extension Issues : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(self.closedIssues, forKey: "closedIssues")
        encoder.encode(self.openIssues, forKey: "openIssues")

    }
}

