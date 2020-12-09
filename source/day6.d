module day6;

import std;
import std.ascii : isLower;

auto solve(File file)
{
	struct Person
	{
		dchar[] answers;
	}

	struct Group
	{
		Person[] persons;

		ulong amountAnswered()
		{
			bool[dchar] answered;
			foreach (person; persons)
			{
				foreach (c; person.answers)
				{
					answered[c] = true;
				}
			}
			return answered.keys.length;
		}

		ulong amountAllAnswered()
		{
			dchar[] allAnswered = persons.map!(p => p.answers).join;
			allAnswered = allAnswered.sort.uniq.array;
			foreach (person; persons)
			{
				allAnswered = cast(dchar[]) setIntersection(person.answers, allAnswered).array;
			}
			return allAnswered.length; // one char is 4 of length, what?
		}
	}

	Group[] groups;
	Group curGroup;

	foreach (line; file.byLine.chain([""]))
	{
		if (line.empty)
		{
			groups ~= curGroup;
			curGroup = Group();
		}
		else
		{
			Person person;
			foreach (c; line)
			{
				if (isLower(c))
					person.answers ~= c;
			}
			person.answers = person.answers.sort.array;
			curGroup.persons ~= person;
		}
	}
	return groups;
}

void p1(File file)
{
	solve(file).map!(g => g.amountAnswered).sum.writeln;
}

void p2(File file)
{
	solve(file).map!(g => g.amountAllAnswered).sum.writeln;
}

void p1Alt(File file)
{
	file
		.byLine
		.chunkBy!((a, b) => !(a.empty || b.empty) || (a.empty && b.empty))
		.map!(a => a.filter!(b => !b.empty))
		.filter!(a => !a.empty)
		.map!(a => a.joiner.array.sort.uniq.fold!"a + 1"(0))
		.sum
		.writeln;
}

void p2Alt(File file)
{
	file
		.byLine
		.chunkBy!((a, b) => !(a.empty || b.empty) || (a.empty && b.empty))
		.map!(a => a.filter!(b => !b.empty))
		.filter!(a => !a.empty)
		.map!(a => a.fold!((a, b) => setIntersection(a, b.array.sort).text)(letters).fold!"a + 1"(0))
		.sum
		.writeln;
}
