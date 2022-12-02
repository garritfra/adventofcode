import os


def part1(lines):
    score = 0
    for line in lines:
        move_opponent = line.split(' ')[0]
        move_player = line.split(' ')[1].replace('\n', '')

        if move_opponent == 'A':    # Rock
            if move_player == 'X':      # Rock
                score += 1 + 3
            if move_player == 'Y':      # Paper
                score += 2 + 6
            if move_player == 'Z':      # Scissors
                score += 3 + 0
        if move_opponent == 'B':    # Paper
            if move_player == 'X':      # Rock
                score += 1 + 0
            if move_player == 'Y':      # Paper
                score += 2 + 3
            if move_player == 'Z':      # Scissors
                score += 3 + 6
        if move_opponent == 'C':    # Scissors
            if move_player == 'X':      # Rock
                score += 1 + 6
            if move_player == 'Y':      # Paper
                score += 2 + 0
            if move_player == 'Z':      # Scissors
                score += 3 + 3
    
    return score

def part2(lines):
    score = 0
    for line in lines:
        move_opponent = line.split(' ')[0]
        move_player = line.split(' ')[1].replace('\n', '')

        if move_opponent == 'A':    # Rock
            if move_player == 'X':      # Lose (Scissors)
                score += 3 + 0
            if move_player == 'Y':      # Draw (Rock)
                score += 1 + 3
            if move_player == 'Z':      # Win (Paper)
                score += 2 + 6
        if move_opponent == 'B':    # Paper
            if move_player == 'X':      # Lose (Rock)
                score += 1 + 0          
            if move_player == 'Y':      # Draw (Paper)
                score += 2 + 3          
            if move_player == 'Z':      # Win (Scissors)
                score += 3 + 6
        if move_opponent == 'C':    # Scissors
            if move_player == 'X':      # Lose (Paper)
                score += 2 + 0          
            if move_player == 'Y':      # Draw (Scissors)
                score += 3 + 3          
            if move_player == 'Z':      # Win (Rock)
                score += 1 + 6
    
    return score


dirname = os.path.dirname(__file__)
filename = os.path.join(dirname, '../input.txt')
with open(filename) as f:
    lines = f.readlines()

print(part1(lines))
print(part2(lines))