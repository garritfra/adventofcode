import os
import string


def part1(lines):
    count = 0
    for line in lines:
        elves = line.split(',')

        elve1_range = elves[0].replace('\n', '').split('-')
        elve1 = set(range(int(elve1_range[0]), int(elve1_range[1]) + 1))

        elve2_range = elves[1].replace('\n', '').split('-')
        elve2 = set(range(int(elve2_range[0]), int(elve2_range[1]) + 1))

        diff = elve1.intersection(elve2)

        if diff == elve1 or diff == elve2:
            count += 1

    return count


def part2(lines):
    count = 0
    for line in lines:
        elves = line.split(',')

        elve1_range = elves[0].replace('\n', '').split('-')
        elve1 = set(range(int(elve1_range[0]), int(elve1_range[1]) + 1))

        elve2_range = elves[1].replace('\n', '').split('-')
        elve2 = set(range(int(elve2_range[0]), int(elve2_range[1]) + 1))

        diff = elve1.intersection(elve2)

        if len(diff) > 0:
            count += 1

    return count



dirname=os.path.dirname(__file__)
filename=os.path.join(dirname, '../input.txt')
with open(filename) as f:
    lines=f.readlines()

print(part1(lines))
print(part2(lines))
