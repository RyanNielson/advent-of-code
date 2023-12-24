use std::str::FromStr;

use itertools::Itertools;

fn part_1(input: &str, min: f64, max: f64) -> usize {
    let hailstones = input
        .lines()
        .map(|line| Hailstone::from_str(line).unwrap())
        .collect_vec();

    let mut intersect_in_test_area_count = 0;

    for (i, stone1) in hailstones.iter().enumerate() {
        for stone2 in hailstones[(i + 1)..].iter() {
            let x = (stone2.y_int - stone1.y_int) / (stone1.m - stone2.m);
            let y = stone1.m * x + stone1.y_int;

            // Make sure the intersection is in the future.
            if (stone1.vx > 0 && x < stone1.x as f64) || (stone1.vx < 0 && x > stone1.x as f64) {
                continue;
            }

            if (stone1.vy > 0 && y < stone1.y as f64) || (stone1.vy < 0 && y > stone1.y as f64) {
                continue;
            }

            if (stone2.vx > 0 && x < stone2.x as f64) || (stone2.vx < 0 && x > stone2.x as f64) {
                continue;
            }

            if (stone2.vy > 0 && y < stone2.y as f64) || (stone2.vy < 0 && y > stone2.y as f64) {
                continue;
            }

            if x >= min && x <= max && y >= min && y <= max {
                intersect_in_test_area_count += 1;
            }
        }
    }

    intersect_in_test_area_count
}

fn part_2(_input: &str) -> usize {
    1
}

fn main() {
    println!(
        "Part 1: {}",
        part_1(
            include_str!("inputs/day_24"),
            200000000000000f64,
            400000000000000f64
        )
    );
    // println!("Part 2: {}", part_2(include_str!("inputs/day_24")));
}

#[derive(Debug, Clone, Copy)]
struct Hailstone {
    x: isize,
    y: isize,
    z: isize,
    vx: isize,
    vy: isize,
    vz: isize,
    m: f64,
    y_int: f64,
}

impl FromStr for Hailstone {
    type Err = ();

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        let (x, y, z, vx, vy, vz) = s
            .replace('@', ",")
            .split(',')
            .map(|n| n.trim().parse().unwrap())
            .collect_tuple()
            .unwrap();

        let x2 = x + vx;
        let y2 = y + vy;

        let m = ((y2 - y) as f64) / ((x2 - x) as f64);

        let y_int = y as f64 - m * x as f64;

        Ok(Hailstone {
            x,
            y,
            z,
            vx,
            vy,
            vz,
            m,
            y_int,
        })
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use pretty_assertions::assert_eq;

    #[test]
    fn test_part_1() {
        assert_eq!(
            part_1(include_str!("inputs/day_24_example_1"), 7f64, 27f64),
            2
        );
        assert_eq!(
            part_1(
                include_str!("inputs/day_24"),
                200000000000000f64,
                400000000000000f64
            ),
            342650
        );
    }

    #[test]
    fn test_part_2() {
        // assert_eq!(
        //     part_2(include_str!("inputs/day_24_example_1")),
        //     952408144115
        // );
        // assert_eq!(part_2(include_str!("inputs/day_24")), 57196493937398);
    }
}
