import time
import PRNTR
import sys

path1 = PRNTR.location
bottom_range1 = PRNTR.bottom_range
bottom_range2 = int('{}'.format(bottom_range1))
print(bottom_range2)
top_range1 = PRNTR.top_range
top_range2 = int('{}'.format(top_range1))+1
print(top_range2)

def LS():
	for x in range(bottom_range2,top_range2):      
		number = int
		number2 = int
		number = x  #remeber to have number 1 larger than layer looking for because the layers of g-code start at 0
		number = int(number)
		number2  = 1
		Layernumber = number - number2
		print("")
		print('Layer number:', Layernumber)

		def LayerSplitter():
			with open('{}/files/operation.gcode'.format(path1), 'r') as file:
				layer = file.read().split(';LAYER:')
				print(layer[number])

		converted_Layernumber = str(Layernumber)
		#print('Layer'+converted_Layernumber+'.txt')
		string_in_string = "Layer{}.gcode".format(converted_Layernumber)
		print(string_in_string)
			 
		# Saving the reference of the standard output
		original_stdout = sys.stdout    
			 
		with open('{}/files/Layer/{}'.format(path1, string_in_string), 'w') as f: #change location you want the file saved
		    sys.stdout = f 
		    print('; Layer:', Layernumber)
		    LayerSplitter()
		    # Reset the standard output
		    sys.stdout = original_stdout 
			 
		print('Successfully saved {} file --------> :)'.format(string_in_string))

		#changing file to remove number/add semicolon
		def change():
			a_file = open('{}/files/Layer/{}'.format(path1, string_in_string), "r") #change location to same as previous one
			list_of_lines = a_file.readlines()
			list_of_lines[1] = "\n"

			a_file = open('{}/files/Layer/{}'.format(path1, string_in_string), "w") #change location to same as previous one
			a_file.writelines(list_of_lines)
			a_file.close()

		change()
		print('Successfully changed {} file ------> ;)'.format(string_in_string))
		print("")

if __name__ == '__main__':
	LS()
