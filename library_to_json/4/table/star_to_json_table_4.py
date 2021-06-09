import math
import os

if __name__ == "__main__":
    rows = 52
    columns = 32
    file = open("../4.txt", 'r')
    lines = file.readlines()
    for i in range(1,rows + 1): # 0 1 2 ... 36
        for j in range(1,columns*2 + 1): # 0 2 4 ... 46
            if j % 2 == 0:
                continue
            if len(lines[i]) < j:
                break
            seatnum = int((i-1)*columns + math.ceil(j/2)) - 1
            if lines[i][j] == '&':
                print(f"\"{seatnum}\": {{\n\t\"is_table\": true\n\t}},")
            else:
                print(f"\"{seatnum}\": null,")
