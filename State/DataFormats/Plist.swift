import Foundation

/// XML Plist serialization format
public final class Plist: Binary {
    
    override class func objectFromData(data: NSData) -> [String : AnyObject]? {
        
        do {
            let o: AnyObject =  try NSPropertyListSerialization.propertyListWithData(data, options:[.MutableContainersAndLeaves], format:nil)
            return o as? [String : AnyObject]
        } catch let error as NSError {
            Swift.print(error)
            return nil
        }
    }
    
    override class func dataFromObject(object: [String : AnyObject], prettyPrint: Bool) -> NSData?  {
        
        guard NSPropertyListSerialization.propertyList(object, isValidForFormat: NSPropertyListFormat.XMLFormat_v1_0) else { return nil }
        
        do {
            let data: NSData? = try NSPropertyListSerialization.dataWithPropertyList(object, format: NSPropertyListFormat.XMLFormat_v1_0, options: .allZeros)
            return data
        } catch let error as NSError {
            Swift.print(error)
        }
        return nil
    }
    
    override class func objectFromString(string: String) -> [String : AnyObject]? {
        let s = string as NSString
        return s.propertyList() as? [String : AnyObject]
    }
}