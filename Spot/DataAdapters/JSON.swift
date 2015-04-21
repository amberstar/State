
/*******************************************************************************
JSON:

json serialization

note: this is a subclass of Data, see Data.swift for full api

******************************************************************************/

public final class JSON: Data {
    
     override class func objectFromData(data: NSData) -> [String : AnyObject]? {
        var error: NSError?
        if let o: AnyObject =  NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &error) {
            return o as? [String : AnyObject]
        } else {
            return nil
        }
    }
    
      override class func dataFromObject(object: [String : AnyObject], prettyPrint: Bool) -> NSData?  {
        var error: NSError?
        if NSJSONSerialization.isValidJSONObject(object) {
            let options: NSJSONWritingOptions = prettyPrint ? .PrettyPrinted : .allZeros
            let data: NSData? = NSJSONSerialization.dataWithJSONObject(object, options: options, error: &error)
            if let e = error {
                println(error)
            }
            return data
        }
        return nil
    }
}