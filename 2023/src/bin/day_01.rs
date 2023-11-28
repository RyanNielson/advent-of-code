fn part_1(input: &str) -> &str {
    println!("{input}");
    input
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
        assert_eq!(part_1(include_str!("inputs/day_01")), "input");
    }

    #[test]
    fn test_part_2() {
        assert_eq!(part_2(include_str!("inputs/day_01")), "input");
    }
}
