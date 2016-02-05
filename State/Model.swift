/// a model type that is decodable, encodable and migratable
/// all generated models implement this protocol
public protocol Model : Decodable, Encodable, Migratable {}

public extension Model {
    
    /// Initialize a model with a specified format from a file
    /// note this is a failable init
    public init?(_ format: Format, path: String) {
        if let i =  Self.decodeFromFile(format.converter, path: path) {
            self = i
        } else { return nil }
    }
    
    /// Save a model to a specified format
    public func save(format: Format, path: String) -> Bool {
        return format.converter.write(self.encode(), path: path)
    }
    
    /// Print the models JSON representation to the standard output
    func printJSON() {
        print(JSON.inspect(self.encode()))
    }
    
    var JSONDescription : String? {
        return JSON.write(self.encode())
    }
}
