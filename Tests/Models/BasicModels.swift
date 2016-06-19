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

extension BasicTypes : Decodable {
   
   static func decode(_ decoder: Decoder) -> BasicTypes? {
      return self.init(decoder: decoder)
   }
    
    init?(decoder: Decoder) {
        guard let t: T = decoder.decode("t"),
        tArr : [T] = decoder.decode("t_arr"),
        tDic : [String : T] = decoder.decode("t_dic") else { return nil }
        
        let tOpt: T?  = decoder.decode("t_opt")
        let tImp : T! = decoder.decode("t_imp")
        let tArrOpt : [T]? = decoder.decode("t_arr_opt")
        let tArrImp : [T]! = decoder.decode("t_arr_imp")
        let tDicOpt : [String : T]? = decoder.decode("t_dic_opt")
        let tDictImp : [String : T]! = decoder.decode("t_dic_imp")
        
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

extension BasicTypes : Encodable {
    
    func encode(_ encoder: Encoder){
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

extension StringTypes : Decodable {
   
   static func decode(_ decoder: Decoder) -> StringTypes? {
      return self.init(decoder: decoder)
   }
    
    init?(decoder: Decoder) {
        guard let t: String = decoder.decode("t"),
            tArr : [String] = decoder.decode("t_arr"),
            tDic : [String : String] = decoder.decode("t_dic") else { return nil }
        
        let tOpt: String?  = decoder.decode("t_opt")
        let tImp : String! = decoder.decode("t_imp")
        let tArrOpt : [String]? = decoder.decode("t_arr_opt")
        let tArrImp : [String]! = decoder.decode("t_arr_imp")
        let tDicOpt : [String : String]? = decoder.decode("t_dic_opt")
        let tDictImp : [String : String]! = decoder.decode("t_dic_imp")
        
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

extension StringTypes : Encodable {
    
    func encode(_ encoder: Encoder){
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

extension AnyObjectTypes : Decodable {
   
   static func decode(_ decoder: Decoder) -> AnyObjectTypes? {
      return self.init(decoder: decoder)
   }
   
   init?(decoder: Decoder) {
      guard let t: AnyObject = decoder.decode("t"),
         tArr : [AnyObject] = decoder.decode("t_arr"),
         tDic : [String : AnyObject] = decoder.decode("t_dic") else { return nil }
      
      let tOpt: AnyObject?  = decoder.decode("t_opt")
      let tImp : AnyObject! = decoder.decode("t_imp")
      let tArrOpt : [AnyObject]? = decoder.decode("t_arr_opt")
      let tArrImp : [AnyObject]! = decoder.decode("t_arr_imp")
      let tDicOpt : [String : AnyObject]? = decoder.decode("t_dic_opt")
      let tDictImp : [String : AnyObject]! = decoder.decode("t_dic_imp")
      
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

extension AnyObjectTypes : Encodable {
   
    func encode(_ encoder: Encoder){
        encoder.encode(t, "t")
        encoder.encode(tOpt, "t_opt")
        encoder.encode(tImp, "t_imp")
        encoder.encode(tArr, "t_arr")
        encoder.encode(tArrOpt, "t_arr_opt")
        encoder.encode(tArrImp, "t_arr_imp")
        encoder.encode(tDic, "t_dic")
        encoder.encode(tDicOpt,"t_dic_opt")
        encoder.encode(tDictImp, "t_dic_imp")
    }
}
