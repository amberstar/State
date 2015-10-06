import Foundation

public enum Format {
    case JSON
    case Plist
    case Binary
    
    public var converter: KeyedConverter.Type {
        switch self {
        case JSON:
            return STState.JSON.self
        case Plist:
            return STState.Plist.self
        case Binary:
            return STState.Binary.self
        }
    }
}

/// Serialization format
public protocol KeyedConverter {
    static func write(data: [String : AnyObject]?, path: String) -> Bool
    static func write(data: [String : AnyObject]) -> NSData?
    static func write(data: [String : AnyObject]) -> String?
    static func read(path: String) -> [String : AnyObject]?
    static func read(data: NSData) -> [String : AnyObject]?
    static func read(contentsOfURL aURL: NSURL) -> [String : AnyObject]?
    static func readString(string: String) -> [String : AnyObject]?
}

extension KeyedConverter {
    /// print data to standard output
    static func inspect(data: [String : AnyObject]) {
        if let string: String? = write(data) {
            print(string)
        } else  { debugPrint("Data: could not print") }
    }
}
