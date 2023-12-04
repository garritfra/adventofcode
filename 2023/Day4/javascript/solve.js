const fs = require("node:fs");
const path = require("node:path");

const input = fs
  .readFileSync(path.join(__dirname, "../input.txt"), "utf8")
  .split("\n")
  .filter((line) => line !== "");

const part1 = (cards) => {
  const results = [];
  for (const card of cards) {
    const [_, winnindNumbersString, drawnNumbersString] =
      /Card +\d+: ([ \d]+) +\| +([ \d]+)/.exec(card);
    const winnindNumbers = winnindNumbersString
      .trim()
      .split(" ")
      .map((num) => Number.parseInt(num, 10))
      .filter((num) => !isNaN(num));

    const drawnNumbers = drawnNumbersString
      .trim()
      .split(" ")
      .map((num) => Number.parseInt(num, 10))
      .filter((num) => !isNaN(num));

    let matches = [];

    for (const num of drawnNumbers) {
      if (winnindNumbers.includes(num)) {
        matches.push(num);
      }
    }

    matches.length > 0 && results.push(2 ** (matches.length - 1));
  }

  return results.reduce((sum, curr) => sum + curr, 0);
};

console.log(part1(input));
