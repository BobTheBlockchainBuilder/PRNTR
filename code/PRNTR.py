"""
This is for running the PRNTR's complete operation:
	What to do
		Place .stl file in the code folder
		Check path
		Check the correct camera operation is being used, if using computer use camera.py, if using py use os.systemm(...)
		Check camera.py if using computer --> if the cv2.videocapture is 0 then its builtin webcam, if its 1 then its the connected camera
		Check range values for number of layers --> change in bottomrange & toprange variables below
		Check that 'PRNTR/files/Layer/ideal/image_name.jpg' exists
		Check that 'PRNTR/files/Layer/diffs/diff.jpg' exists
		Run PRNTR.py
		Enter the STL filename
		Answer file deletion question
"""
import time
import os
import shutil
import os.path
import LayerNumber

start = time.time()

path = str('/Users/BobTheBlockchainBuilder/Desktop/PRNTR') #change path according to device
location = path

#Range values for the layers in the print used in:	LayerSplitter.py & Image_maker.py
bottomrange = int(0)
bottom_range = bottomrange
toprange = int(101)
top_range = toprange

#currentlayernumber = LayerNumber.numberiton #not working properly
currentlayernumber = 4

def main():
	location = path

	#Copies g code file from code file into files file and change name to operation.gcode so its easier to streamline the rest of the code
	stlname = str(input('Name of STL file: ')) #STL file has to be stored in code file
	os.system( 'mandoline -o {}.gcode -n {}.stl'.format(stlname, stlname) ) #this runs command in terminal to begin the slicer for the stl file with the name inputed and save the g-code of that file
	src = '{}/code/{}.gcode'.format(path, stlname)
	dst =  '{}/files/operation.gcode'.format(path)
	shutil.copyfile(src, dst) #Copys the gcode file into the files file and renames it to operation.gcode


	if os.path.exists('{}/files/operation.gcode'.format(location)):
		#Telling Layer Splitter operation to activate
		os.system('python LayerSplitter.py')

		#operation to trigger the skin maker 
		if os.path.exists("{}/files/Layer/Layer0.gcode".format(location)):
			os.system('python skin.py')

			# 	Operation to produce image files from the g code, to be used as an 'ideal image'
			if os.path.exists('{}/files/Layer/Layer0.gcode'.format(location)):
				os.system('python Image_maker.py')
			else:
				print('Error in splitted layer files or Image_maker')

		else:
			print('There is an error in the LayerSplitter or skin code')

	else:
		print('There is an error with the operation.gcode file')



	def CCO(): # CCO - Camera & Comparison Operation

		"""
		#CAMERA
		#	using python find a way to see what layer is being printed at that specific moment in time
		#Layer_number = (layer being printed, which will be read from the printers 'website') 
		if(Layer_number%5==0):
			os.system('python camera.py')
		else:
			print('Not capturing yet')

		#add code to check head is clear and camera can capture correctly
		"""

		# -------- Camera Operation --------	
		#	Camera operation; use camera.py for computer & fswebcam for Raspberry Pi
		os.system('python camera.py') #Use with Mac/Windows
		#os.system('fswebcam -r 1920x1080 --no-banner {}/files/capture.jpg'.format(location)) #Use with raspberry pi
		# -------- Camera Operation --------	

		#	Operation to verify that the file has been captured
		if os.path.exists('{}/files/capture.jpg'.format(location)):
			#	Operation to run Image_manipulation.py
			os.system('python Image_manipulation.py')

			#	Operation to verify Image_manipulation.py has occured 
			if os.path.exists('{}/files/new_test_resize.jpg'.format(location)):
				#	Operation to run edge.py
				os.system('python edge.py')

			
				#	Operation to verify that edge.py has been run
				if os.path.exists('{}/files/Edgey.jpg'.format(location)):
					print('Edgey exists!')
					#	Operation to run image comparison (for the layer file set it so the image with 'Layer{}' file name is the one used for comparison)
					os.system('python ImageComparison2.py')
					# *show comparison*
				else:
					print('There is an error in the ImageComparison file')
					
			else:
				print('There is an error in the edge file, or the file names')

		else:
			print("There is an error in the Image_manipulation file")


	def delete():
		# Operation to delete files
		finish = input('The printing complete, do you want to delete the files? Yes or No --> ')
		if finish == "yes" or finish == "Yes" or finish == "y" or finish == "Y" or finish == "YES":
			print("The files will be deleted")
			os.system('python delete.py')
		elif finish == 'no' or finish == "NO" or finish == "No" or finish == "N" or finish == "n":
			print('Not Deleting')
		else:
			print("Could no understand answer")

		end = time.time()
		print('Time to run PRNTR code:', end - start, "seconds")
		print("")

	#	FLO needs to be fixed
	#	Send 5 Layers to printer then CCO 
	def FLO(): # FLO - five layer operation
		num = currentlayernumber
		div = int(5)
		if num%div == 0:
			CCO()
		elif num%toprange == 1: #doesnt work very well. needs to be redone because when using multiples of 5 it doesnt recgnise that it could also be the last layer
			print('Operation complete')
			delete()
		else:
			print("We have not reached that layer number yet!")
	#FLO() #if this is turned on. remove comand below "CCO()" | FLO causes the camera operation to occur when it is on a layer which is a multiple of 5
	

	CCO()
	delete()


if __name__ == '__main__':
	main()
	print("😃")
	print('')

#else: # this is used to main commands that will run when importing the file into another  
#	print('---')


