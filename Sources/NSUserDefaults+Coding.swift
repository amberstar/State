import Foundation

extension UserDefaults {
   
   //****************************************************************************//
   // MARK: Getters
   //****************************************************************************//
   
   public func getDecodable<T: Decodable>(_ key: String) -> T? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return T.decode(dictionary)
   }
   
   public func getDecodable<T: Decodable>(_ key: String) -> [T]? {
      guard let array = array(forKey: key) else { return nil }
      return sequence(array.map(T.decode))
   }
   
   public func getDecodable<T: Decodable>(_ key: String) -> [String : T]? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return sequence(dictionary.map { T.decode($0) })
   }
   
   public func getDecodable<T: Decodable>(_ key: String, defaultValue: T) -> T {
      return getDecodable(key) ?? defaultValue
   }
   
   public func getDecodable<T: Decodable>(_ key: String, defaultValue: [T]) -> [T] {
      return getDecodable(key) ?? defaultValue
   }
   
   public func getDecodable<T: Decodable>(_ key: String,  defaultValue: [String : T]
      ) -> [String : T] {
      return getDecodable(key) ?? defaultValue
   }

   //****************************************************************************//
   // MARK: Setters
   //****************************************************************************//
   
   public func setEncodeable<V: Encodable>(_ value: V, forKey key: String) {
      set(value.encode(), forKey: key)
   }
   
   public func setValue<T: Encodable>(_ value: [T], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }
   
   public func setValue<T: Encodable>(_ value: [String : T], forKey key: String) {
       set(value.map { $0.encode() }, forKey: key)
   }
}
