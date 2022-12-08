from collections import defaultdict
from functools import reduce
import os
import re
from operator import mul


def column(matrix, i):
    return [row[i] for row in matrix]


def part1(lines: list[str]):
    visible_trees = []
    grid = [
        list(line.replace("\n", "")) for line in lines
    ]

    for y, col in enumerate(grid):
        for x, tree in enumerate(col):
            up = column(grid, x)[:y]
            down = column(grid, x)[y + 1:]
            left = grid[y][:x]
            right = grid[y][x + 1:]

            if len(up) <= 0 or len(down) <= 0 or len(left) <= 0 or len(right) <= 0:
                visible_trees.append(tree)
                continue

            up.sort(reverse=True)
            down.sort(reverse=True)
            left.sort(reverse=True)
            right.sort(reverse=True)
            if up[0] < tree or down[0] < tree or left[0] < tree or right[0] < tree:
                visible_trees.append(tree)
            pass
    return len(visible_trees)


def part2(lines):
    highest_score = 0
    grid = [
        list(line.replace("\n", "")) for line in lines
    ]

    for y, col in enumerate(grid):
        for x, tree in enumerate(col):
            up = column(grid, x)[:y]
            down = column(grid, x)[y + 1:]
            left = grid[y][:x]
            right = grid[y][x + 1:]

            # Adjust viewing angle
            left.reverse()
            up.reverse()

            trees_visible = {
                "up": 0,
                "down": 0,
                "left": 0,
                "right": 0,
            }

            for i, other in enumerate(up):
                trees_visible["up"] += 1
                if other >= tree:
                    break
            for i, other in enumerate(down):
                trees_visible["down"] += 1
                if other >= tree:
                    break
            for i, other in enumerate(left):
                trees_visible["left"] += 1
                if other >= tree:
                    break
            for i, other in enumerate(right):
                trees_visible["right"] += 1
                if other >= tree:
                    break

            score = trees_visible["up"] * trees_visible["down"] * \
                trees_visible["left"] * trees_visible["right"]

            if score > highest_score:
                highest_score = score
    return highest_score


dirname = os.path.dirname(__file__)
filename = os.path.join(dirname, '../input.txt')
with open(filename) as f:
    lines = f.readlines()

print(part1(lines))
print(part2(lines))
