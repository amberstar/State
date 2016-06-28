
import Foundation

/// A Model type  is decodable, encodable and migratable
public protocol Model : Decodable, Encodable, Migratable {}

extension Model {

    /// Save a model to a specified format
    public func save(to file: URL,  format: Format) -> Bool {
        return write(to: file, format: format)
    }
    
    public static func load(from file: URL, format: Format) -> Self? {
        return Self(file: file, format: format)
    }
}

public protocol ModelStore {
    
    func model<Model: Decodable>(forKey: String) -> Model?
    func modelArray<Model: Decodable>(forKey: String) -> [Model]?
    func modelDictionary<Model: Decodable>(forKey: String) -> [String : Model]?
    func set<Model: Encodable>(_: Model, forKey: String)
    func set<Model: Encodable>(_: [Model], forKey key: String)
    func set<Model: Encodable>(_: [String : Model], forKey key: String)
}

extension KeyedModelStore {
    
    public func model<Model: Decodable>(forKey key: String, defaultValue: Model) -> Model {
        return model(forKey: key) ?? defaultValue
    }
    
    public func modelArray<Model: Decodable>(forKey key: String, defaultValue: [Model]) -> [Model] {
        return model(forKey: key) ?? defaultValue
    }
    
    public func modelDictionary<Model: Decodable>(forKey key: String,  defaultValue: [String : Model]
        ) -> [String : Model] {
        return model(forKey: key) ?? defaultValue
    }
}
