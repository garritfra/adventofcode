const fs = require("node:fs");
const path = require("node:path");

const input = fs
  .readFileSync(path.join(__dirname, "../input.txt"), "utf8")
  .split("\n")
  .filter((line) => line !== "");

const play = (time, record) => {
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

  let result = 1;

  for (let i = 0; i < times.length; i++) {
    const distance = distances[i];
    const time = times[i];

    const strategies = play(time, distance);

    result *= strategies.length;
  }

  return result;
};

console.log(part1(input));
