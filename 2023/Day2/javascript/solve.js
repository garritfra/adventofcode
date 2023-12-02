const fs = require("node:fs");

const input = fs
  .readFileSync("../input.txt", "utf8")
  .split("\n")
  .filter((line) => line !== "");

const part1 = (lines) => {
  const allowed = {
    red: 12,
    green: 13,
    blue: 14,
  };

  const games = lines.map((line) => {
    const [game, results] = line.split(": ");
    const [raw, id] = game.match(/Game (\d+)/);

    const sets = results.split("; ");

    const possibleSets = sets.map((set) => {
      const colors = set.split(", ");
      return !colors.some((c) => {
        const [raw, amount, color] = c.match(/(\d+) ([a-z]*)/);
        return Number.parseInt(amount, 10) > allowed[color];
      });
    });
    return {
      id: Number.parseInt(id, 10),
      possible: possibleSets.every((set) => !!set),
    };
  });

  return games
    .filter(({ id, possible }) => (possible ? id : null))
    .reduce((sum, { id }) => sum + id, 0);
};

const part2 = (lines) => {
  const games = lines.map((line) => {
    const [game, results] = line.split(": ");
    const [raw, id] = game.match(/Game (\d+)/);

    const sets = results.split("; ");
    const highest = { red: 0, green: 0, blue: 0 };

    for (const set of sets) {
      const entries = set.split(", ");
      for (const entry of entries) {
        const [raw, amount, color] = entry.match(/(\d+) ([a-z]*)/);
        const amountParsed = Number.parseInt(amount, 10);
        if (amountParsed > highest[color]) {
          highest[color] = amountParsed;
        }
      }
    }
    return highest.red * highest.blue * highest.green;
  });

  return games.reduce((acc, curr) => acc + curr, 0);
};

console.log(part1(input));
console.log(part2(input));
