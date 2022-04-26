from skimage.metrics import structural_similarity as compare_ssim
import argparse
import imutils
import cv2
from PIL import Image, ImageOps
import PRNTR
import LayerNumber

path1 = PRNTR.location

CLN = PRNTR.currentlayernumber
CLNpath = str("/files/Layer/ideal/Layer{}.jpg".format(CLN))
print(CLNpath) # passed on to imageB

def IC():
	
	# inverting the image that is camptured and is being used as imageA
	im = Image.open('{}/files/Edgey.jpg'.format(path1)).convert('RGB')
	im_invert = ImageOps.invert(im)
	im_invert.save('{}/files/inverts.jpg'.format(path1))

	# load the two input images
	imageA = cv2.imread('{}/files/inverts.jpg'.format(path1))
	imageB = cv2.imread('{}{}'.format(path1, CLNpath)) #when making it to compare to ideal image import imageB file name by comparing it to the layer we are on and adding that to 'Layer' so e.g. Layer10.jpg file is chosen

	# convert the images to grayscale
	grayA = cv2.cvtColor(imageA, cv2.COLOR_BGR2GRAY)
	grayB = cv2.cvtColor(imageB, cv2.COLOR_BGR2GRAY)
	(thresh, BWImage1) = cv2.threshold(grayA, 127, 255, cv2.THRESH_BINARY)
	(thresh, BWImage2) = cv2.threshold(grayB, 127, 255, cv2.THRESH_BINARY)
	#cv2.imshow("bw 1", BWImage1)
	#cv2.imshow("bw 2", BWImage2)
	# compute the Structural Similarity Index (SSIM) between the two
	# images, ensuring that the difference image is returned
	(score, diff) = compare_ssim(BWImage1, BWImage2, full=True)
	diff = (diff * 255).astype("uint8")
	print("SSIM: {}".format(score))

	# threshold the difference image, followed by finding contours to
	# obtain the regions of the two input images that differ
	thresh = cv2.threshold(diff, 0, 255, cv2.THRESH_BINARY_INV | cv2.THRESH_OTSU)[1]
	cnts = cv2.findContours(thresh.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
	cnts = imutils.grab_contours(cnts)

	# loop over the contours
	for c in cnts:
		# compute the bounding box of the contour and then draw the
		# bounding box on both input images to represent where the two
		# images differ
		(x, y, w, h) = cv2.boundingRect(c)
	cv2.rectangle(imageA, (x, y), (x + w, y + h), (0, 0, 255), 2)
	cv2.rectangle(imageB, (x, y), (x + w, y + h), (0, 0, 255), 2)
	# show the output images
	#cv2.imshow("Original", imageA)
	#cv2.imshow("Modified", imageB)
	cv2.imwrite('{}/files/Layer/diffs/diff.jpg'.format(path1), diff) 
	#cv2.imshow("Thresh", thresh)
	cv2.waitKey(1)

if __name__ == '__main__':
    IC()