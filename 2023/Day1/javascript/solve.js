const fs = require("node:fs");

const input = fs
  .readFileSync("../input.txt", "utf8")
  .split("\n")
  .filter((line) => line !== "");

const isDigit = (x) => /\d/.test(x);

const part1 = (lines) => {
  const digits = lines.map((line) => line.split("").filter(isDigit));
  return digits
    .map((line) => Number.parseInt(line[0] + line[line.length - 1]), 10)
    .reduce((acc, curr) => acc + curr, 0);
};

console.log(part1(input));
