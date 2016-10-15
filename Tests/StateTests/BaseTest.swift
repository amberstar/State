import Foundation
import XCTest
@testable import State

precedencegroup ChainingPrecedence {
    associativity: left
    higherThan: TernaryPrecedence
}

infix operator >>- : ChainingPrecedence
infix operator -<< : ChainingPrecedence

/**
 flatMap a function over an optional value (left associative)
 
 - If the value is .None, the function will not be evaluated and this will return .None
 - If the value is .Some, the function will be applied to the unwrapped value
 
 - parameter f: A transformation function from type T to type Optional<U>
 - parameter a: A value of type Optional<T>
 
 - returns: A value of type Optional<U>
 */
public func >>-<T, U>(a: T?, f: (T) -> U?) -> U? {
    return a.flatMap(f)
}

public extension Optional {
    
    public func apply<U>(_ f: ((Wrapped) -> U)?) -> U? {
        return f.flatMap { self.map($0) }
    }
}

// MARK: - BASE TEST

class Test : XCTestCase {
    let plistFile: AnyObject? = Test.plist(fromFile: "Data")
    var plistData : [String : AnyObject] = [:]
    let jsonFile: Any? = Test.JSON(fromFile: "Data")
    var jsonData : [String : AnyObject] = [:]
    
    class func plist(fromFile file: String) -> AnyObject? {
        let path = Bundle(for: self).path(forResource: file, ofType: "plist")
        
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
    
    class func JSON(fromFile file: String) -> Any? {
        let path = Bundle(for: self).path(forResource: file, ofType: "json")
        
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
        return Bundle(for: Test.self ).path(forResource: file , ofType:type)
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
                try fileManager.removeItem(at: URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(file))
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
