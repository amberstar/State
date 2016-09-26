# State 

A Swift model framework for structs, enums, and protocols that you can design in Xcode Data Modeler.

A `Model` is a `Storable` that can be saved to a `Store`.

- [Reading and Writing Models](#reading-and-writing-models)
- [Version and Migration](#versioning-and-migration )
- [Xcode Data Modeler / Code Generator](CodeGen.md)



**Requirements**
- Swift 3.0
- Xcode 8.0
- iOS 8.0
- Mogenerator 1.28

---


# Reading and Writing Models

Models, and collections of models can be
  written to and read from files, `Strings`, or `Data`.

```swift
// save person to JSON
person.write(to: fileURL, format: .JSON)

// make a string
var jsonPerson = person.makeString(format: .JSON))

// make data
var dataPerson = person.makeData(format: .Plist)

// load person from JSON
let person = Person(file: fileURL, format: .JSON)

// create person from json string
let person = Person(content: jsonPerson)

// create person from plist data
let person = Person(content: dataPerson)

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
