import XCTest

public extension Optional {
   
   public func apply<U>(f: (Wrapped -> U)?) -> U? {
      return f.flatMap { self.map($0) }
   }
}

class Test : XCTestCase {
    let plistFile: AnyObject? = Test.plist(fromFile: "Data")
    var  plistData : [String : AnyObject] = [:]
    let jsonFile: AnyObject? = Test.JSON(fromFile: "Data")
    var jsonData : [String : AnyObject] = [:]
    
    class func plist(fromFile file: String) -> AnyObject? {
        let path = NSBundle(forClass: self).pathForResource(file, ofType: "plist")
        
        if let p = path {
            if let dict = NSDictionary(contentsOfFile: p) {
                return dict
            }
            if let arr = NSArray(contentsOfFile: p) {
                return arr
            }
        }
        return .None
    }
    
    class func JSON(fromFile file: String) -> AnyObject? {
        let path = NSBundle(forClass: self).pathForResource(file, ofType: "json")
        
        if path != nil {
            if let data = NSData(contentsOfFile: path!) {
                do {
                    return try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0))
                } catch _ {
                    return nil
                }
            }
        }
        return .None
    }
    
     func bundlePathFor(file: String, ofType type: String) -> String?  {
        return NSBundle(forClass: Test.self ).pathForResource(file , ofType:type)
    }
    
     func tempPathFor(file: String) -> String {
        return NSString.pathWithComponents([NSTemporaryDirectory(), file])
    }
    
     func clearTempData() {
        let fileManager = NSFileManager.defaultManager()
        let enumerator = fileManager.enumeratorAtPath(NSTemporaryDirectory())
        while let file = enumerator?.nextObject() as? String {
            do {
                try fileManager.removeItemAtURL(NSURL(fileURLWithPath: NSTemporaryDirectory()).URLByAppendingPathComponent(file))
            } catch _ {
            }
        }
    }
    
    override func setUp() {
        super.setUp()
         clearTempData()
        if let d = plistFile as? [String : AnyObject] {
            plistData = d
        }
        
        if let j = jsonFile as? [String : AnyObject] {
            jsonData = j 
        }
    }
}