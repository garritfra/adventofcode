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

  games = lines.map((line) => {
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

console.log(part1(input));
