import Foundation

extension URL : Encodable, Decodable {
    
    public static func decode(_ decoder: Decoder) -> URL? {
        if let value : String  = decoder.decode("URL") {
            return self.init(string: value)
        }
        else {
            return nil
        }
    }
    
    public func encode(_ encoder: Encoder) {
        encoder.encode(self.absoluteString, "URL")
    }
}

extension KVStore {
    
    public func getURL(forKey key: String) -> URL? {
        return getValue(forKey: key)
    }
    
    public func getURL(forKey key: String, defaultValue: URL) -> URL {
        return getValue(forKey: key) ?? defaultValue
    }
    
    public func getURLS(forKey key: String) -> [URL]? {
        return getValue(forKey: key)
    }
    
    public func getURLS(forKey key: String, defaultValue: [URL]) -> [URL] {
        return getValue(forKey: key) ?? defaultValue
    }
}
