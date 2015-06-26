#State Model Framework Documentation:


###Contents:
- [Getting Started] (#getting-started)
- [Model Design Reference](Reference.md)
- [Enum Design Guide](Enums.md)
- [How to Setup a target in your project to automatically generate your models](Setup.md)
- [Version and Migration Management](#versioning-and-migration)




##Getting Started
The process of creating models is:

1.  Design the models in Xcode's data model tool
2.  Run the model design file through mogenerator using the state templates
3.  Add the State framework and the model files to the project

![diagram1](https://cloud.githubusercontent.com/assets/84623/7788560/f75d1d42-020d-11e5-9243-1be48e959cee.png)
  
## Designing the model in the Xcode model design tool

####Create the model design file
1. In the project select file new, and select Core Data.
2. Select Data Model and click next.
3. Give the model a name and click the create button.
4. In the project navigator select the model design file.
5. In the Xcode menu select View > Utilities > Show File Inspector
6. In the file inspector uncheck any target membership
7. Open the model design file and add the entities, attributes, and relationships you want in the model layer.

In the modeler elements correspond to the model as follows:
* Entity == Struct || Enum
* Entity.Attribute == property || if Enum == case
* One-One Relationship == composition
* One-Many Relationship == \[composition\] (array)
* Enum Relationship == Enum Type property

See the [Data Model Design Reference](Reference.md) for more information.

## Generating model code with Mogenerator

####Install Mogenerator

Mogenerator is used to generate the model code with the State templates. You can download Mogenerator [here](http://rentzsch.github.io/mogenerator/), or to install using [homebrew](http://mxcl.github.com/homebrew)  type `$ brew install mogenerator ` into the terminal.

####Get the State template files
If you downloaded the State project the templates are located in the [Templates](https://github.com/STLabs/State/tree/master/Templates) directory.

####Run Mogenerator on the model design using the templates
Type the following in to terminal to generate the model code files.

```
mogenerator --model <$path to the .xcdatamodeld file> --swift --template-path <$path to the state templates directory> <$path to the output directory>
```

## About the model code files

Two files for each entity in the model design are generated when you run Mogenerator.
- _Model.swift
- Model.swift  

The file with the underscore prefix is the automatic file, and the other is the manual file. The automatic file is updated every time you regenerate the code after modifying the model design file. The manual file is only generated once the first time you generate code. Therefore the manual file is not overwritten and is safe for you to use for extending the models via. a swift extension.

The manual file serves the following purposes:

- extend the model code via a swift extension in this file
- hook in to the encoding and decoding process, so you can read and write additional data during decoding and encoding if needed.
- manage the versioning and migration of the models if and when needed.

##Adding the code files and State framework to your project.

####Adding the State  framework to your project

####Using Carthage

[Carthage]: https://github.com/Carthage/Carthage

Add the following to your project's Cartfile:

```
github "STLabs/State" ~> 0.1
```

Then run `carthage update`.

Follow the current instructions in [Carthage's README][carthage-installation]
for up to date installation instructions.

####As a Submodule
1. Add State as a submodule by going to your project directory and enter the following:
	`git submodule add https://github.com/STLabs/State.git`
2. Open the State folder and drag and drop the State.xcodeproj into the file navigator of your workspace.

3. In Xcode, select the project icon to open the target window and select your host target that will use State.

4. Select the "Build Phases" tab in the target configuration window.

5. Add State as a target dependency to the host target

6. Click on the + button at the top left and select "New Copy Files Phase". Rename this new phase to "Copy Frameworks", set the "Destination" to "Frameworks", and add State.framework.

[carthage-installation]: https://github.com/Carthage/Carthage#adding-frameworks-to-an-application

####Adding the code files
Drag the model code files in to your project to add them.


####Set up a target to automatically generate model code every time you build

If you would like to make changes to your model as you are working and automate updating the code
see [How to set up a target to automatically generate model code every time you build.] (Setup.md)


##Serialization
Serialization of Models is easy with State:


#### Read and write models to JSON or PLISTS :


```swift
// Encode model and write out to a JSON file
issues.save(.JSON, path: "issues.json")

// Encode model and write out to a binary Plist file
issues.save(.Binary, path: "issues.plist")

// Encode model and write out to a XML Plist file
issues.save(.Plist, path: "issues.plist")
```

```swift
// Read JSON and decode model
let loadedIssues =  Issues(.JSON, path: "issues.json")

// Read binary Plist and decode model
let loadedIssues = Issues(.Binary, path: "issues.plist")

// Read XML Plist and decode model
let loadedIssues = Issues(.Plist, path: "issues.plist")
```


## Versioning and Migration  
Versioning and migration management is opt in. It allows you to fully control the version and migration of the models. The automatic layer of the model code passes delegation to the manual layer.  It's in the manual layer that you  specify and control all of the following:
- if models should be versioned when encoded
- a versionKey to use for the version encoding
- the current version of the model
- if version checking and migration is done at all
- does a model need migration
- directly migrate raw key-value data to the current version before attempting to read a model

When designing the models in the model designer, you can specify a version hash modifier signifying a new model version. This version modifier get's carried over to the model code so you can determine if a model version about to be decoded is a different version than the current version of the model code.


Have a question? Please [open an issue](https://github.com/STLabs/State/issues/new)



