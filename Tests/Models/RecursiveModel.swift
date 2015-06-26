import Foundation
import State

/*
Player:

a model for testing recursive types

NOTE: recursion only supported for classes

*/

///MARK: - Player
struct Player: Model {
    let id: Int
    let name: String
    var email: String?
    var age: Int
    var height: Float?
    var weight: Double?
    var MVP: Bool = false
    var teamates: [Player] = []
    var fillins: [Player]? = []
    var teamatesByName: [String : Player]? = [:]
    var awards: [AnyObject]? = []
    
    init(id: Int, name: String, age: Int) {
        self.id = id
        self.name = name
        self.age = age
    }
    
    init(id: Int, name: String,  email: String?, age: Int, height: Float?, weight: Double?, MVP: Bool, teamates: [Player], fillins: [Player]?, teamatesByName: [String : Player]?, awards:[AnyObject]?) {
        self.id = id
        self.name = name

        self.email = email
        self.age = age
        self.height = height
        self.weight = weight
        self.MVP = MVP
        self.teamates = teamates
        self.fillins = fillins
        self.teamatesByName = teamatesByName
        self.awards = awards
    }
    
    init?(decoder: Decoder) {
        let instance: Player? = Player.create
            <^> decoder.decode("id")
            <*> decoder.decode("name")
            <*> Optional(decoder.decode("email"))
            <*> decoder.decode("age")
            <*> Optional(decoder.decode("height"))
            <*> Optional(decoder.decode("weight"))
            <*> decoder.decode("mvp")
            <*> Optional(decoder.decodeModel("partner"))
            <*> decoder.decodeModelArray("teamates")
            <*> Optional(decoder.decodeModelArray("fillins"))
            <*> Optional(decoder.decodeModelDictionary("teamatesByName"))
            <*> Optional(decoder.decode("awards"))
        
        if let i = instance { self = i } else { return nil }
    }

}

extension Player: Decodable {
    
    static func create(id: Int)(name: String)(email: String?)(age: Int)(height: Float?)(weight: Double?)(MVP: Bool)(partner: Player?)(teamates: [Player])(fillins: [Player]?)(teamatesByName: [String : Player]?)(awards: [AnyObject]?) -> Player {
        return Player(id: id, name: name, email: email, age: age, height: height, weight: weight, MVP: MVP, teamates: teamates, fillins: fillins, teamatesByName: teamatesByName, awards: awards )
    }
    
     }

extension Player: Encodable {
    func encode(encoder: Encoder) {
        encoder.encode(id, "id")
        encoder.encode(name, "name")
        encoder.encode(email, "email")
        encoder.encode(age, "age")
        encoder.encode(height, "height")
        encoder.encode(weight, "weight")
        encoder.encode(MVP, "mvp")
        encoder.encode(teamates, "teamates")
        encoder.encode(fillins, "fillins")
        encoder.encode(teamatesByName, "teamatesByName")
        encoder.encode(awards, "awards")
    }
}