
const P3_INPUT: &'static str = include_str!("../p3input");

#[derive(Debug)]
enum Direction {
    Up(usize), Down(usize), Left(usize), Right(usize)
}

pub fn solve_p3() {
    let mut splitted = P3_INPUT.split('\n').into_iter();
    println!("splitted");
    let points1 = string_to_dirs(splitted.next().unwrap());
    println!("p1 finished");
    let points2 = string_to_dirs(splitted.next().unwrap());
    println!("p2 finished");

    //let manhattan = points1.intersection(&points2).min_by_key(|(a, b, _)| a.abs() + b.abs());
    
    let least_steps = points1.intersection(&points2).cloned().collect::<Vec<_>>();

    println!("{:?}", least_steps);
}

use std::collections::BTreeSet;


fn string_to_dirs(input: &str) -> BTreeSet<(isize, isize)> {
    input
        .trim()
        .split(',')
        .into_iter()
        .map(|string| {
            match string.get(..1).unwrap() {
                "U" => Direction::Up(string.get(1..)
                        .unwrap()
                        .parse::<usize>()
                        .unwrap()),
                "D" => Direction::Down(string.get(1..)
                        .unwrap()
                        .parse::<usize>()
                        .unwrap()),
                "L" => Direction::Left(string.get(1..)
                        .unwrap()
                        .parse::<usize>()
                        .unwrap()),
                "R" => Direction::Right(string.get(1..)
                        .unwrap()
                        .parse::<usize>()
                        .unwrap()),
                _ => panic!("NOT FOUND DIREACTION"),
            }
        })
        .fold((BTreeSet::<(isize, isize)>::new(), 0, 0, 0), |(mut points, mut x, mut y, mut steps), dir| {
            match dir {
                Direction::Right(num) => {
                    for i in 0..num {
                        x += 1;
                        steps += 1;
                        points.insert((x, y));
            println!("{:?}", (x, y, steps));
                    }
                },
                Direction::Left(num) => {
                    for i in 0..num {
                        x -= 1;
                        steps += 1;
                        points.insert((x, y));
            println!("{:?}", (x, y, steps));
                    }
                },
                Direction::Up(num) => {
                    for i in 0..num {
                        y += 1;
                        steps += 1;
                        points.insert((x, y));
            println!("{:?}", (x, y, steps));
                    }
                },
                Direction::Down(num) => {
                    for i in 0..num {
                        y -= 1;
                        steps += 1;
                        points.insert((x, y));
            println!("{:?}", (x, y, steps));
                    }
                }
            };

            (points, x, y, steps)
        }).0
}


/*
fn string_to_dirs(input: &str) -> BTreeSet<(isize, isize)> {
    input    
        .trim()
        .split(',')
        .into_iter()
        .fold((BTreeSet::<(isize, isize)>::new(), 0, 0), |(mut points, mut x, mut y), string| {
            match string.get(..1).unwrap() {
                "U" => (0..string.get(1..)
                    .unwrap()
                    .parse::<usize>()
                    .unwrap())
                        .into_iter()
                        .for_each(|_| {
                            y += 1;
                            points.insert((x, y));
                        }),
                "D" => (0..string.get(1..)
                    .unwrap()
                    .parse::<usize>()
                    .unwrap())
                        .into_iter()
                        .for_each(|_| {
                            y -= 1;
                            points.insert((x, y));
                        }),
                "L" => (0..string.get(1..)
                    .unwrap()
                    .parse::<usize>()
                    .unwrap())
                        .into_iter()
                        .for_each(|_| {
                            x -= 1;
                            points.insert((x, y));
                        }),
                "R" => (0..string.get(1..)
                    .unwrap()
                    .parse::<usize>()
                    .unwrap())
                        .into_iter()
                        .for_each(|_| {
                            x += 1;
                            points.insert((x, y));
                        }),
                _ => panic!("NOT FOUND DIREACTION"),
            }

            (points, x, y)
        }).0
}
*/

/*
fn string_to_dirs(input: &str) -> BTreeSet<(isize, isize)> {
    let mut set = BTreeSet::new();
    let mut x = 0;
    let mut y = 0;
    for string in input.trim().split(',').into_iter() {
        match string.get(..1).unwrap() {
            "U" => for _ in 0..string.get(1..).unwrap().parse::<usize>().unwrap() {
                y += 1;
                set.insert((x, y));
            },
            "D" => for _ in 0..string.get(1..).unwrap().parse::<usize>().unwrap() {
                y -= 1;
                set.insert((x, y));
            },
            "L" => for _ in 0..string.get(1..).unwrap().parse::<usize>().unwrap() {
                x -= 1;
                set.insert((x, y));
            },
            "R" => for _ in 0..string.get(1..).unwrap().parse::<usize>().unwrap() {
                x += 1;
                set.insert((x, y));
            },
            _ => panic!("NOT FOUND DIREACTION"),
        }
    }

    set 
}
*/

fn dirs_to_points(input: Vec<Direction>) -> Vec<(isize, isize)> {
    let mut out = vec!();
    let mut x: isize = 0;
    let mut y: isize = 0;
    for dir in input {
        match dir {
            Direction::Right(num) => {
                for _ in 0..num {
                    x += 1;
                    out.push((x, y));
                }
            },
            Direction::Left(num) => {
                for _ in 0..num {
                    x -= 1;
                    out.push((x, y));
                }
            },
            Direction::Up(num) => {
                for _ in 0..num {
                    y += 1;
                    out.push((x, y));
                }
            },
            Direction::Down(num) => {
                for _ in 0..num {
                    y -= 1;
                    out.push((x, y));
                }
            }
        };
    }
    println!("Done dirs");
    out
}
/*
use indicatif::{ProgressBar, ProgressStyle};

fn points_to_intersections(points1: Vec<(isize, isize)>, points2: Vec<(isize, isize)>) -> Vec<(isize, isize)> {
    let mut out = vec!();

    let bar = ProgressBar::new(points1.len() as u64);
    bar.set_style(ProgressStyle::default_bar()
        .template("[{elapsed_precise}] {bar:40.cyan/blue} {pos:>7}/{len:7} {msg}")
        .progress_chars("##-"));

    for (index, i) in points1.iter().enumerate() {
        for j in &points2 {
            if i.0 == j.0 && i.1 == j.1 {
                out.push((i.0, i.1));
            }
        }
        bar.inc(1);
    }
    bar.finish();
    out
}
*/
