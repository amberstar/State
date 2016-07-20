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
   
   static func read(from store: Store) -> Player? {
      return self.init(with: store)
   }
   
   init?(with store: Store) {
      
    guard
        let id: Int  = store.value(forKey: "id"),
        let name: String = store.value(forKey: "name"),
        let age: Int = store.value(forKey: "age"),
        let MVP: Bool = store.value(forKey: "mvp"),
        let teamates: [Player] = store.value(forKey: "teamates")
    else {
        return nil
    }
      
    let email : String? = store.value(forKey: "email")
    let height : Float? = store.value(forKey: "height")
    let weight: Double? = store.value(forKey: "weight")
    let fillins: [Player]? = store.value(forKey: "fillins")
    let teamatesByName: [String : Player]? = store.value(forKey: "teamatesByName")
    let awards: [AnyObject]? = store.value(forKey: "awards")
      
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

    func write(to store: inout Store) {
        store.set(id, forKey: "id")
        store.set(name, forKey: "name")
        store.set(email, forKey: "email")
        store.set(age, forKey: "age")
        store.set(height, forKey: "height")
        store.set(weight, forKey: "weight")
        store.set(MVP, forKey: "mvp")
        store.set(teamates, forKey: "teamates")
        store.set(fillins, forKey: "fillins")
        store.set(teamatesByName, forKey: "teamatesByName")
        store.set(awards, forKey: "awards")
    }
}
