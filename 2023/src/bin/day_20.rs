use std::collections::{HashMap, VecDeque};

use itertools::Itertools;

fn part_1(input: &str) -> usize {
    let mut modules = parse(input);

    let mut high_pulses = 0;
    let mut low_pulses = 0;

    for _i in 0..1000 {
        let mut queue =
            VecDeque::from([("button".to_string(), "broadcaster".to_string(), Pulse::Low)]);

        while let Some((from, current, pulse)) = queue.pop_front() {
            match pulse {
                Pulse::High => high_pulses += 1,
                Pulse::Low => low_pulses += 1,
            }

            if let Some(module) = modules.get_mut(&current) {
                match module {
                    Module::Broadcaster(destinations) => {
                        for destination in destinations {
                            queue.push_back((current.clone(), destination.clone(), pulse));
                        }
                    }

                    Module::FlipFlop(state, destinations) => {
                        if pulse == Pulse::Low {
                            if *state == State::On {
                                *state = State::Off;

                                for destination in destinations {
                                    queue.push_back((
                                        current.clone(),
                                        destination.clone(),
                                        Pulse::Low,
                                    ));
                                }
                            } else {
                                *state = State::On;

                                for destination in destinations {
                                    queue.push_back((
                                        current.clone(),
                                        destination.clone(),
                                        Pulse::High,
                                    ));
                                }
                            }
                        }
                    }
                    Module::Conjunction(memory, destinations) => {
                        memory.insert(from, pulse);

                        let all_high = memory.values().all(|v| *v == Pulse::High);
                        if all_high {
                            for destination in destinations {
                                queue.push_back((current.clone(), destination.clone(), Pulse::Low));
                            }
                        } else {
                            for destination in destinations {
                                queue.push_back((
                                    current.clone(),
                                    destination.clone(),
                                    Pulse::High,
                                ));
                            }
                        }
                    }
                }
            }
        }
    }

    high_pulses * low_pulses
}

#[derive(Debug, Eq, PartialEq, Hash, Clone, Copy)]
enum Pulse {
    Low,
    High,
}

#[derive(Debug, Eq, PartialEq, Hash, Clone, Copy)]
enum State {
    Off,
    On,
}
#[derive(Debug)]
enum Module {
    Broadcaster(Vec<String>),
    FlipFlop(State, Vec<String>),
    Conjunction(HashMap<String, Pulse>, Vec<String>),
}

fn part_2(_input: &str) -> usize {
    1
}

fn parse(input: &str) -> HashMap<String, Module> {
    let mut modules = input
        .lines()
        .map(|line| {
            let (name, destinations) = line.split_once(" -> ").unwrap();
            let destinations = destinations
                .split(", ")
                .map(|destination| destination.to_string())
                .collect_vec();

            if let Some(name) = name.strip_prefix('%') {
                (name.to_string(), Module::FlipFlop(State::Off, destinations))
            } else if let Some(name) = name.strip_prefix('&') {
                (
                    name.to_string(),
                    Module::Conjunction(HashMap::new(), destinations),
                )
            } else {
                (name.to_string(), Module::Broadcaster(destinations))
            }
        })
        .collect::<HashMap<_, _>>();

    let mut inputs = HashMap::<String, Vec<String>>::new();
    for (k, v) in &mut modules {
        let outputs = match v {
            Module::Broadcaster(o) | Module::FlipFlop(_, o) | Module::Conjunction(_, o) => {
                o.clone()
            }
        };

        for output in outputs {
            inputs.entry(output).or_default().push(k.clone());
        }
    }

    for (k, v) in &inputs {
        if let Some(Module::Conjunction(memory, _)) = modules.get_mut(k) {
            *memory = v
                .iter()
                .map(|input| (input.clone(), Pulse::Low))
                .collect::<HashMap<String, Pulse>>();
        }
    }

    modules
}

fn main() {
    println!("Part 1: {}", part_1(include_str!("inputs/day_20")));
    println!("Part 2: {}", part_2(include_str!("inputs/day_20")));
}

#[cfg(test)]
mod tests {
    use super::*;
    use pretty_assertions::assert_eq;

    #[test]
    fn test_part_1() {
        assert_eq!(part_1(include_str!("inputs/day_20_example_1")), 32000000);
        assert_eq!(part_1(include_str!("inputs/day_20_example_2")), 11687500);
        assert_eq!(part_1(include_str!("inputs/day_20")), 886701120);
    }

    #[test]
    fn test_part_2() {
        // assert_eq!(
        //     part_2(include_str!("inputs/day_19_example_1")),
        //     952408144115
        // );
        // assert_eq!(part_2(include_str!("inputs/day_19")), 57196493937398);
    }
}
