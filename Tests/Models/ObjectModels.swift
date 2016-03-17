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

extension UserTypes : Decodable {
    
    
    init?(decoder: Decoder) {
    
        guard let t : User = decoder.decode("t") else { return nil }
        guard let tArr : [User] = decoder.decode("t_arr") else { return nil }
        guard let tDic : [String : User] = decoder.decode("t_dic") else { return nil }
        let tOpt : User? = decoder.decode("t_opt")
        let tImp : User! = decoder.decode("t_imp")
        let tArrOpt : [User]? = decoder.decode("t_arr_opt")
        let tArrImp : [User]! = decoder.decode("t_arr_imp")
        let tDicOpt : [String : User]? = decoder.decode("t_dic_opt")
        let tDictImp : [String : User]! = decoder.decode("t_dic_imp")
            
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
}

extension UserTypes : Encodable {
    
    func encode(encoder: Encoder){
        encoder.encode(t, "t")
        encoder.encode(tOpt, "t_opt")
        encoder.encode(tImp, "t_imp")
        encoder.encode(tArr, "t_arr")
        encoder.encode(tArrOpt, "t_arr_opt")
        encoder.encode(tArrImp, "t_arr_imp")
        encoder.encode(tDic, "t_dic")
        encoder.encode(tDicOpt, "t_dic_opt")
        encoder.encode(tDictImp, "t_dic_imp")
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

extension User: Decodable, Encodable{
  
        init? (decoder: Decoder) {
            guard let id : Int = decoder.decode("id") else { return nil }
            guard let name : String = decoder.decode("name") else { return nil }
            let email : String? = decoder.decode("email")
            
            self.id = id
            self.name = name
            self.email = email
    }

    func encode(encoder: Encoder) {
        encoder.encode(id, "id")
        encoder.encode(name, "name")
        encoder.encode(email, "email")
    }
}
