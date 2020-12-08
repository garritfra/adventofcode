use std::collections::HashMap;
use std::iter::FromIterator;

///
/// FIXME
///
fn main() {
    let contents =
        std::fs::read_to_string("input.txt").expect("Something went wrong reading the file");
    let lines: Vec<String> = contents.lines().map(|x| x.to_string()).collect();

    println!("Part 1: {:?}", first(lines.clone()));
    println!("Part 1: {:?}", first(lines.clone()));
}

fn first(lines: Vec<String>) -> usize {
    let bags_map: HashMap<String, Vec<String>> = lines
        .into_iter()
        .map(|line| {
            let mut parts = line
                .split(" contain ")
                .map(|x| x.to_string())
                .collect::<Vec<String>>();
            parts[0].pop();
            (
                parts[0].to_string(),
                parts[1]
                    .split(", ")
                    .map(|x| x.to_string())
                    .collect::<Vec<String>>(),
            )
        })
        .collect();
    dbg!(&bags_map);

    let bags = bags_map.into_iter().map(|x| x);

    for line in lines {}

    0
}

fn contains(bags: Vec<String>, bag: String) -> bool {}
