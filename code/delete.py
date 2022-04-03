#use this to delete files produced from PRNTR

import os
import PRNTR

path1 = PRNTR.location

def Delete():
    
    if os.path.exists("{}/files/operation.gcode".format(path1)):
        os.remove("{}/files/operation.gcode".format(path1))

    if os.path.exists("{}/files/Edgey.jpg".format(path1)):
        os.remove("{}/files/Edgey.jpg".format(path1))

    if os.path.exists("{}/files/new_test_format.png".format(path1)):
        os.remove("{}/files/new_test_format.png".format(path1))

    if os.path.exists("{}/files/sharpness.jpg".format(path1)):
        os.remove("{}/files/sharpness.jpg".format(path1))

    if os.path.exists("{}/files/brightness.jpg".format(path1)):
        os.remove("{}/files/brightness.jpg".format(path1))

    if os.path.exists("{}/files/color.jpg".format(path1)):
        os.remove("{}/files/color.jpg".format(path1))

    if os.path.exists("{}/files/contrast.jpg".format(path1)):
        os.remove("{}/files/contrast.jpg".format(path1))

    if os.path.exists("{}/files/new_image_color.jpg".format(path1)):
        os.remove("{}/files/new_image_color.jpg".format(path1))

    if os.path.exists("{}/files/greyscale_image.jpg".format(path1)):
        os.remove("{}/files/greyscale_image.jpg".format(path1))

    if os.path.exists("{}/files/greyscale_image_resize.jpg".format(path1)):
        os.remove("{}/files/greyscale_image_resize.jpg".format(path1))

    if os.path.exists("{}/files/image_rot.jpg".format(path1)):
        os.remove("{}/files/image_rot.jpg".format(path1))

    if os.path.exists("{}/files/cropped_image.jpg".format(path1)):
        os.remove("{}/files/cropped_image.jpg".format(path1))

    if os.path.exists("{}/files/new_test_resize.jpg".format(path1)):
        os.remove("{}/files/new_test_resize.jpg".format(path1))

    if os.path.exists("{}/files/capture.jpg".format(path1)):
        os.remove("{}/files/capture.jpg".format(path1))

    if os.path.exists("{}/files/flip.jpg".format(path1)):
        os.remove("{}/files/flip.jpg".format(path1))

    if os.path.exists("{}/files/inverts.jpg".format(path1)):
        os.remove("{}/files/inverts.jpg".format(path1))

    dir_name = "{}/code/".format(path1)
    test = os.listdir(dir_name)
    for item in test:
        if item.endswith(".gcode"):
            os.remove(os.path.join(dir_name, item))

    dir_name2 = "{}/files/Layer/".format(path1)
    test2 = os.listdir(dir_name2)
    for item2 in test2:
        if item2.endswith(".gcode"):
            os.remove(os.path.join(dir_name2, item2))

    dir_name3 = "{}/files/Layer/ideal/".format(path1) 
    test3 = os.listdir(dir_name3)
    for item3 in test3:
        if item3.startswith("Layer"):
            os.remove(os.path.join(dir_name3, item3))

    dir_name4 = "{}/files/Layer/diffs/".format(path1)
    test4 = os.listdir(dir_name4)
    for item4 in test4:
        if item4.startswith("Layer"):
            os.remove(os.path.join(dir_name4, item4))

    dir_name5 = "{}/files/Layer/skin/".format(path1)
    test5 = os.listdir(dir_name5)
    for item5 in test5:
        if item5.endswith(".gcode"):
            os.remove(os.path.join(dir_name5, item5))

if __name__ == '__main__':
    Delete()