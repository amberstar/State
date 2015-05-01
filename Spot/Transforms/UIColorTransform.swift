import UIKit

public final class UIColorTransform: ValueTransform {
    public typealias ValueType = UIColor
    public typealias TransformedType = [String : CGFloat]
    
    public static func  transform(value: ValueType?) -> TransformedType? {
        if let color = value {
            var colorValues = [String : CGFloat]()
            var red, green, blue, alpha  : CGFloat
            red = 0; green = 0; blue = 0; alpha = 0
            color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            colorValues["red"] = red
            colorValues["green"] = green
            colorValues["blue"] = blue
            colorValues["alpha"] = alpha
            return colorValues
        }
        return nil
    }
    
    public static func reverseTransform(value: AnyObject?) -> ValueType? {
        if let colorValues = value as? [String : CGFloat],
        red = colorValues["red"], green = colorValues["green"], blue = colorValues["blue"], alpha = colorValues["alpha"]{
            return UIColor(red: red, green: green, blue: blue, alpha: alpha)
        }
        return nil
    }
}
