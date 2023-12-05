use itertools::Itertools;

fn part_1(input: &str) -> u64 {
    let mut lines = input.lines();

    let seeds = lines
        .next()
        .unwrap()
        .split(':')
        .nth(1)
        .unwrap()
        .split_whitespace()
        .map(|seed| seed.parse::<u64>().unwrap())
        .collect_vec();

    seeds
        .iter()
        .map(|seed| {
            lines
                .clone()
                .filter(|line| !line.is_empty())
                .fold(
                    (*seed, false),
                    |(current, skip): (u64, bool), line: &str| {
                        if line.contains("map:") {
                            (current, false)
                        } else if skip {
                            (current, skip)
                        } else {
                            let mut nums = line
                                .split_whitespace()
                                .map(|num| num.parse::<u64>().unwrap());

                            let d_start = nums.next().unwrap();
                            let s_start = nums.next().unwrap();
                            let length = nums.next().unwrap();

                            // Using a range here along with .contains might make this not necessary?
                            if current >= s_start && current <= s_start + length {
                                for j in 0..length {
                                    let source = s_start + j;
                                    let destination = d_start + j;
                                    if current == source {
                                        return (destination, true);
                                    }
                                }
                            }

                            (current, false)
                        }
                    },
                )
                .0
        })
        .min()
        .unwrap()
}

fn part_2(input: &str) -> u32 {
    6
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
        assert_eq!(part_1(include_str!("inputs/day_05_example_1")), 35);
        assert_eq!(part_1(include_str!("inputs/day_05")), 486613012);
    }

    #[test]
    fn test_part_2() {
        // assert_eq!(part_2(include_str!("inputs/day_04_example_1")), 30);
        // assert_eq!(part_2(include_str!("inputs/day_04")), 5_625_994);
    }
}
