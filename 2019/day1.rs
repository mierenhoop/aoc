
const P1_INPUT: &'static str = include_str!("../p1input");

fn solve_p1() {
    let mut out = 0;
    for line in P1_INPUT.lines() {
        let mut num: isize = line.parse().expect("COULDNT READ INT");

        let mut total = 0;

        loop {
            num = (num as f64 / 3.0).floor() as isize - 2;
            if num < 0 { break }
            total += num;
        }
        
        
        out += total;
    }

    println!("{}", out);
}
