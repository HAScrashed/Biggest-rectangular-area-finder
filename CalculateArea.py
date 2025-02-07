import sys
import ReadQuadriangle

class Range:
    def __init__(self, left, right, multiplier):
        self.left = left
        self.right = right
        self.multiplier = multiplier

    def area(self):
        return self.multiplier * (self.right - self.left + 1)

    def __str__(self):
        return "<" + str(self.left) + " , " + str(self.right) + ">"

    def __repr__(self):
        return "<" + str(self.left) + " , " + str(self.right) + ">"+str(self.multiplier)

    def __eq__(self, other):
        if self.left == other.left and self.right == other.right:
            return True
        return False


def isInRange(item, other):
    if item.left >= other.left and item.right <= other.right:
        return True
    return False


def doCut(item, other):
    if item.left >= other.left and item.right <= other.right:
        return False
    if item.right < other.left or item.left > other.right:
        return False
    return True


def cutRange(item, other):
    newLeft = max(item.left, other.left)
    newRight = min(item.right, other.right)
    m = item.multiplier+1
    return Range(newLeft, newRight, m)

def listRightIndex(alist, value):
    return len(alist) - alist[-1::-1].index(value) - 1

def obliczPole():
    try:
        inp = ""
        inp += str(sys.argv[1])
        plotFile = open(inp, "r")
    except:
        return inp + " ERROR file not found"

    data = plotFile.readline().strip().split()
    line = [int(x) for x in data]
    size = line[0]
    listOfRanges = []
    biggestArea = 0
    start = True
    coord = [-1, -1, -1, -1]

    for k in range(size):
        data = plotFile.readline().strip()
        line = [int(x) for x in data]
        keepInList = []

        previous = list(listOfRanges)
        listOfRanges.clear()

        i = 0
        while i < size:
            if line[i] == 0:
                left = i
                found = False
                j = i+1
                while j < size and line[j] == 0:
                    right = j
                    found = True
                    j += 1
                if not found:
                    right = i
                i = j

                listOfRanges.append(Range(left, right, 1))

            i += 1

        # remove those ranges from list that don't have continuation after update of the list
        if start: #don't remove in first iteration
            start = False
        else:
            ran = 0
            for p in previous:
                removed = True
                for another in listOfRanges:
                    if p.left > another.right:
                        continue
                    if p.right < another.left:
                        break

                    if isInRange(p, another):
                        p.multiplier += 1
                        keepInList.append(p)
                        removed = False
                        break

                    if doCut(p, another):
                        new = cutRange(p, another)
                        if listOfRanges.count(new) > 0:
                            id = listOfRanges.index(new)
                            if new.multiplier > listOfRanges[id].multiplier:
                                listOfRanges[id] = new
                        else:
                            keepInList.append(new)
                if removed and p.area() > biggestArea:
                    coord = [k + 2 - p.multiplier, k + 1, p.left, p.right]
                    biggestArea = p.area()
                ran += 1

        for actual in listOfRanges:
            if keepInList.count(actual) == 0:
                keepInList.append(actual)
            else:
                id = keepInList.index(actual)
                if keepInList[id].multiplier < actual.multiplier:
                    keepInList[id].multiplier = actual.multiplier

        listOfRanges = list(keepInList)
        keepInList.clear()
        
    while len(listOfRanges) > 0:
        ran = listOfRanges.pop()
        if ran.area() > biggestArea:
            coord = [size+2-ran.multiplier, size+1, ran.left, ran.right]
            biggestArea = ran.area()

    plotFile.close()
    plotFile = open(str(sys.argv[2])+"result.txt", "w")
    plotFile.write("Biggest rectangular area: " + str(biggestArea))
    plotFile.close()

    info = "\n\nMax area has been found in "
    if max(coord) != -1:
        #print(str(coord[0]) + "-" + str(coord[1]) + "\t / \t" + str(coord[2]+1) + "-" + str(coord[3]+2))
        info += "ROW " + str(coord[0]) + "-" + str(coord[1]) + " / COL " + str(coord[2]+1) + "-" + str(coord[3]+2)

    info += "\nWith following shape:\n\n" + ReadQuadriangle.writeLines(coord[0],coord[1], coord[2], coord[3], str(sys.argv[1]))

    plotFile = open(str(sys.argv[2])+"result.txt", "a")
    plotFile.write(info)
    plotFile.close()

obliczPole()