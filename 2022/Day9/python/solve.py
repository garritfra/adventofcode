from collections import defaultdict
from functools import reduce
import os
import re


def column(matrix, i):
    return [row[i] for row in matrix]


def part1(lines: list[str]):
    grid = defaultdict()
    pos_head = (0, 0)
    pos_tail = (0, 0)

    grid[pos_head] = True
    for line in lines:
        parts = line.split()
        instruction = (parts[0], int(parts[1]))

        for i in range(instruction[1]):
            if instruction[0] == "R":
                pos_head = (pos_head[0] + 1, pos_head[1])
                delta = [x - y for x, y in zip(pos_head, pos_tail)]
                if abs(delta[0]) > 1 or abs(delta[1]) > 1:
                    pos_tail = (pos_tail[0] + 1, pos_tail[1] + delta[1])
            if instruction[0] == "L":
                pos_head = (pos_head[0] - 1, pos_head[1])
                delta = [x - y for x, y in zip(pos_head, pos_tail)]
                if abs(delta[0]) > 1 or abs(delta[1]) > 1:
                    pos_tail = (pos_tail[0] - 1, pos_tail[1] + delta[1])
            if instruction[0] == "U":
                pos_head = (pos_head[0], pos_head[1] + 1)
                delta = [x - y for x, y in zip(pos_head, pos_tail)]
                if abs(delta[0]) > 1 or abs(delta[1]) > 1:
                    pos_tail = (pos_tail[0] + delta[0], pos_tail[1] + 1)
            if instruction[0] == "D":
                pos_head = (pos_head[0], pos_head[1] - 1)
                delta = [x - y for x, y in zip(pos_head, pos_tail)]
                if abs(delta[0]) > 1 or abs(delta[1]) > 1:
                    pos_tail = (pos_tail[0] + delta[0], pos_tail[1] - 1)
            grid[pos_tail] = True
            pass

    return len(grid)


def part2(lines):
    pass


dirname = os.path.dirname(__file__)
filename = os.path.join(dirname, '../input.txt')
with open(filename) as f:
    lines = f.readlines()

print(part1(lines))
print(part2(lines))
