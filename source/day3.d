module day3;

import std;

void p1(File f)
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

void p2(File f)
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
