#install Pillow (PIL Fork 9.0.0) before use - python imaging library

from PIL import Image, ImageEnhance
import time
import PRNTR

path1 = PRNTR.location

def IM():
	image = Image.open('{}/files/capture.jpg'.format(path1)) 
	#image.show()

	print(' ')
	print('Information about image -->')
	print(' ')
	# The file format of the source file.
	print('File format of source file: ', image.format) # Output: JPEG

	# The pixel format used by the image. Typical values are "1", "L", "RGB", or "CMYK."
	print('Pixel format of image: ', image.mode) # Output: RGB

	# Image size, in pixels. The size is given as a 2-tuple (width, height).
	print('Image size in pixels: ', image.size) # Output: (1920, 1280)

	# Colour palette table, if any.
	print('Colour palette: ', image.palette) # Output: None

	#Resizing
	size_image = image.resize((800, 800)) # here we change image to the size we want
	size_image.save('{}/files/new_test_resize.jpg'.format(path1))
	print('Original size: ', image.size) # Output: (1920, 1280)
	print('New size: ', size_image.size) # Output: (400, 400)

	# Cropping
	box = (100, 100, 440, 500) #(left, upper, right, lower).
	cropped_image = image.crop(box)
	cropped_image.save('{}/files/cropped_image.jpg'.format(path1))
	# Print size of cropped image
	print('Cropped Image size: ', cropped_image.size) # Output: (500, 300)

	# Image Rotating
	image_rot = image.rotate(16)
	image_rot.save('{}/files/image_rot.jpg'.format(path1))

	# Flipping the image
	image_flip = image.transpose(Image.FLIP_LEFT_RIGHT)
	image_flip.save('{}/files/flip.jpg'.format(path1)) 

	# Truning image into black and white
	greyscale_image = image.convert('L')
	greyscale_image.save('{}/files/greyscale_image.jpg'.format(path1))
	print('Image mode: ', greyscale_image.mode) # Output: L

	# Turning rezied image into black and white 
	greyscale_image2 = size_image.convert('L')
	greyscale_image2.save('{}/files/greyscale_image_resize.jpg'.format(path1))
	print('Image mode: ', greyscale_image2.mode) # Output: L

	# Splitting and Merging image bands
	red, green, blue = image.split()
	print('Red: ', red.mode) # Output: L
	print("Green: ", green.mode) # Output: L
	print('Blue: ', blue.mode) # Output: L
	new_image2 = Image.merge("RGB", (green, red, blue))
	new_image2.save('{}/files/new_image_color.jpg'.format(path1))
	print('New image mode: ', new_image2.mode) # Output: RGB

	#contrast
	contrast = ImageEnhance.Contrast(image)
	contrast.enhance(1.5).save('{}/files/contrast.jpg'.format(path1)) #change value, factor 1.0 is orginial image 

	#color
	color = ImageEnhance.Color(image)
	color.enhance(1.5).save('{}/files/color.jpg'.format(path1)) #use 0.0 for B/W

	#brightness
	brightness = ImageEnhance.Brightness(image)
	brightness.enhance(1.5).save('{}/files/brightness.jpg'.format(path1)) #0.0 is black

	#Sharpness
	sharpness = ImageEnhance.Sharpness(image)
	sharpness.enhance(1.5).save('{}/files/sharpness.jpg'.format(path1)) #0 -> 2

	#saving image as a new file format
	image.save('{}/files/new_test_format.png'.format(path1),'PNG')
	print(' ')

if __name__ == '__main__':
    IM()
