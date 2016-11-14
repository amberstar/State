# State 

State is a Swift model framework that supports struct, enum, and protocol models which can be stored as plist, json, or binary files. State provides a set of custom mogenerator code templates allowing models to be designed in the Xcode data modeler, and automatic code generation.

Key features: 
- Struct models
- Enum models (including case, raw value, and associated value types including other models)
- Protocol models (including protocol inheritance)
- One-to-one, or one-to-many relationships between models
- Version and migration
- Automatic code generation from an Xcode data model

For more information see:  [Xcode Data Modeler / Code Generator Docs](https://github.com/amberstar/State/blob/master/Codegen.md) 

## 

**Requirements**
- Swift 3.0
- Xcode 8.0
- iOS 8.0
- Mogenerator 1.28

## Models
Code models manually or use the Xcode Data Modeler to generate code.
### Example Models
```swift
public struct Employee : Model {
    public var name: String
    public var title: String?
}

extension Employee  {

    public init?(with source: Store) {
        // optionally migrate the store before reading model.
        let store = Employee.migrate(source: source)

        // in this guard block we look for all required(non-optional) properties.
        guard let 
            name: String = store.value(forKey: "name") 
        else { return  nil }
        
        // read any optional properties.
        let title: String? = store.value(forKey: "title")
        self.name = name
        self.title = title

        // optionally read more metadata here.
        finishReading(from: store)
    }

    public func write(to store: inout Store) {
        store.set(name, forKey: "name")
        store.set(title, forKey: "title")
        Employee.writeVersion(to: &store)

        // optionally write other properties
        finishWriting(to: &store)
    }
}
```

### Reading and Writing Models

Models, and collections of models can be
  written to and read from files, `Strings`, or `Data`.

```swift
// write employee to JSON
employee.write(to: fileURL, format: .json) // .json, .plist, .binary support

// make a json string
var jsonString = employee.makeJson()

// make data
var data: Data = employee.makeData()

// create employee from file
let employee = Employee(jsonFile: fileURL) // plistFile, binaryFile api also
```

# Versioning and Migration
Versioning and migration is opt-in. Models do not version or migrate by default.

To support versioning and migration implement the following methods in your model extension:

  * `static func writeVersion(with: inout Store)`

     This method is called before writing a model is finished to give the model an
     opportunity to write version information to the store.

  * `static func migrate(from: Store) -> Store`

     This method is called before reading a model to give the model
     an opportunity to migrate the store. In this method:

    -  read the version information from the store
    -  compare the version information with the "current version"
    -  add, remove, and update keys, and values in the store as necessary
    -  return the updated store

# Adding State framework to your project.

## Carthage

[Carthage]: https://github.com/Carthage/Carthage

Add the following to your project's Cartfile:

```
github "STLabs/State" ~> 0.1
```

Then run `carthage update`.

Follow the current instructions in [Carthage's README][carthage-installation]
for up to date installation instructions.

## Submodule
1. Add State as a submodule by going to your project directory and enter the following:
`git submodule add https://github.com/STLabs/State.git`
2. Open the State folder and drag and drop the State.xcodeproj into the file navigator of your workspace.

3. In Xcode, select the project icon to open the target window and select your host target that will use State.

4. Select the "Build Phases" tab in the target configuration window.

5. Add State as a target dependency to the host target

6. Click on the + button at the top left and select "New Copy Files Phase". Rename this new phase to "Copy Frameworks", set the "Destination" to "Frameworks", and add State.framework.

[carthage-installation]: https://github.com/Carthage/Carthage#adding-frameworks-to-an-application



