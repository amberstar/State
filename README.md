# State 

A Swift model framework for structs, enums, and protocol models stored as plist, json, or binary files.

## 

**Requirements**
- Swift 3.0
- Xcode 8.0
- iOS 8.0
- Mogenerator 1.28

## Creating Models
Code models manually or use the Xcode Data Modeler to generate code. (see [Xcode Data Modeler / Code Generator Docs](https://github.com/amberstar/State/blob/abstract-store/Codegen.md) )

### Example model

```swift
public struct Employee : Model {
    public var name: String
    public var title: String?
}

extension Employee  {

    public init?(with source: Store) {
        // optionally migrate the store before reading model.
        let store = Employee.migrate(source: source)

        // in this gaurd block we look for all required properties.
        guard let 
            name: String = store.value(forKey: "name") 
        else { return  nil }

        let title: String? = store.value(forKey: "title")
        self.name = name
        self.title = title

        // optionally read more meta-data here.
        finishReading(from: store)
    }

    public func write(to store: inout Store) {

        store.set(name, forKey: "name")
        store.set(title, forKey: "title")
        Employee.writeVersion(to: &store)

        // optionally write a version or other meta-data.
        finishWriting(to: &store)
    }
}

```

## Reading and Writing Models

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
     opportunity to write version information to the output.

  * `static func migrate(from: Store) -> Store`

     This method is called before reading a model to give the model
     an opportunity to migrate the store. In this method:

    -  read the version information from the store
    -  compare the version information with the "current version"
    -  add, remove, and update keys, and values to the store
    -  return the updated store

## Automatic code generation setup.

If you want to automaticly update the model code each time you build your project do the following.

1. In your Xcode project, select `file > new > target`, and under OS X select other. Choose "External Build System" and click next.

2. give your target a name such as "GenerateModels" and hit finish.

3. select your project in the project navigator and select the new target you just added

4. under the info tab for the target set up the "External Build Tool Configuration" as follows:

Build Tool: `/usr/local/bin/mogenerator`  
	(or where ever mogenerator is installed. (type `which mogenerator` in terminal to 	find the location)


Arguments:
	--model `<path to your .xcdatamodeld file>` --swift --template-path `<path to states template folder>` --output-dir `<path to save model code files>`

5. Select the target that you want to use the model entities in, and select `Build Phases` and twist open the `Target Dependencies` section at the top.

6. Click plus to add a dependency, select the GenerateModels target.
	This will tell Xcode to build your GenerateModels target before building the host target.

7. The first time you generate the code files you will have to manually add them to the project.

You should now be able to add entities to the data modeler, and the code files should generate each time you build. If not, check the issue or report navigator to investigate the cause.
