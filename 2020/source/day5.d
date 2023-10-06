module day5;

import std;

uint solve(char[] line)
{
	uint lowerV = 0;
	uint upperV = 127;
	char lastV;

	uint lowerH = 0;
	uint upperH = 7;
	char lastH;
	foreach (letter; line)
	{
		if (letter == 'F')
		{
			upperV -= cast(uint) round(cast(float)(upperV - lowerV) / 2.0);
			lastV = letter;
		}
		else if (letter == 'B')
		{
			lowerV += cast(uint) round(cast(float)(upperV - lowerV) / 2.0);
			lastV = letter;
		}
		else if (letter == 'L')
		{
			upperH -= cast(uint) round(cast(float)(upperH - lowerH) / 2.0);
			lastH = letter;
		}
		else if (letter == 'R')
		{
			lowerH += cast(uint) round(cast(float)(upperH - lowerH) / 2.0);
			lastH = letter;
		}
	}

	uint posV = lastV == 'F' ? lowerV : upperV;
	uint posH = lastH == 'L' ? lowerH : upperH;
	if (posV == 0 || posV == 127)
		return 0;
	return posV * 8 + posH;
}

void p1(File f)
{
	uint[] ids;
	foreach (line; f.byLine)
	{
		uint id = solve(line);
		if (id != 0)
			ids ~= id;
	}
	writeln(maxElement(ids));
}



void p2(File f)
{
	uint[] ids;
	foreach (line; f.byLine)
	{
		uint id = solve(line);
		if (id != 0)
			ids ~= id;
	}
	uint max = maxElement(ids);
	foreach (id; 0 .. max)
	{
		if (ids.canFind(id - 1) && ids.canFind(id + 1) && !ids.canFind(id))
		{
			writeln(id);
		}
	}
}
