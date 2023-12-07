const fs = require("node:fs");
const path = require("node:path");

const input = fs
  .readFileSync(path.join(__dirname, "../input.txt"), "utf8")
  .split("\n")
  .filter((line) => line !== "");

const RANKS = "0123456789TJQKA";

const getValue = (hand) => {
  if (fiveOfAKind(hand)) return 6;
  if (fourOfAKind(hand)) return 5;
  if (fullHouse(hand)) return 4;
  if (threeOfAKind(hand)) return 3;
  if (twoPair(hand)) return 2;
  if (onePair(hand)) return 1;
  return 0;
};

const fiveOfAKind = (hand) => {
  const parsed = group(hand.split(""));
  return Object.values(parsed).some((rank) => rank.length == 5);
};

const fourOfAKind = (hand) => {
  const parsed = group(hand.split(""));
  return Object.values(parsed).some((rank) => rank.length == 4);
};

const fullHouse = (hand) => {
  const parsed = group(hand.split(""));
  return (
    Object.values(parsed).some((rank) => rank.length == 3) &&
    Object.values(parsed).some((rank) => rank.length == 2)
  );
};

const threeOfAKind = (hand) => {
  const parsed = group(hand.split(""));
  return Object.values(parsed).some((rank) => rank.length == 3);
};

const twoPair = (hand) => {
  const parsed = group(hand.split(""));
  return Object.values(parsed).filter((value) => value.length == 2).length == 2;
};

const onePair = (hand) => {
  const parsed = group(hand.split(""));
  return Object.values(parsed).filter((value) => value.length == 2).length == 1;
};

const group = (arr) =>
  arr.reduce((acc, cur) => {
    const firstLetter = cur[0].toLowerCase();
    return { ...acc, [firstLetter]: [...(acc[firstLetter] || []), cur] };
  }, {});

const part1 = (lines) => {
  const ranked = [[], [], [], [], [], [], []];
  for (const line of lines) {
    const [hand, bidStr] = line.split(" ");

    ranked[getValue(hand)].push(line);
  }

  const sorted = ranked.map((rank) =>
    rank.sort((a, b) => {
      for (let i = 0; i < a.length; i++) {
        if (RANKS.indexOf(a[i]) < RANKS.indexOf(b[i])) {
          return -1;
        } else if (RANKS.indexOf(a[i]) > RANKS.indexOf(b[i])) {
          return 1;
        }
      }

      return 0;
    })
  );

  return sorted
    .flat()
    .map((hand, i) => {
      const [_, bidStr] = hand.split(" ");
      const bid = Number.parseInt(bidStr);
      return bid * (i + 1); // Index starts at 0
    })
    .reduce((acc, curr) => acc + curr, 0);
};

console.log(part1(input));
