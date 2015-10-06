#How to set up a target to automatically generate model code every time you build your project.

If you do not have STState framework, or mogenerator installed do that first. 
 
1. In your Xcode project, select `file > new > target`, and under OS X select other. Choose "External Build System" and click next.

2. give your target a name such as "GenerateModels" and hit finish.

3. select your project in the project navigator and select the new target you just added

4. under the info tab for the target set up the "External Build Tool Configuration" as follows:

	#####Build Tool: `/usr/local/bin/mogenerator`  
	(or where ever mogenerator is installed. (type `which mogenerator` in terminal to 	find the location)
	

	#####Arguments:
	--model `<path to your .xcdatamodeld file>` --swift --template-path `<path to states template folder>` --output-dir `<path to save model code files>`

	#####example: 
If state is installed in a subdirectory of your project, and you had a models folder for your models, it would look something like this: --model $(SRCROOT)/ProjectName/Models/Model.xcdatamodeld --swift --template-path $(SRCROOT)/../STState/Templates --output-dir $(SRCROOT)/ProjectName/Models/

5. Select the target that you want to use the model entities in, and select `Build Phases` and twist open the `Target Dependencies` section at the top. 

6. Click the plus to add a dependency and select the GenerateModels target you just created earlier. 
	This will tell Xcode to build your GenerateModels target before building the host target.
	
7. The first time you generate the code files you will have to manually add them to the project.

You should now be able to add entities to the data modeler, and the code files should generate each time you build. If not, check the issue or report navigator to investigate the cause.
