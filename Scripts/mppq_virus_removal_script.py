import os

def renameFiles():

    for folderName in os.listdir('Data'):
        try:
            os.mkdir('Data/'+folderName+"/"+folderName)
        except:
            print("Folder already present")

        if(os.path.isdir('Data/'+folderName)):
            for filename in os.listdir('Data/'+folderName):
                correctFileName = filename[:-5]
                print(correctFileName)

                src = 'Data/'+folderName +"/"+ filename
                dst = 'Data/'+folderName + "/"+folderName+"/"+correctFileName
                if(not os.path.isdir(src)):
                    os.rename(src,dst)

if __name__ == '__main__':

    renameFiles()