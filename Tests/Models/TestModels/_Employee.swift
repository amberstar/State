/************************************************

        WARNING: MACHINE GENERATED FILE

 ************************************************/
import Foundation
import State

public struct Employee : Model {
    public var name: String
    public var title: String?

}

extension Employee : Decodable {

   public static func decode(decoder: Decoder) -> Employee? {
      return self.init(decoder: decoder)
   }

    public init?(decoder d: Decoder) {
        var decoder = d
        decoder = Employee.performMigrationIfNeeded(decoder)

         guard
            let name: String = decoder.decode("name")
         else { return  nil }

        let title: String? = decoder.decode("title")

        self.name = name
        self.title = title
        didFinishDecodingWithDecoder(decoder)
    }
}

extension Employee : Encodable {

    public func encode(encoder: Encoder) {
        encoder.encode(name, "name")
        encoder.encode(title, "title")

        Employee.encodeVersionIfNeeded(encoder)

        self.willFinishEncodingWithEncoder(encoder)
    }
}

extension Employee {

    /// These are provided from the data model designer
    /// and can be used to determine if the model is
    /// a different version.
    public static func modelVersionHash() -> String {
        return "<a7d3395e 2571c3cc f97901e5 26580a8c a813984e e25ffdd4 40813f22 16357528>"
    }

    public static func modelVersionHashModifier() -> String? {
        return nil
    }
}

extension NSUserDefaults {

   //****************************************************************************//
   // MARK: NSUserDefault Getters
   //****************************************************************************//

   public func getEmployee(key: String) -> Employee? {
      guard let dictionary = dictionaryForKey(key) else { return nil }
      return Employee.decode(dictionary)
   }

   public func getEmployee(key: String) -> [Employee]? {
      guard let array = arrayForKey(key) else { return nil }
      return sequence(array.map(Employee.decode))
   }

   public func getEmployee(key: String) -> [String : Employee]? {
      guard let dictionary = dictionaryForKey(key) else { return nil }
      return sequence(dictionary.map { Employee.decode($0) })
   }

   public func getEmployee(key: String, defaultValue: Employee) -> Employee {
      return getEmployee(key) ?? defaultValue
   }

   public func getEmployee(key: String, defaultValue: [Employee]) -> [Employee] {
      return getDecodable(key) ?? defaultValue
   }

   public func getEmployee(key: String,  defaultValue: [String : Employee]
   ) -> [String : Employee] {
      return getEmployee(key) ?? defaultValue
   }

   //****************************************************************************//
   // MARK: NSUserDefault Setters
   //****************************************************************************//

   public func setEmployee(value: Employee, forKey key: String) {
      setObject(value.encode(), forKey: key)
   }

   public func setEmployee(value: [Employee], forKey key: String) {
      setObject(value.map { $0.encode() }, forKey: key)
   }

   public func setEmployee(value: [String : Employee], forKey key: String) {
      setObject(value.map { $0.encode() }, forKey: key)
   }
}

extension KVStore {

   public func getEmployee(key: String) -> Employee? {
      return getValue(key)
   }

   public func getEmployee(key: String, defaultValue: Employee) -> Employee {
      return getEmployee(key) ?? defaultValue
   }

   public func getEmployees(key: String) -> [Employee]? {
      return getValue(key)
   }

   public func getEmployees(key: String, defaultValue: [Employee]) -> [Employee] {
      return getEmployees(key) ?? defaultValue
   }

   public func getEmployeeDictionary(key: String) -> [String : Employee]? {
      return getValue(key)
   }

   public func getEmployeeDictionary(key: String, defaultValue: [String : Employee]) -> [String : Employee] {
      return getEmployeeDictionary(key) ?? defaultValue
   }
}

