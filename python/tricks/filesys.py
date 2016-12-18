import os

# iterate folders
def iterateFolders(rootDir):
    fileList = []

    for root, subFolders, files in os.walk(rootDir):
        if '.svn' in subFolders:
            subFolders.remove('.svn')
        for fi in files:
            if fi.find('.txt') != -1:
                filePath = os.path.join(root, file)
                fileList.append(filePath)

    return fileList

    