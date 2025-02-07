import sys
import random

def generujDzialke(size, prob):
    file = str(sys.argv[1])
    plik = open(file, "w")
    plik.write(str(size))
    plik.write("\n")
    for _ in range(size):
        for _ in range(size):
            plik.write(str(random.choices([0,1],[prob,100-prob],k=1)[0]))
        plik.write("\n")
    plik.close()

generujDzialke(int(sys.argv[2]), int(sys.argv[3]))