import Foundation

extension UserDefaults : KeyedModelStore {
    
    //****************************************************************************//
    // MARK: Getters
    //****************************************************************************//
    
    public func model<Model: Decodable>(forKey key: String) -> Model? {
        guard let dictionary = dictionary(forKey: key) else { return nil }
        return Model.decode(with: Decoder(data: dictionary))
    }
    
    public func models<Model: Decodable>(forKey key: String) -> [Model]? {
        guard let array = array(forKey: key) else { return nil }
        return sequence(array.map {
            guard let data = $0 as? [String : AnyObject] else { return nil }
            return Model.decode(with: Decoder(data: data))
            })
    }
    
    public func models<Model: Decodable>(forKey key: String) -> [String : Model]? {
        guard let dictionary = dictionary(forKey: key) else { return nil }
        return sequence(dictionary.map {
            guard let data = $0 as? [String : AnyObject] else { return nil }
            return Model.decode(with: Decoder(data: data))
            })
    }
    
    //****************************************************************************//
    // MARK: Setters
    //****************************************************************************//
    
    public func set<Model: Encodable>(_ model: Model, forKey key: String) {
        set(model._encode(), forKey: key)
    }
    
    public func set<Model: Encodable>(_ models: [Model], forKey key: String) {
        set(models.map { $0._encode() }, forKey: key)
    }
    
    public func set<Model: Encodable>(_ models: [String : Model], forKey key: String) {
        set(models.map { $0._encode() }, forKey: key)
    }
}
