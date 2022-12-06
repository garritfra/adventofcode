import os


def solve(line, min_different):
    for i, _ in enumerate(line):
        if i < min_different - 1: continue

        chars = line[i:i+min_different]
        if len(set(chars)) == min_different:
            return i + min_different

dirname = os.path.dirname(__file__)
filename = os.path.join(dirname, '../input.txt')
with open(filename) as f:
    line = f.readline()

print(solve(line, 4))
print(solve(line, 14))
