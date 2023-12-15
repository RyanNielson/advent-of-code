use std::ops::Rem;

fn part_1(input: &str) -> usize {
    input
        .split(',')
        .map(|step| {
            step.as_bytes()
                .iter()
                .fold(0, |acc, c| ((acc + *c as usize) * 17).rem(256))
        })
        .sum()
}

fn part_2(_input: &str) -> usize {
    1
}

fn main() {
    println!("Part 1: {}", part_1(include_str!("inputs/day_15")));
    println!("Part 2: {}", part_2(include_str!("inputs/day_15")));
}

#[cfg(test)]
mod tests {
    use super::*;
    use pretty_assertions::assert_eq;

    #[test]
    fn test_part_1() {
        assert_eq!(part_1(include_str!("inputs/day_15_example_1")), 1320);
        assert_eq!(part_1(include_str!("inputs/day_15")), 511257);
    }

    #[test]
    fn test_part_2() {
        // assert_eq!(part_2(include_str!("inputs/day_15_example_1")), 5905);
        // assert_eq!(part_2(include_str!("inputs/day_15")), 249666369);
    }
}
