import string

def writeLines(startrow, endrow, startcol, endcol, fileName):
    i = 0
    result = ""
    plotFile = open(fileName, "r")
    plotFile.readline()
    while i <= endrow - 2:
        dane = plotFile.readline()
        if i >= startrow - 2:
            dane = dane.strip()[startcol: endcol + 1]
            result += dane + "\n"
        i += 1
    plotFile.close()
    return result