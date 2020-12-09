module day8;

import std;

void p1(File f)
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

void p2(File f)
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
