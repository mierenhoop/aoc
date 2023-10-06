
const P2_INPUT: &'static str = include_str!("../p2input");


fn solve_p2() {
    let input = P2_INPUT
        .trim()
        .split(',')
        .into_iter()
        .map(|string|
             string.parse::<usize>()
             .unwrap())
        .collect::<Vec<usize>>();

    for noun in 0..100 {
        for verb in 0..100 {
            let mut new_input = input.clone();
            new_input[1] = noun;
            new_input[2] = verb;
            run_intcode(&mut new_input);
            if new_input[0] == 19690720 { println!("{}", 100 * noun + verb) }
        }
    }

}

fn run_intcode(input: &mut [usize]) {
    let mut pos = 0;

    while pos < input.len() {
        let code = input[pos];

        match code {
            1 => {
                let pos1 = input[pos+1];
                let pos2 = input[pos+2];
                let pos3 = input[pos+3];
                input[pos3] = input[pos1] + input[pos2];
                pos += 4;
            },
            2 => {
                let pos1 = input[pos+1];
                let pos2 = input[pos+2];
                let pos3 = input[pos+3];
                input[pos3] = input[pos1] * input[pos2];
                pos += 4;
            },
            99 => break,
            _ => (),
        }
    }
}

