def most_common(lst):
    return max(set(lst), key=lst.count)

def least_common(lst):
    return min(set(lst), key=lst.count)

# Part 1
with open("../input.txt") as f:
    lines = list(map(lambda l: l.strip(), f.readlines()))
    binaries = [[] for _ in list(lines[0])]

    for line in lines:
        for i, bit in enumerate(line):
            binaries[i].append(bit)

    gamma_bin = ""
    epsilon_bin = ""

    for column in binaries:
        print(column)
        gamma_bin += most_common(column)
        epsilon_bin += least_common(column)


    gamma = int(gamma_bin, 2)
    epsilon = int(epsilon_bin, 2)

    print(f"Gamma: {gamma}")
    print(f"Epsilon: {epsilon}")
    print(f"Gamma * Epsilon: {gamma * epsilon}")
    

# Part 2
with open("../input.txt") as f:
    lines = map(lambda l: l.strip(), f.readlines())