import os, shutil
path = r"C:/Users/austi/OneDrive/Desktop/Alex the Analyst DS Bootcamp/Python/File Sorter/"
file_name = os.listdir(path)

folder_names = ["csv files", "images", "audio"]

for loop in range(0,3):
    if not os.path.exists(path + folder_names[loop]):
        os.makedirs(path + folder_names[loop])

for file in file_name:
    if ".csv" in file and not os.path.exists(path + "csv files/" + file):
        shutil.move(path + file, path + "csv files/" + file)
    elif ".png" in file and not os.path.exists(path + "images/" + file):
        shutil.move(path + file, path + "images/" + file)
    elif ".jpg" in file and not os.path.exists(path + "images/" + file):
        shutil.move(path + file, path + "images/" + file)
    elif ".mp3" in file and not os.path.exists(path + "music/" + file):
        shutil.move(path + file, path + "audio/" + file)

