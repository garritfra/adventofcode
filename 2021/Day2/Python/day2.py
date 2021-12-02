# Part 1
with open("input.txt") as f:
    lines = map(lambda l: l.strip(), f.readlines())
    depth = 0
    horizontal = 0
    for line in lines:
        command = line.split(" ")[0]
        amount = int(line.split(" ")[1])

        if command == "forward":
            horizontal += amount
        elif command == "down":
            depth += amount
        elif command == "up":
            depth -= amount
    
    print("Part 1:")
    print(f"Horizontal Position: {horizontal}, Depth: {depth}")
    print(f"Product: {horizontal * depth}")

# Part 2
with open("input.txt") as f:
    lines = map(lambda l: l.strip(), f.readlines())
    aim = 0
    depth = 0
    horizontal = 0
    for line in lines:
        command = line.split(" ")[0]
        amount = int(line.split(" ")[1])

        if command == "forward":
            horizontal += amount
            depth += amount * aim
        elif command == "down":
            aim += amount
        elif command == "up":
            aim -= amount

    print("Part 2:")
    print(f"Horizontal Position: {horizontal}, Depth: {depth}")
    print(f"Product: {horizontal * depth}")