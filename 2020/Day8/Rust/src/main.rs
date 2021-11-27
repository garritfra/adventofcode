use std::collections::HashSet;

fn main() {
    let contents =
        std::fs::read_to_string("input.txt").expect("Something went wrong reading the file");
    let lines: Vec<String> = contents.lines().map(|x| x.to_string()).collect();

    println!("Part 1: {:?}", first(lines.clone()));
    println!("Part 1: {:?}", first(lines.clone()));
}

fn first(lines: Vec<String>) -> i32 {
    let mut accumulator: i32 = 0;
    let mut seen = HashSet::new();

    let mut bp = 0;

    loop {
        let line = &lines[bp];
        if seen.contains(&bp) {
            return accumulator;
        }
        seen.insert(bp);

        let components = line.chars();
        let instruction: String = components.clone().take(3).collect();
        let op: String = components.clone().skip(4).take(1).collect();
        let value: String = components
            .clone()
            .skip(5)
            .take_while(|x| x != &' ')
            .collect();

        println!("{} {} {}", instruction, op, value);

        match instruction.as_ref() {
            "nop" => bp += 1,
            "acc" => {
                match op.as_str() {
                    "+" => accumulator += value.parse::<i32>().unwrap(),
                    "-" => accumulator -= value.parse::<i32>().unwrap(),
                    _ => panic!(),
                };
                bp += 1
            }
            "jmp" => match op.as_str() {
                "+" => bp += value.parse::<usize>().unwrap(),
                "-" => bp -= value.parse::<usize>().unwrap(),
                _ => panic!(),
            },
            _ => panic!("Should not occur"),
        }
    }
}

fn second(lines: Vec<String>) -> usize {
    0
}
