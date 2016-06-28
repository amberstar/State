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

   public static func decode(_ decoder: Decoder) -> Employee? {
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
        didFinishDecoding(decoder: decoder)
    }
}

extension Employee : Encodable {

    public func encode(_ encoder: Encoder) {
        encoder.encode(name, "name")
        encoder.encode(title, "title")

        Employee.encodeVersionIfNeeded(encoder)

        self.willFinishEncoding(encoder: encoder)
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

//****************************************************************************//
// MARK: UserDefaults support
//****************************************************************************//
extension UserDefaults {

   public func getEmployee(forKey key: String) -> Employee? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return Employee.decode(dictionary)
   }

   public func getEmployee(forKey key: String) -> [Employee]? {
      guard let array = array(forKey: key) else { return nil }
      return sequence(array.map(Employee.decode))
   }

   public func getEmployee(forKey key: String) -> [String : Employee]? {
      guard let dictionary = dictionary(forKey: key) else { return nil }
      return sequence(dictionary.map { Employee.decode($0) })
   }

   public func getEmployee(forKey key: String, defaultValue: Employee) -> Employee {
      return getEmployee(forKey: key) ?? defaultValue
   }

   public func getEmployee(forKey key: String, defaultValue: [Employee]) -> [Employee] {
      return getDecodable(key) ?? defaultValue
   }

   public func getEmployee(forKey key: String,  defaultValue: [String : Employee]) -> [String : Employee] {
      return getEmployee(forKey: key) ?? defaultValue
   }

   public func setEmployee(value: Employee, forKey key: String) {
      set(value.encode(), forKey: key)
   }

   public func setEmployee(value: [Employee], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }

   public func setEmployee(value: [String : Employee], forKey key: String) {
      set(value.map { $0.encode() }, forKey: key)
   }
}

//****************************************************************************//
// MARK: KVStore support
//****************************************************************************//
extension KVStore {

   public func getEmployee(forKey key: String) -> Employee? {
      return getValue(forKey: key)
   }

   public func getEmployee(forKey key: String, defaultValue: Employee) -> Employee {
      return getEmployee(forKey: key) ?? defaultValue
   }

   public func getEmployees(forKey key: String) -> [Employee]? {
      return getValue(forKey: key)
   }

   public func getEmployees(forKey key: String, defaultValue: [Employee]) -> [Employee] {
      return getEmployees(forKey: key) ?? defaultValue
   }

   public func getEmployeeDictionary(forKey key: String) -> [String : Employee]? {
      return getValue(forKey: key)
   }

   public func getEmployeeDictionary(forKey key: String, defaultValue: [String : Employee]) -> [String : Employee] {
      return getEmployeeDictionary(forKey: key) ?? defaultValue
   }
}

