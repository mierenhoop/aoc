module day10;

import std;

void p1(File f)
{
	[0].chain(f.byLine
		.map!(to!ulong))
		.array
		.sort
		.fold!((a, b) => tuple(b, a[1] + (b - a[0] == 1 ? 1 : 0), a[2] + (b - a[0] == 3 ? 1 : 0)))(tuple(0UL, 0UL, 1UL))
		.expand.only.drop(1).fold!"a * b"
		.writeln;
}

void p2(File f)
{
	f.byLine
		.map!(to!ulong)
		.array.sort.array
		.slide(2).map!(a => a[1] - a[0]).each!writeln;
}
