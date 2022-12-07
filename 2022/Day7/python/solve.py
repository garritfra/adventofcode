import os
import re

dirs = {}
current_dir = "/"

def eval_command(command: str, output: list[str]):
    global dirs, current_dir
    if command.startswith('cd'):
        path = command.split(' ')[1]
        current_dir = os.path.abspath(os.path.join(current_dir, path))
        if dirs.get(current_dir) == None:
            dirs[current_dir] = {}
    if command == 'ls':
        for line in output:
            if re.compile('\d+').match(line):
                size = int(line.split(' ')[0])
                filename = line.split(' ')[1]
                dirs[current_dir][filename] = size


    pass

def calculate_dir_sizes(lines):
    i = 0
    while len(lines) > i:
        line = lines[i]
        if line.startswith('$'):
            command = line.split('$ ')[1].replace("\n", "");
            i += 1
            output = []
            while len(lines) > i:
                if lines[i].startswith('$'): break
                output.append(lines[i].replace('\n', ''))
                i += 1
            eval_command(command, output)

    dir_sizes = {}

    for path in dirs:
        subpaths = []
        filesize = 0
        for pathb in dirs:
            if pathb.startswith(path):
                subpaths.append(pathb)
        for subpath in subpaths:
            files = dirs[subpath]
            for file in files:
                filesize += int(files[file])
        dir_sizes[path] = filesize
    return dir_sizes

def part1(lines: list[str]):
    dir_sizes = calculate_dir_sizes(lines)

    small_dirs = {}

    for filepath in dir_sizes:
        if dir_sizes[filepath] < 100000:
            small_dirs[filepath] = dir_sizes[filepath]

    size_sum = 0
    for filepath in small_dirs:
        size_sum += small_dirs[filepath]
    return size_sum


def part2(lines):
    dir_sizes = calculate_dir_sizes(lines)
    min_size = 30000000
    used = 70000000 - dir_sizes['/']
    needed = min_size - used
    smallest = dir_sizes['/']

    for filepath in dir_sizes:
        size = dir_sizes[filepath]
        if size < smallest and size > needed:
            smallest = dir_sizes[filepath]

    return smallest


dirname = os.path.dirname(__file__)
filename = os.path.join(dirname, '../input.txt')
with open(filename) as f:
    lines = f.readlines()

print(part1(lines))
print(part2(lines))
