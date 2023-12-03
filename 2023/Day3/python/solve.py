from pathlib import Path
import re

def has_adjacent_symbol(matrix, i, start, end):
    pattern = re.compile("[0-9\.]")
    # Left
    if start > 0 and matrix[i][start - 1] != "." and not bool(pattern.match(matrix[i][start - 1])):
        return True
    # Right
    if end < len(matrix[i]) and matrix[i][end] != "." and not bool(pattern.match(matrix[i][end])):
        return True

    # Above
    if i > 0:
        above = matrix[i - 1][max(0, start - 1):min(len(matrix[i]), end + 1)]
        for sym in above:
            if not bool(pattern.match(sym)) and sym != ".":
                return True

    # Below
    if i < len(matrix) - 1:
        below = matrix[i + 1][max(0, start - 1):min(len(matrix[i]), end + 1)]
        for sym in below:
            if not bool(pattern.match(sym)) and sym != ".":
                return True

    return False


def part1(lines):
    matrix = [list(line) for line in lines]
    engine_parts = []

    for i, line in enumerate(matrix):
        j = 0
        while j < len(line):
            if line[j].isdigit():
                start = j
                while j < len(line) and line[j].isdigit():
                    j += 1
                end = j

                if has_adjacent_symbol(matrix, i, start, end):
                    number = int("".join(line[start:end]))
                    engine_parts.append(number)
            else:
                j += 1

    return sum(engine_parts)


with (Path(__file__).parent / "../input.txt").open() as f:
    lines = list(map(lambda l: l.strip(), f.readlines()))
    print(part1(lines))