/************************************************

            MACHINE GENERATED FILE

 ************************************************/

import Spot

public struct Issue {
    var comment: String?
    var title: String
    var assignee: Developer
    var priority: IssuePriority
    var product: Product
    var status: IssueStatus?
    var type: IssueType

public init(comment: String?, title: String, assignee: Developer, priority: IssuePriority, product: Product, status: IssueStatus?, type: IssueType) {

    self.comment = comment
    self.title = title
    self.assignee = assignee
    self.priority = priority
    self.product = product
    self.status = status
    self.type = type

    }
}

extension Issue : Decodable {

    static func create(comment: String?)(title: String)(assignee: Developer)(priority: IssuePriority)(product: Product)(status: IssueStatus?)(type: IssueType) -> Issue  {
        return Issue(comment: comment, title: title, assignee: assignee, priority: priority, product: product, status: status, type: type)
    }

    public init?(var decoder: Decoder) {

        if Issue.shouldMigrateIfNeeded {
            if let dataVersion: AnyObject = decoder.decode(Issue.versionKey) {
                if Issue.needsMigration(dataVersion) {
                   let migratedData = Issue.migrateDataForDecoding(decoder.extractData(), dataVersion: dataVersion)
                    decoder = Decoder(data: migratedData)
                }
            }
        }

        let instance: Issue? = Issue.create
        <^> decoder.decode("comment") >>> asOptional
        <*> decoder.decode("title")
        <*> decoder.decodeModel("assignee")
        <*> decoder.decodeModel("priority")
        <*> decoder.decodeModel("product")
        <*> decoder.decodeModel("status") >>> asOptional
        <*> decoder.decodeModel("type")

        if let i = instance {
            i.didFinishDecodingWithDecoder(decoder)
            self = i
        } else { return nil }
    }
}

extension Issue : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(self.comment, forKey: "comment")
        encoder.encode(self.title, forKey: "title")
        encoder.encode(self.assignee, forKey: "assignee")
        encoder.encode(self.priority, forKey: "priority")
        encoder.encode(self.product, forKey: "product")
        encoder.encode(self.status, forKey: "status")
        encoder.encode(self.type, forKey: "type")

        if Issue.shouldEncodeVersion {
                encoder.encode(Issue.version, forKey:Issue.versionKey)
        }
        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension Issue {
    /**
    These are provided from the data model designer
    and can be used to determine if the model is
    a different version.
    */
    static var modelVersionHash: String {
        return "<2afa06c9 db29cf02 2f36a7df d3a094d3 1bd62738 2f57f6b4 13b7302b 1bc0d060>"
    }

    static var modelVersionHashModifier: String? {
        return nil
    }
}

