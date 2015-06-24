import Foundation


public protocol DataFormat {
    static func write(data: [String : AnyObject]?, path: String) -> Bool
    static func write(data: [String : AnyObject]) -> NSData?
    static func write(data: [String : AnyObject]) -> String?
    static func read(path: String) -> [String : AnyObject]?
    static func read(data: NSData) -> [String : AnyObject]?
    static func read(contentsOfURL aURL: NSURL) -> [String : AnyObject]?
    static func readString(string: String) -> [String : AnyObject]?
    
}

 extension DataFormat {
    
    /// print data to standard output
    static func inspect(data: [String : AnyObject]) {
        if let string: String? = write(data) {
            print(string)
        } else  { debugPrint("Data: could not print") }
    }
}

/// base class for all data services. (see JSON, and Plist)
/// provides binary plist format
public class Data: DataFormat {
    

    /// write data to a file
    /// - returns: true if succeeded, false if failed
    public class func write(data: [String : AnyObject]?, path: String) -> Bool {
        if let input = data {
            return fileFromObject(input, path: path)
        } else {
            return false
        }
    }
    
    /// write data to  NSData
    /// - returns: NSData or nil if failed
    public class func write(data: [String : AnyObject]) -> NSData? {
        return dataFromObject(data, prettyPrint: false)
    }
    
    /// write data to String
    /// - returns: a string or nil if failed
    public class func write(data: [String : AnyObject]) -> String? {
        return stringFromObject(data)
    }
    

    /// Read data from a file
    /// - returns: a data object or nil
    public  class func read(path: String) -> [String : AnyObject]? {
        return objectFromFile(path)
    }
    

    /// Read data from NSData
    /// - returns: a data object or nil
    public class func read(data: NSData) -> [String : AnyObject]? {
        return objectFromData(data)
    }
    
    /// Read data from a URL
    /// - returns: a data object or nil
    public class func read(contentsOfURL aURL: NSURL) -> [String : AnyObject]? {
        if let data = NSData(contentsOfURL: aURL) {
            return objectFromData(data)
        }
        return nil
    }
    
    /// Read data from a string
    /// - returns: a data object or nil
    public class func readString(string: String) -> [String : AnyObject]? {
        return objectFromString(string)
    }
    
// MARK: - INTERNAL METHODS

    class func fileFromObject(object: [String : AnyObject], path: String) -> Bool  {
        if let data = dataFromObject(object, prettyPrint: true) {
            return data.writeToFile(path, atomically: true )
        }
        else {
            return false
        }
    }
    
    class func objectFromFile(path: String) -> [String : AnyObject]? {
        if let data = dataFromFile(path) {
            return objectFromData(data)
        } else {
            return nil
        }
    }
    
    class func stringFromObject(object: [String : AnyObject]) -> String? {
        if let data = dataFromObject(object, prettyPrint: true) {
            return stringFromData(data)
        } else {
            return nil
        }
    }
    
    class func objectFromString(string: String) -> [String : AnyObject]? {
        if let data = dataFromString(string) {
            return objectFromData(data)
        } else {
            return nil
        }
    }
    
    class func dataFromFile(path: String) -> NSData? {
        return  NSData(contentsOfFile: path)
    }
    
    class func stringFromData(data: NSData) -> String? {
        return NSString(data: data, encoding: NSUTF8StringEncoding) as? String
    }
    
    class func dataFromString(string : String) -> NSData? {
        return string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
    }
    
    class func objectFromData(data: NSData) -> [String : AnyObject]? {
        return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? [String : AnyObject]
    }
    
    class func dataFromObject(object: [String : AnyObject], prettyPrint: Bool) -> NSData?  {
        return NSKeyedArchiver.archivedDataWithRootObject(object)
    }
}