import Foundation

extension NSUserDefaults {
   
   //****************************************************************************//
   // MARK: Getters
   //****************************************************************************//
   
   public func getDecodable<T: Decodable>(key: String) -> T? {
      guard let dictionary = dictionaryForKey(key) else { return nil }
      return T.decode(dictionary)
   }
   
   public func getDecodable<T: Decodable>(key: String) -> [T]? {
      guard let array = arrayForKey(key) else { return nil }
      return sequence(array.map(T.decode))
   }
   
   public func getDecodable<T: Decodable>(key: String) -> [String : T]? {
      guard let dictionary = dictionaryForKey(key) else { return nil }
      return sequence(dictionary.map { T.decode($0) })
   }
   
   public func getDecodable<T: Decodable>(key: String, defaultValue: T) -> T {
      return getDecodable(key) ?? defaultValue
   }
   
   public func getDecodable<T: Decodable>(key: String, defaultValue: [T]) -> [T] {
      return getDecodable(key) ?? defaultValue
   }
   
   public func getDecodable<T: Decodable>(key: String,  defaultValue: [String : T]
      ) -> [String : T] {
      return getDecodable(key) ?? defaultValue
   }

   //****************************************************************************//
   // MARK: Setters
   //****************************************************************************//
   
   public func setEncodeable<V: Encodable>(value: V, forKey key: String) {
      setObject(value.encode(), forKey: key)
   }
   
   public func setValue<T: Encodable>(value: [T], forKey key: String) {
      setObject(value.map { $0.encode() }, forKey: key)
   }
   
   public func setValue<T: Encodable>(value: [String : T], forKey key: String) {
       setObject(value.map { $0.encode() }, forKey: key)
   }
}