use std::collections::HashSet;

fn number_string_to_ints(numbers_string: &str) -> HashSet<u32> {
    numbers_string
        .split_whitespace()
        .map(|n| n.parse::<u32>().unwrap())
        .collect::<HashSet<_>>()
}

fn winning_card_numbers_len(line: &str) -> usize {
    let mut parts = line.split([':', '|']);
    let winning_numbers = number_string_to_ints(parts.nth(1).unwrap());
    let card_numbers = number_string_to_ints(parts.next().unwrap());
    card_numbers
        .intersection(&winning_numbers)
        .collect::<HashSet<_>>()
        .len()
}

fn part_1(input: &str) -> u32 {
    input
        .lines()
        .map(|line| {
            let winning_card_numbers_len = winning_card_numbers_len(line);
            if winning_card_numbers_len > 0 {
                2u32.pow((winning_card_numbers_len - 1) as u32)
            } else {
                0
            }
        })
        .sum()
}

fn part_2(input: &str) -> u32 {
    let card_points = input
        .lines()
        .map(winning_card_numbers_len)
        .collect::<Vec<_>>();

    let mut card_counts = vec![1; card_points.len()];

    for (i, points) in card_points.iter().enumerate() {
        for j in (i + 1)..(i + points + 1) {
            card_counts[j] += card_counts[i];
        }
    }

    card_counts.iter().sum()
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
        assert_eq!(part_1(include_str!("inputs/day_04")), 22_193);
    }

    #[test]
    fn test_part_2() {
        assert_eq!(part_2(include_str!("inputs/day_04_example_1")), 30);
        assert_eq!(part_2(include_str!("inputs/day_04")), 5_625_994);
    }
}
