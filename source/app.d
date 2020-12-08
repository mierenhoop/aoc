import std;

void main()
{
	day8part2(File("8.txt"));
}

void day2part1(File f)
{
	uint valid = 0;
	foreach (line; f.byLine)
	{
		uint min, max;
		char letter;
		string password;
		line.formattedRead!"%d-%d %c: %s"(min, max, letter, password);
		auto count = password.count(letter);
		if (count >= min && count <= max) valid++;
	}
	writeln(valid);
}

void day2part2(File f)
{
	uint valid = 0;
	foreach (line; f.byLine)
	{
		uint pos1, pos2;
		char letter;
		string password;
		line.formattedRead!"%d-%d %c: %s"(pos1, pos2, letter, password);
		uint amountCorrect = 0;
		if (password[pos1 - 1] == letter) amountCorrect++;
		if (password[pos2 - 1] == letter) amountCorrect++;
		if (amountCorrect == 1) valid++;
	}
	writeln(valid);
}

void day3part1(File f)
{
	uint ystep = 1;
	uint xstep = 3;
	bool[][] map;
	foreach (line; f.byLine)
	{
		bool[] row;
		foreach (c; line)
		{
			if (c == '#') row ~= true;
			else row ~= false;
		}
		map ~= row;
	}
	uint rowwidth = cast(uint) map[0].length;
	uint x = xstep;
	uint encountered = 0;
	foreach (y; iota(ystep, map.length, ystep))
	{
		if (map[y][x]) encountered++;
		x = (x + xstep) % rowwidth;
	}
	writeln(encountered);
}

void day3part2(File f)
{
	bool[][] map;
	foreach (line; f.byLine)
	{
		bool[] row;
		foreach (c; line)
		{
			if (c == '#') row ~= true;
			else row ~= false;
		}
		map ~= row;
	}

	ulong solve(ulong xstep, ulong ystep) {
		ulong rowwidth = map[0].length;
		ulong x = xstep;
		ulong encountered = 0;
		foreach (y; iota(ystep, map.length, ystep))
		{
			if (map[y][x]) encountered++;
			x = (x + xstep) % rowwidth;
		}
		return encountered;
	}
	writeln(solve(1, 1) * solve(3, 1) * solve(5, 1) * solve(7, 1) * solve(1, 2));
}

void day7part1(File f)
{
	import std.typecons;
	// auto r = regex(r"^(\w+ \w+) bags contain(?:(?:(?: (\d+ \w+ \w+) bags?\,?)+)| no other bags)\.$");
	struct Contained
	{
		ulong number;
		string name;
	}

	Contained[][string] bags;
	foreach (line; f.byLine)
	{
		auto sp = line.chop.findSplit(" bags contain ");
		string bag = sp[0].text;
		Contained[] ctnd = [];
		foreach (cont; sp[2].split(", ").filter!(s => s != "no other bags").map!(s => s.findSplit(" bag")[0]))
		{
			auto ctd = cont.findSplit(" ");
			ctnd ~= Contained(ctd[0].to!int, ctd[2].text);
		}
		bags[bag] = ctnd;
	}

	// Part 1
	// bool[string] bagsFound;
	// void amountParents(string bag) {
	// 	// uint amount = 0;
	// 	foreach (parentBag; bags.keys)
	// 	{
	// 		foreach (cont; bags[parentBag])
	// 		{
	// 			if (cont.name == bag)
	// 			{
	// 				bagsFound[parentBag] = true;
	// 				writeln(parentBag);
	// 				/* amount += */ amountParents(parentBag);
	// 			}
	// 		}
	// 	}
	// 	//return amount;
	// }
	// amountParents("shiny gold");
	// writeln(bagsFound.keys.length);

	// Part 2
	ulong amountChildren(string bag) {
		ulong amount = 1;
		foreach (cont; bags[bag])
		{
			writeln(cont.name);
			amount += cont.number * amountChildren(cont.name);
		}
		return amount;
	}

	writeln(amountChildren("shiny gold") - 1);
}

void day8part1(File f)
{
	struct Instruction
	{
		this (char[] line)
		{
			string name;
			line.formattedRead!"%s %d"(name, amount);
			switch (name)
			{
			case "acc": type = Acc; break;
			case "jmp": type = Jmp; break;
			case "nop": type = Nop; break;
			default: writeln("Instruction not found: ", name); break;
			}
		}
		enum { Acc, Jmp, Nop }
		ubyte type;
		long amount;
		ulong run;
	}

	long value;
	ulong position;
	ulong counter;
	Instruction[] instructions;
	foreach (line; f.byLine)
	{
		instructions ~= Instruction(line);
	}
	while (true)
	{
		long jump = 1;
		
		instructions[position].run++;

		if (instructions[position].run == 2)
		{
			break;
		}
		switch (instructions[position].type)
		{
		case Instruction.Acc: value += instructions[position].amount; break;
		case Instruction.Jmp: jump = instructions[position].amount; break;
		case Instruction.Nop: break;
		default: writeln("Can't find instruction: ", instructions[position]); break;
		}

		position += jump;
		counter++;
	}
	writeln(value);
}

void day8part2(File f)
{
	struct Instruction
	{
		this (char[] line)
		{
			string name;
			line.formattedRead!"%s %d"(name, amount);
			switch (name)
			{
			case "acc": type = Acc; break;
			case "jmp": type = Jmp; break;
			case "nop": type = Nop; break;
			default: writeln("Instruction not found: ", name); break;
			}
		}
		enum { Acc, Jmp, Nop }
		ubyte type;
		long amount;
		ulong run;
	}

	Instruction[] instructions;
	foreach (line; f.byLine)
	{
		instructions ~= Instruction(line);
	}

	ulong changePos = instructions.countUntil!(i => i.type == Instruction.Nop || i.type == Instruction.Jmp);
	instructions[changePos].type = instructions[changePos].type == Instruction.Nop ? Instruction.Jmp : Instruction.Nop;

	long run()
	{
		//writeln(changePos);
		instructions[changePos].type = instructions[changePos].type == Instruction.Nop ? Instruction.Jmp : Instruction.Nop;
		changePos = instructions[changePos + 1 .. $].countUntil!(i => i.type == Instruction.Nop || i.type == Instruction.Jmp) + changePos + 1;
		instructions[changePos].type = instructions[changePos].type == Instruction.Nop ? Instruction.Jmp : Instruction.Nop;
		long value;
		ulong position;
		ulong counter;
		while (position < instructions.length)
		{
			long jump = 1;
			
			instructions[position].run++;

			if (instructions[position].run == 2)
			{
				foreach (ref instr; instructions) instr.run = 0;
				value = run();
				break;
			}
			switch (instructions[position].type)
			{
			case Instruction.Acc: value += instructions[position].amount; break;
			case Instruction.Jmp: jump = instructions[position].amount; break;
			case Instruction.Nop: break;
			default: writeln("Can't find instruction: ", instructions[position]); break;
			}

			position += jump;
			counter++;
		}
		return value;
	}
	writeln(run());
}
