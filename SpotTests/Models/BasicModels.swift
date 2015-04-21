import Spot
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
    
    init(t: T, tOpt: T?, tImp: T!, tArr: [T], tArrOpt: [T]?, tArrImp: [T]!, tDic: [String : T], tDicOpt: [String : T]?, tDicImp: [String : T]!) {
        self.t = t
        self.tOpt = tOpt
        self.tImp = tImp
        self.tArr = tArr
        self.tArrOpt = tArrOpt
        self.tArrImp = tArrImp
        self.tDic = tDic
        self.tDicOpt = tDicOpt
        self.tDictImp = tDicImp
    }
}

extension BasicTypes : Decodable {
    
    static func create<T>(t: T )(tOpt: T?)(tImp: T?)(tArr: [T])(tArrOpt: [T]?)(tArrImp: [T]?)(tDic: [String : T])(tDicOpt: [String : T]?)(tDicImp: [String : T]?) -> BasicTypes<T>  {
        return BasicTypes<T>(t: t, tOpt: tOpt, tImp: tImp, tArr: tArr, tArrOpt: tArrOpt, tArrImp: tArrImp, tDic: tDic, tDicOpt: tDicOpt, tDicImp: tDicImp)
    }
    
    init?(decoder: Decoder) {
        let instance: BasicTypes? = BasicTypes.create
            <^> decoder.decode("t")
            <*> Optional(decoder.decode("t_opt"))
            <*> Optional(decoder.decode("t_imp"))
            <*> decoder.decode("t_arr")
            <*> Optional(decoder.decode("t_arr_opt"))
            <*> Optional(decoder.decode("t_arr_imp"))
            <*> decoder.decode("t_dic")
            <*> Optional(decoder.decode("t_dic_opt"))
            <*> Optional(decoder.decode("t_dic_imp"))
        
        if let i = instance { self = i } else { return nil }
    }
}

extension BasicTypes : Encodable {
    
    func encode(encoder: Encoder){
        encoder.encode(self.t, forKey: "t")
        encoder.encode(self.tOpt, forKey: "t_opt")
        encoder.encode(self.tImp, forKey:"t_imp")
        encoder.encode(self.tArr, forKey: "t_arr")
        encoder.encode(self.tArrOpt, forKey: "t_arr_opt")
        encoder.encode(self.tArrImp, forKey: "t_arr_imp")
        encoder.encode(self.tDic, forKey: "t_dic")
        encoder.encode(self.tDicOpt, forKey: "t_dic_opt")
        encoder.encode(self.tDictImp, forKey: "t_dic_imp")
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
    
    init(t: String, tOpt: String?, tImp: String!, tArr: [String], tArrOpt: [String]?, tArrImp: [String]!, tDic: [String : String], tDicOpt: [String : String]?, tDicImp: [String : String]!) {
        self.t = t
        self.tOpt = tOpt
        self.tImp = tImp
        self.tArr = tArr
        self.tArrOpt = tArrOpt
        self.tArrImp = tArrImp
        self.tDic = tDic
        self.tDicOpt = tDicOpt
        self.tDictImp = tDicImp
    }
}

extension StringTypes : Decodable {
    
    static func create(t: String )(tOpt: String?)(tImp: String?)(tArr: [String])(tArrOpt: [String]?)(tArrImp: [String]?)(tDic: [String : String])(tDicOpt: [String : String]?)(tDicImp: [String : String]?) -> StringTypes  {
        return StringTypes(t: t, tOpt: tOpt, tImp: tImp, tArr: tArr, tArrOpt: tArrOpt, tArrImp: tArrImp, tDic: tDic, tDicOpt: tDicOpt, tDicImp: tDicImp)
    }
    
    init?(decoder: Decoder) {
        if let instance = StringTypes.create
            <^> decoder.decode("t")
            <*> Optional(decoder.decode("t_opt"))
            <*> Optional(decoder.decode("t_imp"))
            <*> decoder.decode("t_arr")
            <*> Optional(decoder.decode("t_arr_opt"))
            <*> Optional(decoder.decode("t_arr_imp"))
            <*> decoder.decode("t_dic")
            <*> Optional(decoder.decode("t_dic_opt"))
            <*> Optional(decoder.decode("t_dic_imp")) {
                self = instance
        } else {
            return nil
        }
    }
}

extension StringTypes : Encodable {
    
    func encode(encoder: Encoder){
        encoder.encode(self.t, forKey: "t")
        encoder.encode(self.tOpt, forKey: "t_opt")
        encoder.encode(self.tImp, forKey:"t_imp")
        encoder.encode(self.tArr, forKey: "t_arr")
        encoder.encode(self.tArrOpt, forKey: "t_arr_opt")
        encoder.encode(self.tArrImp, forKey: "t_arr_imp")
        encoder.encode(self.tDic, forKey: "t_dic")
        encoder.encode(self.tDicOpt, forKey: "t_dic_opt")
        encoder.encode(self.tDictImp, forKey: "t_dic_imp")
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
    
    init(t: AnyObject, tOpt: AnyObject?, tImp: AnyObject!, tArr: [AnyObject], tArrOpt: [AnyObject]?, tArrImp: [AnyObject]!, tDic: [String : AnyObject], tDicOpt: [String : AnyObject]?, tDicImp: [String : AnyObject]!) {
        self.t = t
        self.tOpt = tOpt
        self.tImp = tImp
        self.tArr = tArr
        self.tArrOpt = tArrOpt
        self.tArrImp = tArrImp
        self.tDic = tDic
        self.tDicOpt = tDicOpt
        self.tDictImp = tDicImp
    }
}

extension AnyObjectTypes : Decodable {
    
    static func create(t: AnyObject )(tOpt: AnyObject?)(tImp: AnyObject?)(tArr: [AnyObject])(tArrOpt: [AnyObject]?)(tArrImp: [AnyObject]?)(tDic: [String : AnyObject])(tDicOpt: [String : AnyObject]?)(tDicImp: [String : AnyObject]?) -> AnyObjectTypes  {
        return AnyObjectTypes(t: t, tOpt: tOpt, tImp: tImp, tArr: tArr, tArrOpt: tArrOpt, tArrImp: tArrImp, tDic: tDic, tDicOpt: tDicOpt, tDicImp: tDicImp)
    }
    
    init?(decoder: Decoder) {
        if let instance = AnyObjectTypes.create
            <^> decoder.decode("t")
            <*> Optional(decoder.decode("t_opt"))
            <*> Optional(decoder.decode("t_imp"))
            <*> decoder.decode("t_arr")
            <*> Optional(decoder.decode("t_arr_opt"))
            <*> Optional(decoder.decode("t_arr_imp"))
            <*> decoder.decode("t_dic")
            <*> Optional(decoder.decode("t_dic_opt"))
            <*> Optional(decoder.decode("t_dic_imp")) {
            self = instance
        } else {
            return nil
        }
    }
}

extension AnyObjectTypes : Encodable {
    
    func encode(encoder: Encoder){
        encoder.encode(self.t, forKey: "t")
        encoder.encode(self.tOpt, forKey: "t_opt")
        encoder.encode(self.tImp, forKey:"t_imp")
        encoder.encode(self.tArr, forKey: "t_arr")
        encoder.encode(self.tArrOpt, forKey: "t_arr_opt")
        encoder.encode(self.tArrImp, forKey: "t_arr_imp")
        encoder.encode(self.tDic, forKey: "t_dic")
        encoder.encode(self.tDicOpt, forKey: "t_dic_opt")
        encoder.encode(self.tDictImp, forKey: "t_dic_imp")
    }
}