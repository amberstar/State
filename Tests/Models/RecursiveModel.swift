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
    
    
    init?(decoder: Decoder) {
        
        guard let id: Int  = decoder.decode("id"),
            name: String = decoder.decode("name"),
            age: Int = decoder.decode("age"),
            MVP: Bool = decoder.decode("mvp"),
            teamates: [Player] = decoder.decodeModelArray("teamates")
        else { return nil }
        
        let email : String? = decoder.decode("email")
        let height : Float? = decoder.decode("height")
        let weight: Double? = decoder.decode("weight")
        let fillins: [Player]? = decoder.decodeModelArray("fillins")
        let teamatesByName: [String : Player]? = decoder.decodeModelDictionary("teamatesByName")
        let awards: [AnyObject]? = decoder.decode("awards")
        
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
