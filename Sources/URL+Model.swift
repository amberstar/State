import Foundation

extension URL : Model {

    public static func read(from store: Store) -> URL? {
        if let value : String  = store.value(forKey: "URL") {
            return self.init(string: value)
        }
        else {
            return nil
        }
    }

    public func write(to store: inout Store) {
        store.set(self.absoluteString, forKey: "URL")
    }
}
