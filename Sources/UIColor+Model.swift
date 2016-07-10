import UIKit

extension UIColor : Model {

    public static func read(from store: Store) -> Self? {

        if let
            red: CGFloat  = store.value(forKey: "red"),
            green: CGFloat = store.value(forKey: "green"),
            blue:  CGFloat  = store.value(forKey: "blue"),
            alpha: CGFloat = store.value(forKey: "alpha") {

           return self.init(red: red, green: green, blue: blue, alpha: alpha)
        }
        else {
            return nil
        }
    }

    public func write(to store: inout Store) {
        var red, green, blue, alpha  : CGFloat
        red = 0; green = 0; blue = 0; alpha = 0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        store.set(red, forKey: "red")
        store.set(green, forKey: "green")
        store.set(blue, forKey: "blue")
        store.set(alpha, forKey: "alpha")
    }
}
