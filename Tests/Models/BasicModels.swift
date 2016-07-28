import State
import Foundation
/*
BasicTypes<T>:

a generic model for testing basic data types

*/

///MARK: - BasicTypes
struct BasicTypes<T> {
    let t: T
    let tOpt: T?
    let tImp: T!
    let tArr: [T]
    let tArrOpt: [T]?
    let tArrImp: [T]!
    let tDic: [String : T]
    let tDicOpt: [String : T]?
    let tDictImp: [String : T]!
    
}

extension BasicTypes : Model {
   
   static func read(from store: Store) -> BasicTypes? {
      return self.init(with: store)
   }
    
    init?(with store: Store) {
        guard
            let t: T = store.value(forKey: "t"),
            let tArr : [T] = store.value(forKey: "t_arr"),
            let tDic : [String : T] = store.value(forKey: "t_dic")
        else {
            return nil
        }
        
        let tOpt: T?  = store.value(forKey: "t_opt")
        let tImp : T! = store.value(forKey: "t_imp")
        let tArrOpt : [T]? = store.value(forKey: "t_arr_opt")
        let tArrImp : [T]! = store.value(forKey: "t_arr_imp")
        let tDicOpt : [String : T]? = store.value(forKey: "t_dic_opt")
        let tDictImp : [String : T]! = store.value(forKey: "t_dic_imp")
        
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
    
    func write(to store: inout Store){
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
StringTypes:

a model for testing string types

*/

///MARK: - StringTypes
struct StringTypes {
    let t: String
    let tOpt: String?
    let tImp: String!
    let tArr: [String]
    let tArrOpt: [String]?
    let tArrImp: [String]!
    let tDic: [String : String]
    let tDicOpt: [String : String]?
    let tDictImp: [String : String]!
    
}

extension StringTypes : Model {
   
   static func read(from store: Store) -> StringTypes? {
      return self.init(with: store)
   }
    
    init?(with store: Store) {
        guard
            let t: String = store.value(forKey: "t"),
            let tArr : [String] = store.value(forKey: "t_arr"),
            let tDic : [String : String] = store.value(forKey: "t_dic")
        else {
            return nil
        }
        
        let tOpt: String?  = store.value(forKey: "t_opt")
        let tImp : String! = store.value(forKey: "t_imp")
        let tArrOpt : [String]? = store.value(forKey: "t_arr_opt")
        let tArrImp : [String]! = store.value(forKey: "t_arr_imp")
        let tDicOpt : [String : String]? = store.value(forKey: "t_dic_opt")
        let tDictImp : [String : String]! = store.value(forKey: "t_dic_imp")
        
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
    
    func write(to store: inout Store){
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
AnyObjectTypes:

a  model for testing 'AnyObject' types

*/

///MARK: - AnyObjectTypes
struct AnyObjectTypes {
    let t: AnyObject
    let tOpt: AnyObject?
    let tImp: AnyObject!
    let tArr: [AnyObject]
    let tArrOpt: [AnyObject]?
    let tArrImp: [AnyObject]!
    let tDic: [String : AnyObject]
    let tDicOpt: [String : AnyObject]?
    let tDictImp: [String : AnyObject]!

}

extension AnyObjectTypes : Model {
   
   static func read(from store: Store) -> AnyObjectTypes? {
      return self.init(with: store)
   }
   
   init?(with store: Store) {
    
    guard
        let t: AnyObject = store.object(forKey: "t"),
        let tArr : [AnyObject] = store.array(forKey: "t_arr"),
        let tDic : [String : AnyObject] = store.dictionary(forKey: "t_dic")
    else {
        return nil
    }
      
    let tOpt: AnyObject?  = store.object(forKey: "t_opt")
    let tImp : AnyObject! = store.object(forKey: "t_imp")
    let tArrOpt : [AnyObject]? = store.array(forKey: "t_arr_opt")
    let tArrImp : [AnyObject]! = store.array(forKey: "t_arr_imp")
    let tDicOpt : [String : AnyObject]? = store.dictionary(forKey: "t_dic_opt")
    let tDictImp : [String : AnyObject]! = store.dictionary(forKey: "t_dic_imp")
      
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
   
    func write(to store: inout Store){
        store.set(t, forKey: "t")
        store.set(tOpt, forKey: "t_opt")
        store.set(tImp, forKey: "t_imp")
        store.set(tArr, forKey: "t_arr")
        store.set(tArrOpt, forKey: "t_arr_opt")
        store.set(tArrImp, forKey: "t_arr_imp")
        store.set(tDic, forKey: "t_dic")
        store.set(tDicOpt,forKey: "t_dic_opt")
        store.set(tDictImp, forKey: "t_dic_imp")
    }
}
