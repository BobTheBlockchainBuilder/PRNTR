#For raspbewrry pi, use the direct command to run it from terminal:
#"fswebcam -r 1920x1080 --no-banner /file_location/name.jgp"

import cv2
import imutils
import time
import PRNTR

path1 = PRNTR.location

def Camera():
    print("")
    cap = cv2.VideoCapture(0)
    ret, frame = cap.read()

    def takePicture():
        (grabbed, frame) = cap.read()
        showimg = frame
        #cv2.imshow('img1', showimg)  # display the captured image
        cv2.waitKey(1)
        time.sleep(0.3) # Wait 300 miliseconds
        cv2.imwrite('{}/files/capture.jpg'.format(path1), frame)
        cap.release()
        return("Image Captured")

    print(takePicture())
    print("")

if __name__ == '__main__':
    Camera()