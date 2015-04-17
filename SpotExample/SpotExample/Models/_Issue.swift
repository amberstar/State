import Spot

/************************************************

            MACHINE GENERATED FILE

 ************************************************/

public struct Issue {
    var comment: String?
    var title: String
    var assignee: Developer
    var product: Product
    var status: IssueStatus?
    var type: IssueType

    init(comment: String?, title: String, assignee: Developer, product: Product, status: IssueStatus?, type: IssueType) {

        self.comment = comment
        self.title = title
        self.assignee = assignee
        self.product = product
        self.status = status
        self.type = type

    }
}

extension Issue : Decodable {

    static func create(comment: String?)(title: String)(assignee: Developer)(product: Product)(status: IssueStatus?)(type: IssueType) -> Issue  {

        return Issue(comment: comment, title: title, assignee: assignee, product: product, status: status, type: type)
    }

    public init?(decoder: Decoder) {
        let instance: Issue? = Issue.create
        <^> decoder.decodeOptional("comment")
        <*> decoder.decode("title")
        <*> decoder.decodeObject("assignee")
        <*> decoder.decodeObject("product")
        <*> decoder.decodeOptionalObject("status")
        <*> decoder.decodeObject("type")

        if let i = instance { self = i } else { return nil }
    }
}

extension Issue : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(self.comment, forKey: "comment")
        encoder.encode(self.title, forKey: "title")
        encoder.encode(self.assignee, forKey: "assignee")
        encoder.encode(self.product, forKey: "product")
        encoder.encode(self.status, forKey: "status")
        encoder.encode(self.type, forKey: "type")

    }
}

