#Spot
A swift model framework for using structs as your model layer. Design models using Xcode's Core Data model design tool. Model code is  generated automatically using [Mogenerator](https://github.com/rentzsch/mogenerator) and provides serialization to and from Plists, XML Plists, or JSON.

####Key Features: 

- Swift struct based models
- design model objects and enums in the Xcode model designer
- automatic model code generation
- immutable, optional, and non-optional properties 
- one-to-one, and one-to-many relationships to other models, and enums
- serialization to/from Plists and JSON 
- model versioning and migration setup for you, but you control
- make fast changes and additions to your model layer
- no heavy subclassing required

####System Requirements
- Swift 1.2
- Xcode 6.3
- iOS 8.0
- Mogenerator 1.28


##Getting Started

### 1. Adding Spot to your project

#### Using Carthage

[Carthage]: https://github.com/Carthage/Carthage

Add the following to your Cartfile:

```
github "amberstar/Spot"
```

Then run `carthage update`.

Follow the current instructions in [Carthage's README][carthage-installation]
for up to date installation instructions.

#### As a Submodule
1. Add Spot as a submodule by going to your project directory and enter the following:
	`git submodule add https://github.com/amberstar/Spot.git`
2. Open the Spot folder and drag and drop the Spot.xcodeproj into the file navigator of your workspace.

3. In Xcode, select the project icon to open the target window and select your host target that will use Spot.

4. Select the "Build Phases" tab in the target configuration window.

5. Add Spot as a target dependency to your host target

6. Click on the + button at the top left and select "New Copy Files Phase". Rename this new phase to "Copy Frameworks", set the "Destination" to "Frameworks", and add Spot.framework.

[carthage-installation]: https://github.com/Carthage/Carthage#adding-frameworks-to-an-application

### 2. [Install Mogenerator] (https://github.com/rentzsch/mogenerator)
[Mogenerator](https://github.com/rentzsch/mogenerator) is a command line tool that is easy to install and use. Mogenerator is used with the Spot templates to generate your model classes. 

You can download Mogenerator [here](http://rentzsch.github.io/mogenerator/), or to install using [homebrew](http://mxcl.github.com/homebrew)  use $ brew install mogenerator 

###3.  Set-up a target to automatically generate model code every time you build.

See [The Wiki Page for instructions] (https://github.com/amberstar/Spot/wiki/How-to-set-up-a-target-to-automatically-generate-model-code-every-time-you-build-your-host.)


###4. Learn More:
- [See the example project ](https://github.com/amberstar/Spot/tree/master/SpotExample)
- [See the Wiki](https://github.com/amberstar/Spot/wiki)







