import State
/*

UserTypes:

a model for testing decodable/encodable types

*/

///MARK: - ObjectTypes
struct UserTypes: Model {
    let t: User
    let tOpt: User?
    let tImp: User!
    let tArr: [User]
    let tArrOpt: [User]?
    let tArrImp: [User]!
    let tDic: [String : User]
    let tDicOpt: [String : User]?
    let tDictImp: [String : User]!
}

extension UserTypes {
   
    static func read(from store: Store) -> UserTypes? {
      return self.init(with: store)
   }
   
   init?(with store: Store) {
      
    guard let t : User = store.value(forKey: "t") else { return nil }
    guard let tArr : [User] = store.value(forKey: "t_arr") else { return nil }
    guard let tDic : [String : User] = store.value(forKey: "t_dic") else { return nil }
    let tOpt : User? = store.value(forKey: "t_opt")
    let tImp : User! = store.value(forKey: "t_imp")
    let tArrOpt : [User]? = store.value(forKey: "t_arr_opt")
    let tArrImp : [User]! = store.value(forKey: "t_arr_imp")
    let tDicOpt : [String : User]? = store.value(forKey: "t_dic_opt")
    let tDictImp : [String : User]! = store.value(forKey: "t_dic_imp")
      
      self.t = t
      self.tOpt = tOpt
      self.tImp = tImp
      self.tArr = tArr
      self.tArrOpt = tArrOpt
      self.tArrImp = tArrImp
      self.tDic = tDic
      self.tDicOpt = tDicOpt
      self.tDictImp = tDictImp
   }
    
// MARK: - Storeable
    
    public static func restore(from store: Store) -> UserTypes? {
        return self.init(with: store)
    }
    

   
    func store(to store: inout Store){
        store.set(t, forKey: "t")
        store.set(tOpt, forKey: "t_opt")
        store.set(tImp, forKey: "t_imp")
        store.set(tArr, forKey: "t_arr")
        store.set(tArrOpt, forKey: "t_arr_opt")
        store.set(tArrImp, forKey: "t_arr_imp")
        store.set(tDic, forKey: "t_dic")
        store.set(tDicOpt, forKey: "t_dic_opt")
        store.set(tDictImp, forKey: "t_dic_imp")
    }
}

/* 
User:

a model for testing decodable/encodable types

*/

///MARK: - User
struct User {
    let id: Int
    let name: String
    let email: String?
}

extension User: Model {
  
   static func read(from store: Store) -> User? {
      return self.init(with: store)
   }
   
   init? (with store: Store) {
    guard let id : Int = store.value(forKey: "id") else { return nil }
    guard let name : String = store.value(forKey: "name") else { return nil }
    let email : String? = store.value(forKey: "email")
      
      self.id = id
      self.name = name
      self.email = email
   }
    
// MARK: - Storeable
    
    public static func restore(from store: Store) -> User? {
        return self.init(with: store)
    }
    
    func store(to store: inout Store) {
        store.set(id, forKey: "id")
        store.set(name, forKey: "name")
        store.set(email, forKey: "email")
    }
}
