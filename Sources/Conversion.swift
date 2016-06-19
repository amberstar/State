import Foundation

public enum Format {
    case json
    case plist
    case binary
    
    public var converter: Converter.Type {
        switch self {
        case json:
            return State.JSON.self
        case plist:
            return State.Plist.self
        case binary:
            return State.Binary.self
        }
    }
}

//****************************************************************************//
//                               Converter
//****************************************************************************//

/// Serialization format
public protocol Converter {
    static func write(_ data: [String : AnyObject]?, path: String) -> Bool
    static func write(_ data: [String : AnyObject]) -> Data?
    static func write(_ data: [String : AnyObject]) -> String?
    static func read(_ path: String) -> [String : AnyObject]?
    static func read(_ data: Data) -> [String : AnyObject]?
    static func read(contentsOfURL aURL: URL) -> [String : AnyObject]?
    static func readString(_ string: String) -> [String : AnyObject]?
}

extension Converter {
    /// print data to standard output
    static func inspect(_ data: [String : AnyObject]) {
        if let string: String = write(data) {
            print(string)
        } else  { debugPrint("Data: could not print") }
    }
}

//****************************************************************************//
//                               Binary
//****************************************************************************//

/// binary Plist data format
/// base class for all data services. (see JSON, and Plist)
public class Binary: Converter {
   
   /// write data to a file
   /// - returns: true if succeeded, false if failed
   public class func write(_ data: [String : AnyObject]?, path: String) -> Bool {
      if let input = data {
         return fileFromObject(input, path: path)
      } else {
         return false
      }
   }
   
   /// write data to  NSData
   /// - returns: NSData or nil if failed
   public class func write(_ data: [String : AnyObject]) -> Data? {
      return dataFromObject(data, prettyPrint: false)
   }
   
   /// write data to String
   /// - returns: a string or nil if failed
   public class func write(_ data: [String : AnyObject]) -> String? {
      return stringFromObject(data)
   }
   
   /// Read data from a file
   /// - returns: a data object or nil
   public  class func read(_ path: String) -> [String : AnyObject]? {
      return objectFromFile(path)
   }
   
   /// Read data from NSData
   /// - returns: a data object or nil
   public class func read(_ data: Data) -> [String : AnyObject]? {
      return objectFromData(data)
   }
   
   /// Read data from a URL
   /// - returns: a data object or nil
   public class func read(contentsOfURL aURL: URL) -> [String : AnyObject]? {
      if let data = try? Data(contentsOf: aURL) {
         return objectFromData(data)
      }
      return nil
   }
   
   /// Read data from a string
   /// - returns: a data object or nil
   public class func readString(_ string: String) -> [String : AnyObject]? {
      return objectFromString(string)
   }
   
   // MARK: - INTERNAL METHODS
   
   class func fileFromObject(_ object: [String : AnyObject], path: String) -> Bool  {
      if let data = dataFromObject(object, prettyPrint: true) {
         return ((try? data.write(to: URL(fileURLWithPath: path), options: [.dataWritingAtomic] )) != nil)
      }
      else {
         return false
      }
   }
   
   class func objectFromFile(_ path: String) -> [String : AnyObject]? {
      if let data = dataFromFile(path) {
         return objectFromData(data)
      } else {
         return nil
      }
   }
   
   class func stringFromObject(_ object: [String : AnyObject]) -> String? {
      if let data = dataFromObject(object, prettyPrint: true) {
         return stringFromData(data)
      } else {
         return nil
      }
   }
   
   class func objectFromString(_ string: String) -> [String : AnyObject]? {
      if let data = dataFromString(string) {
         return objectFromData(data)
      } else {
         return nil
      }
   }
   
   class func dataFromFile(_ path: String) -> Data? {
      return (try? Data(contentsOf: URL(fileURLWithPath: path)))
   }
   
   class func stringFromData(_ data: Data) -> String? {
      return NSString(data: data, encoding: String.Encoding.utf8.rawValue) as? String
   }
   
   class func dataFromString(_ string : String) -> Data? {
      return string.data(using: String.Encoding.utf8,
                                      allowLossyConversion: true)
   }
   
   class func objectFromData(_ data: Data) -> [String : AnyObject]? {
      return NSKeyedUnarchiver.unarchiveObject(with: data) as? [String : AnyObject]
   }
   
   class func dataFromObject(_ object: [String : AnyObject],
                             prettyPrint: Bool) -> Data?  {
      return NSKeyedArchiver.archivedData(withRootObject: object)
   }
}

//****************************************************************************//
//                               Json
//****************************************************************************//


/// JSON serialization format
public final class JSON: Binary {
   
   override class func objectFromData(_ data: Data) -> [String : AnyObject]? {
      do {
         let o: AnyObject =  try JSONSerialization.jsonObject(
            with: data, options: JSONSerialization.ReadingOptions.allowFragments)
         return o as? [String : AnyObject]
      } catch let error as NSError {
         Swift.print(error)
         return nil
      }
   }
   
   override class func dataFromObject(_ object: [String : AnyObject],
                                      prettyPrint: Bool) -> Data?  {
      
      guard JSONSerialization.isValidJSONObject(object) else {
         return nil
      }
      
      let options: JSONSerialization.WritingOptions = prettyPrint ? .prettyPrinted : []
      let data: Data?
      
      do {
         
         data = try JSONSerialization.data(withJSONObject: object, options: options)
      }
      catch let error as NSError {
         
         Swift.print(error)
         data = nil
      }
      return data
   }
}

//****************************************************************************//
//                               Plist
//****************************************************************************//


/// XML Plist serialization format
public final class Plist: Binary {
   
   override class func objectFromData(_ data: Data) -> [String : AnyObject]? {
      
      do {
         
         let o: AnyObject =
            try PropertyListSerialization.propertyList(
               from: data, options:[.mutableContainersAndLeaves], format:nil
               )
         
         return o as? [String : AnyObject]
      } catch let error as NSError {
         
         Swift.print(error)
         return nil
      }
   }
   
   override class func dataFromObject(_ object: [String : AnyObject],
                                      prettyPrint: Bool) -> Data?  {
      
      guard PropertyListSerialization.propertyList(
         object, isValidFor: PropertyListSerialization.PropertyListFormat.xmlFormat_v1_0) else {
            return nil
      }
      
      do {
         
         let data: Data? = try PropertyListSerialization.data(
            fromPropertyList: object, format: PropertyListSerialization.PropertyListFormat.xmlFormat_v1_0, options: .allZeros
            )
         
         return data
      } catch let error as NSError {
         
         Swift.print(error)
      }
      return nil
   }
   
   override class func objectFromString(_ string: String) -> [String : AnyObject]? {
      let s = string as NSString
      return s.propertyList() as? [String : AnyObject]
   }
}
