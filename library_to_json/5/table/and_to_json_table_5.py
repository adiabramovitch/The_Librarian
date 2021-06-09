import math
import os

if __name__ == "__main__":
    rows = 28
    columns = 14
    file = open("5.txt", 'r')
    lines = file.readlines()
    for i in range(1,rows + 1): # 0 1 2 ... 29
        for j in range(1,columns*2 + 1): # 1 2 3 ... 20
            if j % 2 == 0:
                continue
            if len(lines[i]) < j:
                break
            seatnum = int((i-1)*columns + math.ceil(j/2)) - 1
            if lines[i][j] == '*':
                print(f"\"{seatnum}\": {{\n\t\"seat_index\": {seatnum},\n\t\"state\": true,\n\t\"user\": \"\",\n\t\"startDate\": 0\n\t}},")
            else:
                print(f"\"{seatnum}\": {{\n\t\"seat_index\": null\n\t}},")
