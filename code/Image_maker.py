#Gcode to Image (ideal layer) maker

import os
import PRNTR
import shutil

path1 = PRNTR.location
bottom_range1 = PRNTR.bottom_range
bottom_range2 = int('{}'.format(bottom_range1))
print(bottom_range2)
top_range1 = PRNTR.top_range
top_range2 = int('{}'.format(top_range1))
print(top_range2)

namer = str("image_name")

def maker():

	# Print the current working directory
	print("Current working directory: {0}".format(os.getcwd()))

	# Change the current working directory
	os.chdir('{}'.format(path1))
	# Print the current working directory
	print("Current working directory: {0}".format(os.getcwd()))

	for x in range(bottom_range2,top_range2):

		number = int
		number = x
		number = int(number)
		image_name = 'Layer{}'.format(number)
		print('Layer{}'.format(number))

		os.system("python code/gcode_reader.py -t 1 files/Layer/{}.gcode -l 1".format(image_name))
		# This runs the gcode reader and saves the image file in PRNTR --> files --> Layer --> ideal

		def copy():
			src = '{}/files/Layer/ideal/{}.jpg'.format(path1, namer)
			dst =  '{}/files/Layer/ideal/{}.jpg'.format(path1, image_name)
			shutil.copyfile(src, dst) 
			# Copys the ideal file and renames it

		copy()

if __name__ == '__main__':
	maker()