module day9;

import std;

void day9part1(File f)
{
	ulong[] numbers;

	foreach (line; f.byLine)
	{
		numbers ~= line.to!ulong;
	}
	writeln(solve(numbers, 25));
}

ulong solve(ulong[] numbers, ulong size)
{
	foreach (i, number; numbers.drop(size).enumerate)
	{
		ulong[] preamble = numbers[i .. i + size];
		bool found;
		foreach (j; preamble)
		{
			foreach (k; preamble)
				if (j + k == number) found = true;
		}
		if (!found) return number;
	}
	assert(0);
}

void day9part2(File f)
{
	ulong[] numbers;

	foreach (line; f.byLine)
	{
		numbers ~= line.to!ulong;
	}

	ulong wrong = solve(numbers, 25);

	ulong[] rng;

outer: for (ulong i = 0; i < numbers.length; i++)
	{
		ulong val = 0;
		for (ulong j = i; j < numbers.length; j++)
		{
			val += numbers[j];
			if (val > wrong) break;
			if (val == wrong && j - i > 1) 
			{
				rng = numbers[i .. j + 1];
				break outer;
			}
		}
	}
	writeln(rng.minElement + rng.maxElement);
}
