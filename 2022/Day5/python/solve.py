import os
import re

def parse_stacks(lines):
    stacks = {}
    for line in reversed(lines):
        regex = re.compile('(?:\[(.)\] ?|    ?)', re.DOTALL)
        crates = regex.findall(line)
        for i, crate in enumerate(crates):
            if stacks.get(i + 1) == None:
                stacks[i + 1] = []
            if crate != '':
                stacks[i + 1].append(crate)
    return stacks

def part1(lines):
    crate_definition_lines = []
    instructions = []
    for line in lines:
        if line == "\n":
            continue

        if line.startswith('move'):
            regex = re.compile('move (\d+) from (\d+) to (\d+)')
            matches = regex.match(line).groups()
            instruction = {
                'count': int(matches[0]),
                'from': int(matches[1]),
                'to': int(matches[2])
            }
            instructions.append(instruction)
        else:
            crate_definition_lines.append(line)

    # We don't care about the labels
    crate_definition_lines.pop()
    stacks = parse_stacks(crate_definition_lines)

    for instruction in instructions:
        for count in range(instruction['count']):
            item = stacks[instruction['from']].pop()
            stacks[instruction['to']].append(item)

    top_crates = []

    for i in stacks:
        stack = stacks[i]
        top_crates.append(stack[len(stack) - 1])
    
    return ''.join(top_crates)


def part2(lines):
    crate_definition_lines = []
    instructions = []
    for line in lines:
        if line == "\n":
            continue

        if line.startswith('move'):
            regex = re.compile('move (\d+) from (\d+) to (\d+)')
            matches = regex.match(line).groups()
            instruction = {
                'count': int(matches[0]),
                'from': int(matches[1]),
                'to': int(matches[2])
            }
            instructions.append(instruction)
        else:
            crate_definition_lines.append(line)

    # We don't care about the labels
    crate_definition_lines.pop()
    stacks = parse_stacks(crate_definition_lines)

    for instruction in instructions:
        temp = []
        for count in range(instruction['count']):
            temp.append(stacks[instruction['from']].pop())

        temp.reverse()
        stacks[int(instruction['to'])] += temp

    top_crates = []

    for i in stacks:
        stack = stacks[i]
        top_crates.append(stack[len(stack) - 1])
    
    return ''.join(top_crates)


dirname = os.path.dirname(__file__)
filename = os.path.join(dirname, '../input.txt')
with open(filename) as f:
    lines = f.readlines()

print(part1(lines))
print(part2(lines))
