"""
For raspberry pi use:
import sys
sys.path.append('/home/pi/.local/lib/python3.9/site-packages')
"""

import cv2 as cv
import numpy as np
from PIL import Image, ImageEnhance
import time
import PRNTR

path1 = PRNTR.location
def ED():
	#Canny edge detector

	#load birds image
	image = cv.imread("{}/files/new_test_size.jpg".format(path1))

	#convert to gray image
	gray_image = cv.cvtColor(image, cv.COLOR_BGR2GRAY)

	#detect edges
	canny_edges = cv.Canny(gray_image, 120, 150) #change numbers to filter out the backgroud and adjust

	sobel_x_edges = cv.Sobel(gray_image, cv.CV_64F,1, 0)
	sobel_y_edges = cv.Sobel(gray_image, cv.CV_64F,0, 1)

	#convert all -ve pixels to positives
	sobel_x_edges = np.uint8(np.absolute(sobel_x_edges))
	sobel_y_edges = np.uint8(np.absolute(sobel_y_edges))

	#show edges
	#cv.imshow("Canny Edges", canny_edges)
	cv.imwrite("{}/files/Edgey.jpg".format(path1), canny_edges) #save the image file

	#show images
	#cv.imshow("Sobel X Edges", sobel_x_edges)
	#cv.imshow("Sobel y Edges", sobel_y_edges)

	#canny_edges.save('Canny_Edges.jpg')

	#dont put 0 because the 'program' wont stop running and you will be stuck in a loop and have to TERMINATE operation.
	cv.waitKey(5) 
	
	#cv.imwrite('sobel_x_edges', sobel_x_edges)
	#cv.imwrite('sobel_y_edges', sobel_y_edges)

	"""
		#Laplacian edge detector

		#detect gradients, edges
		lap_edges = cv.Laplacian(gray_image, cv.CV_64F)

		#convert all -ve pixels to positives
		lap_edges = np.uint8(np.absolute(lap_edges))

		cv.imshow("Laplacian Edges", lap_edges)

		#cv.imwrite("{}/files/edgey2.jpg".format(path1), lap_edges) #save the image file but make sure to use the location you want to save it to.
		cv.waitKey(0)

	"""

if __name__ == '__main__':
    ED()