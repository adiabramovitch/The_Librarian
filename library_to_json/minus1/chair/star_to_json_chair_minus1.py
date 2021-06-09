import math

if __name__ == "__main__":
    rows = 36
    columns = 23
    file = open("minus1.txt", 'r')
    lines = file.readlines()
    for i in range(1,rows + 1): # 0 1 2 ... 36
        for j in range(1,columns*2 + 1): # 0 2 4 ... 46
            if j % 2 == 0:
                continue
            if len(lines[i]) < j:
                break
            seatnum = int((i-1)*columns + math.ceil(j/2)) - 1
            if lines[i][j] == '*':
                print(f"\"{seatnum}\": {{\n\t\"seat_index\": {seatnum},\n\t\"state\": true,\n\t\"user\": \"\",\n\t\"startDate\": 0\n\t}},")
            else:
                print(f"\"{seatnum}\": {{\n\t\"seat_index\": null\n\t}},")
