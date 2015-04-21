
/*******************************************************************************
Plist:

XML plist serialization

note: this is a subclass of Data, see Data.swift for full api

******************************************************************************/

public final class Plist: Data {
    
    override class func objectFromData(data: NSData) -> [String : AnyObject]? {
        var error: NSError?
        if let o: AnyObject =  NSPropertyListSerialization.propertyListWithData(data, options:.allZeros, format:nil, error: &error) {
            return o as? [String : AnyObject]
        } else {
            return nil
        }
    }
    
    override class func dataFromObject(object: [String : AnyObject], prettyPrint: Bool) -> NSData?  {
        var error: NSError?
        if NSPropertyListSerialization.propertyList(object, isValidForFormat: NSPropertyListFormat.XMLFormat_v1_0) {
            if let data: NSData? = NSPropertyListSerialization.dataWithPropertyList(object, format: NSPropertyListFormat.XMLFormat_v1_0, options: .allZeros, error: &error) {
                if let e = error {
                    println(error)
                }
                return data
            }
        }
        return nil
    }
    
    override class func objectFromString(string: String) -> [String : AnyObject]? {
        let s = string as NSString
        return s.propertyList() as? [String : AnyObject]
    }
}