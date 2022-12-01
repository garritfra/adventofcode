def part1(lines):
    inventories = []
    current = []
    for line in lines:
        if line == '\n':
            inventories.append(current)
            current = []
            continue
        else:
            current.append(int(line))

    max_calories = 0

    for inventory in inventories:
        s = sum(inventory)
        if s > max_calories:
            max_calories = s

    return max_calories

def part2(lines):
    inventories = []
    current = []
    for line in lines:
        if line == '\n':
            inventories.append(current)
            current = []
            continue
        else:
            current.append(int(line))

    calories = []
    for inventory in inventories:
        calories.append(sum(inventory))
    
    calories.sort(reverse=True)
    return sum(calories[0:3])

with open('../input.txt') as f:
    lines = f.readlines()

print(part1(lines))
print(part2(lines))