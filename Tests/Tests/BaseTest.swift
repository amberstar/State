import XCTest

public extension Optional {
   
   public func apply<U>(_ f: ((Wrapped) -> U)?) -> U? {
      return f.flatMap { self.map($0) }
   }
}

class Test : XCTestCase {
    let plistFile: AnyObject? = Test.plist(fromFile: "Data")
    var  plistData : [String : AnyObject] = [:]
    let jsonFile: AnyObject? = Test.JSON(fromFile: "Data")
    var jsonData : [String : AnyObject] = [:]
    
    class func plist(fromFile file: String) -> AnyObject? {
        let path = Bundle(for: self).pathForResource(file, ofType: "plist")
        
        if let p = path {
            if let dict = NSDictionary(contentsOfFile: p) {
                return dict
            }
            if let arr = NSArray(contentsOfFile: p) {
                return arr
            }
        }
        return .none
    }
    
    class func JSON(fromFile file: String) -> AnyObject? {
        let path = Bundle(for: self).pathForResource(file, ofType: "json")
        
        if path != nil {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path!)) {
                do {
                    return try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0))
                } catch _ {
                    return nil
                }
            }
        }
        return .none
    }
    
     func bundlePathFor(_ file: String, ofType type: String) -> String?  {
        return Bundle(for: Test.self ).pathForResource(file , ofType:type)
    }
    
    func bundleURLFor(_ file: String, ofType type: String) -> URL? {
        guard let path = bundlePathFor(file, ofType: type) else { return nil }
        return URL(fileURLWithPath: path)
    }
    
     func tempPathFor(_ file: String) -> String {
        return NSString.path(withComponents: [NSTemporaryDirectory(), file])
    }
    
    func tempURLFor(_ file: String) -> URL {
        return URL(fileURLWithPath: tempPathFor(file))
    }
    
     func clearTempData() {
        let fileManager = FileManager.default
        let enumerator = fileManager.enumerator(atPath: NSTemporaryDirectory())
        while let file = enumerator?.nextObject() as? String {
            do {
                try fileManager.removeItem(at: try! URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(file))
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
