use itertools::Itertools;
use rayon::prelude::*;

fn part_1(input: &str) -> usize {
    let mut sections = input.split("\n\n");

    let seed_ranges = sections
        .next()
        .unwrap()
        .split(':')
        .nth(1)
        .unwrap()
        .split_whitespace()
        .map(|num| num.parse::<usize>().unwrap())
        .collect_vec();

    let mappings = sections
        .map(|section| {
            let parts = section.split('\n');
            parts
                .skip(1)
                .map(|mapping| {
                    let mut nums = mapping
                        .split_whitespace()
                        .map(|num| num.parse::<usize>().unwrap());
                    let d_start = nums.next().unwrap();
                    let s_start = nums.next().unwrap();
                    let length = nums.next().unwrap();

                    (s_start..s_start + length, d_start..d_start + length)
                })
                .collect_vec()
        })
        .collect_vec();

    seed_ranges
        .into_iter()
        .map(|seed| {
            mappings.iter().fold(seed, |current, maps| {
                for (source_range, destination_range) in maps {
                    if source_range.contains(&current) {
                        let diff = current - source_range.start;
                        return destination_range.start + diff;
                    }
                }

                current
            })
        })
        .min()
        .unwrap()
}

fn part_2(input: &str) -> usize {
    let mut sections = input.split("\n\n");

    let mut seed_ranges = sections
        .next()
        .unwrap()
        .split(':')
        .nth(1)
        .unwrap()
        .split_whitespace()
        .chunks(2)
        .into_iter()
        .map(|mut chunk| {
            let start = chunk.next().unwrap().parse::<usize>().unwrap();
            let amount = chunk.next().unwrap().parse::<usize>().unwrap();
            start..start + amount
        })
        .collect_vec();

    let mappings = sections
        .map(|section| {
            let parts = section.split('\n');
            parts
                .skip(1)
                .map(|mapping| {
                    let mut nums = mapping
                        .split_whitespace()
                        .map(|num| num.parse::<usize>().unwrap());
                    let d_start = nums.next().unwrap();
                    let s_start = nums.next().unwrap();
                    let length = nums.next().unwrap();

                    (s_start..s_start + length, d_start..d_start + length)
                })
                .collect_vec()
        })
        .collect_vec();

    seed_ranges
        .par_iter_mut()
        .map(|seed_range| {
            seed_range
                .clone()
                .into_par_iter()
                .map(|seed| {
                    mappings.iter().fold(seed, |current, maps| {
                        for (source_range, destination_range) in maps {
                            if source_range.contains(&current) {
                                let diff = current - source_range.start;
                                return destination_range.start + diff;
                            }
                        }

                        current
                    })
                })
                .min()
                .unwrap()
        })
        .min()
        .unwrap()
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
        assert_eq!(part_2(include_str!("inputs/day_05_example_1")), 46);
        assert_eq!(part_2(include_str!("inputs/day_05")), 56931769);
    }
}
