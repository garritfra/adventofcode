from os import path


def solve(line, min_different):
    for i, _ in enumerate(line):
        if i < min_different - 1: continue
        if len(set(line[i:i+min_different])) == min_different: return i + min_different

with open(path.join(path.dirname(__file__), '../input.txt')) as f:
    line = f.readline()

print(solve(line, 4), solve(line, 14))
