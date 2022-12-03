import os
import string


def part1(lines):
    prio_sum = 0
    for line in lines:
        items = [c for c in line if c != '\n']
        rucksack = {
            'left': items[0:int(len(line) / 2)],
            'right': items[int(len(line)/2):len(line)]
        }

        duplicate = None

        for il in rucksack['left']:
            if il in rucksack['right'] and not duplicate:
                duplicate = il
        prio_sum += string.ascii_letters.index(duplicate) + 1
    return prio_sum


def part2(lines):
    prio_sum = 0
    for i in range(0, len(lines), 3):
        groups = [g.replace('\n', '') for g in lines[i: i + 3]]

        badge = set(groups[0]).intersection(groups[1], groups[2]).pop()

        prio_sum += string.ascii_letters.index(badge) + 1
    
    return prio_sum
        


dirname = os.path.dirname(__file__)
filename = os.path.join(dirname, '../input.txt')
with open(filename) as f:
    lines = f.readlines()

print(part1(lines))
print(part2(lines))
