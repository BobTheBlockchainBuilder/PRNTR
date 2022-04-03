# exports the skin gcode for each layer into their own skin layer files
import PRNTR
import shutil

path1 = PRNTR.location

bottom_range1 = PRNTR.bottom_range
bottom_range2 = int('{}'.format(bottom_range1))
print(bottom_range2)
top_range1 = PRNTR.top_range
top_range2 = int('{}'.format(top_range1))
print(top_range2)

def copi():
	for x in range(bottom_range2,top_range1): 

			number = int
			number = x
			number = int(number)
			image_name = 'Layer{}'.format(number)
			print('Layer{}'.format(number))

				
			def copy():
				src = '{}/files/Layer/{}.gcode'.format(path1, image_name)
				dst =  '{}/files/Layer/skin/{}.gcode'.format(path1, image_name)
				shutil.copyfile(src, dst) #Copys the file into the folder and renames it

			copy()

def skin():
	for x in range(bottom_range2,top_range2): 

		number = int
		number2 = int
		number = x  #remeber to have number 1 larger than layer looking for because the layers of g-code start at 0
		number = int(number)
		number2  = 0
		Layernumber = number - number2
		print("")
		print('Layer number:', Layernumber)

		converted_Layernumber = str(Layernumber)
		string_in_string = "Layer{}.gcode".format(converted_Layernumber)
		print(string_in_string)

		def erase(): #erases top
		    """
		    This function will delete all line from the givin start_key
		    until the stop_key. (include: start_key) (exclude: stop_key)
		    """
		    start_key = '; Layer:'
		    stop_key = ";TYPE:SKIN"
		    try: 
		        # read the file lines
		        with open('{}/files/Layer/skin/{}'.format(path1, string_in_string), 'r+') as fr: 
		            lines = fr.readlines()
		        # write the file lines except the start_key until the stop_key
		        with open('{}/files/Layer/skin/{}'.format(path1, string_in_string), 'w+') as fw:
		            # delete variable to control deletion
		            delete = True
		            # iterate over the file lines
		            for line in lines:
		                # check if the line is a start_key
		                # set delete to True (start deleting)
		                if line.strip('\n') == start_key:
		                     delete = True
		                # check if the line is a stop_key
		                # set delete to False (stop deleting)
		                elif line.strip('\n') == stop_key:
		                     delete = False
		                # write the line back based on delete value
		                # if the delete setten to True this will
		                # not be executed (the line will be skipped)
		                if not delete: 
		                    fw.write(line)
		    except RuntimeError as ex: 
		        print(f"erase error:\n\t{ex}")



		def erase2(): #erases bottom
		    """
		    This function will delete all line from the givin start_key
		    until the stop_key. (include: start_key) (exclude: stop_key)
		    """
		    start_key2 = ';MESH:NONMESH'
		    stop_key2 = ";TIME_ELAPSED:"
		    try: 
		        # read the file lines
		        with open('{}/files/Layer/skin/{}'.format(path1,string_in_string), 'r+') as fr: 
		            lines = fr.readlines()
		        # write the file lines except the start_key until the stop_key
		        with open('{}/files/Layer/skin/{}'.format(path1, string_in_string), 'w+') as fw:
		            # delete variable to control deletion
		            delete = False
		            # iterate over the file lines
		            for line in lines:
		                # check if the line is a start_key
		                # set delete to True (start deleting)
		                if line.strip('\n') == start_key2:
		                     delete = True
		                # check if the line is a stop_key
		                # set delete to False (stop deleting)
		                elif line.strip('\n') == stop_key2:
		                     delete = False
		                # write the line back based on delete value
		                # if the delete setten to True this will
		                # not be executed (the line will be skipped)
		                if not delete: 
		                    fw.write(line)
		    except RuntimeError as ex: 
		        print(f"erase error:\n\t{ex}")



		erase()
		erase2()
if __name__ == '__main__':
	copi()
	skin()
