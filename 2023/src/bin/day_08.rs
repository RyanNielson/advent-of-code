use std::collections::HashMap;

use itertools::FoldWhile::{Continue, Done};
use itertools::Itertools;
use regex::Regex;

// For input lines use 2 item array instead of tuple so that it can be indexed into.
// There's a .cycle method on iterators to infinitely go through instructions just need to figure out how to early out when ZZZ is found.
fn part_1(input: &str) -> usize {
    let mut lines = input.lines();
    let instructions = lines
        .next()
        .unwrap()
        .chars()
        .map(|c| match c {
            'L' => 0usize,
            'R' => 1usize,
            _ => unreachable!(),
        })
        .collect_vec();

    let network = lines
        .skip(1)
        .map(|line| {
            let node_regex = Regex::new(r"(\w+) = \((\w+), (\w+)\)").unwrap();
            let captures = node_regex.captures(line).unwrap();

            (
                captures.get(1).unwrap().as_str(),
                [
                    captures.get(2).unwrap().as_str(),
                    captures.get(3).unwrap().as_str(),
                ],
            )
        })
        .collect::<HashMap<_, _>>();

    instructions
        .iter()
        .cycle()
        .fold_while(("AAA", 0), |(element_key, steps), i| {
            if element_key == "ZZZ" {
                Done((element_key, steps))
            } else {
                let element_options = network.get(element_key).unwrap();
                Continue((element_options[*i], steps + 1))
            }
        })
        .into_inner()
        .1
}

fn part_2(_input: &str) -> usize {
    1
}

fn main() {
    println!("Part 1: {}", part_1(include_str!("inputs/day_08")));
    println!("Part 2: {}", part_2(include_str!("inputs/day_08")));
}

#[cfg(test)]
mod tests {
    use super::*;
    use pretty_assertions::assert_eq;

    #[test]
    fn test_part_1() {
        assert_eq!(part_1(include_str!("inputs/day_08_example_1")), 2);
        assert_eq!(part_1(include_str!("inputs/day_08_example_2")), 6);
        assert_eq!(part_1(include_str!("inputs/day_08")), 24253);
    }

    #[test]
    fn test_part_2() {
        // assert_eq!(part_2(include_str!("inputs/day_08_example_1")), 5905);
        // assert_eq!(part_2(include_str!("inputs/day_08")), 249666369);
    }
}
