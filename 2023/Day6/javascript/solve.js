const fs = require("node:fs");
const path = require("node:path");

const input = fs
  .readFileSync(path.join(__dirname, "../input.txt"), "utf8")
  .split("\n")
  .filter((line) => line !== "");

const calculateWinningStrategies = (time, record) => {
  const strategies = [];
  for (let i = 0; i < time; i++) {
    const speed = i;
    const calculatedTime = (time - speed) * speed;
    if (calculatedTime > record) {
      strategies.push(speed);
    }
  }

  return strategies;
};

const part1 = (lines) => {
  const play = (times, distances) => {
    let result = 1;

    for (let i = 0; i < times.length; i++) {
      const distance = distances[i];
      const time = times[i];

      const strategies = calculateWinningStrategies(time, distance);

      result *= strategies.length;
    }

    return result;
  };

  const times = lines[0]
    .split(":")[1]
    .trim()
    .split(/ +/)
    .map((num) => Number.parseInt(num.trim(), 0));

  const distances = lines[1]
    .split(":")[1]
    .trim()
    .split(/ +/)
    .map((num) => Number.parseInt(num.trim(), 0));

  return play(times, distances);
};

const part2 = (lines) => {
  const play = (times, distances) => {
    let strategies = [];

    const distance = distances[0];
    const time = times[0];

    return calculateWinningStrategies(time, distance).length;
  };
  const times = lines[0]
    .split(":")[1]
    .trim()
    .replace(/ +/g, "")
    .split()
    .map((num) => Number.parseInt(num.trim(), 0));

  const distances = lines[1]
    .split(":")[1]
    .trim()
    .replace(/ +/g, "")
    .split()
    .map((num) => Number.parseInt(num.trim(), 0));

  return play(times, distances);
};

console.log(part1(input));
console.log(part2(input));
