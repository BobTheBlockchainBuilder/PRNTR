# PRNTR
# Real time error detection of 3D Printer using optical monitoring 

This is a program which is supposed to perform real time error detection &amp; monitoring of 3D prints in a hybrid manufacturing system (additive and subtractive), using optical monitoring from a camera in top down view.


# Theoretical Explaination:	
The software system is run off a raspberry pi connected to the duet2 mainboard of the device and a camera installed on the top. This raspberry pi is preset with all the python packages/programs required to run the system.
The system begins with an STL file containing the model of the part to be printed. This file is stored in the exact location as the other python files (inside the codes folder). The hybrid manufacturing machine software is then launched by setting the directory to the code file and launching PRNTR.py, which will immediately ask for user input, asking what the name of the STL file is that you want to manufacture. This will then launch the slicer and slice the file to produce the g-code according to the parameters that have been preset into the slicer. After which, the layer splitter will activate and take the g-code file and split it up into files naming each one by the layer it is in; during this process, the code also comments out the layer number in the file that has been added so as not to affect the machining code, an example can be seen in the figure X below. The G-code is then made into an image for each layer and saved to be used when required. An example of the first layer of an octopus print generated from this g-code reader can be seen in figure X below.
Once the g-code is made, the first five layers will be sent to the printer to begin the additive operation. Once five layers are printed, the homing code will be triggered, where it can also change tools if need be. The tool change will be decided using the data acquisition system. The camera will be activated when the print head is far enough away from the print, and image capture will be taken. This image capture will then run through an image manipulation script that has been designed to reduce as much noise as possible and increase the quality as much as possible. The manipulated file will then have edge detection run on it, and the “Edgey” file will be used to compare the actual print to the ‘ideal’ print. The comparison files of the additive process will then be saved and displayed on the screen; it will show a black and white image used to segment the correct parts and the parts which are not. The additive comparison files will then be used to test how much error there is on a percentage scale by comparing the black and white pixel numbers; if there is less than a 5% error, then it will proceed to the next set of layers that need to be printed with additive. If the error is more than 5%, then the comparison file will be implemented to the CAM operation, which will produce a subtractive toolpath according to the black/white regions; this toolpath will then be sent to the printer, where the subtractive operation will occur. After the subtractive operation is complete, the tool head will head home and change tools, which is when the subsequent five layers of the additive process will be sent to the printer for it to be worked on. When the head is homing, a check will run to see if the head is clear and not obstructing the view of the print. If this parameter is valid, the data acquisition system will be activated again, running until a subtractive operation comparison image is made. The image is then sent to the screen to be displayed, the before n. This loop will keep occurring up until the entire print has been completed, which will then ask the user if they are done with the print and would like to delete the files or not. During this entire process, verifications will be made when files are required to be used after they are made; this is to make sure the program runs correctly in the proper order and not to bring up problems during execution—a visual representation of this explanation in the software flowchart.


#Mandoline Py instructions

	Mandoline Py

		To validate the model:
			mandoline testcube.stl

		To slice:
			mandoline -o testcube.gcode testcube.stl

		To slice without validation:
			mandoline -o testcube.gcode -n testcube.stl

		To show configurations:
			mandoline --show-configs

		To show configurations with descriptions:
			mandoline --help-configs

		To change configurations:
			mandoline -S layer_height=0.3 -w #w means it changes the defualt configurations 

		To show file in GUI:
			mandoline -g testcube.stl

		To query a value:
			mandoline -Q layer_height


#Gcode_reader instructions

(use number 2 for this project)

		# G-code Reader
		A Gcode visualization and analysis tool written in Python 3. It supports FDM G-Code, Stratasys G-Code and PBF G-Code. It can print a single layer, print multiple layers. It also can animate the printing of a single layer or multiple layers.

		**Usage**

		In order to use this program, you need to use -t to specify G-Code type: 1 for regular G-Code, 2 for Stratasys G-Code, 3 for PBF G-Code.

		1. Plot a part in 3D. 
			Example:
			python src/gcode_reader.py -t 1 gcode/fdm_regular/octo.gcode -p
				(doesnt work with modified script in code file, need to remove the part making it save as image (at the end of the script))

		2. Plot a single layer of a part in 2D
   			Example (use -l to specify layer number):
   			python src/gcode_reader.py -t 1 gcode/fdm_regular/octo.gcode -l 1
   
		3. Animate the printing process of a single layer in 2D
			Example (use -a to specify layer number)
   			python src/gcode_reader.py -t 1 gcode/fdm_regular/tweety.gcode -a 1
				(doesnt work with modified script in code file, need to remove the part making it save as image (at the end of the script))

