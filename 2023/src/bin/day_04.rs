use std::collections::HashSet;

fn number_string_to_ints(numbers_string: &str) -> HashSet<u32> {
    numbers_string
        .split_whitespace()
        .map(|n| n.parse::<u32>().unwrap())
        .collect::<HashSet<_>>()
}

fn part_1(input: &str) -> u32 {
    input
        .lines()
        .map(|line| {
            // let (_, right) = line.split_once(":").unwrap();
            let mut parts = line.split([':', '|']);
            let _ = parts.next();
            let winning_numbers = number_string_to_ints(parts.next().unwrap());
            let card_numbers = number_string_to_ints(parts.next().unwrap());
            let winning_card_numbers = card_numbers
                .intersection(&winning_numbers)
                .collect::<HashSet<_>>();

            if !winning_card_numbers.is_empty() {
                2u32.pow((winning_card_numbers.len() - 1) as u32)
            } else {
                0
            }
        })
        .sum()
}

fn part_2(_input: &str) -> u32 {
    1
}

fn main() {
    println!("Part 1: {}", part_1(include_str!("inputs/day_04")));
    println!("Part 2: {}", part_2(include_str!("inputs/day_04")));
}

#[cfg(test)]
mod tests {
    use super::*;
    use pretty_assertions::assert_eq;

    #[test]
    fn test_part_1() {
        assert_eq!(part_1(include_str!("inputs/day_04_example_1")), 13);
        assert_eq!(part_1(include_str!("inputs/day_04")), 22193);
    }

    #[test]
    fn test_part_2() {
        // assert_eq!(part_2(include_str!("inputs/day_04_example_1")), 467_835);
        // assert_eq!(part_2(include_str!("inputs/day_04")), 87_605_697);
    }
}
