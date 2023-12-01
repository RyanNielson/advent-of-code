fn part_1(input: &str) -> u32 {
    input
        .lines()
        .map(|line| {
            let first_digit = line.chars().find(|&c| c.is_ascii_digit()).unwrap();
            let last_digit = line.chars().rev().find(|&c| c.is_ascii_digit()).unwrap();
            let num_string = format!("{first_digit}{last_digit}");
            num_string.parse::<u32>().unwrap()
        })
        .sum::<u32>()
}

fn part_2(input: &str) -> &str {
    println!("{input}");
    input
}

fn main() {
    println!("Part 1: {}", part_1(include_str!("inputs/day_01")));
    println!("Part 2: {}", part_2(include_str!("inputs/day_01")));
}

#[cfg(test)]
mod tests {
    use super::*;
    use pretty_assertions::assert_eq;

    #[test]
    fn test_part_1() {
        assert_eq!(part_1(include_str!("inputs/day_01_example_1")), 142);
        assert_eq!(part_1(include_str!("inputs/day_01")), 55_208);
    }

    #[test]
    fn test_part_2() {
        assert_eq!(part_2(include_str!("inputs/day_01")), "input");
    }
}
