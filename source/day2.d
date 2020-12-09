module day2;

import std;

void p1(File f)
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

void p2(File f)
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
