module day7;

import std;

void p1(File f)
{
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

	bool[string] bagsFound;
	void amountParents(string bag) {
		foreach (parentBag; bags.keys)
		{
			foreach (cont; bags[parentBag])
			{
				if (cont.name == bag)
				{
					bagsFound[parentBag] = true;
					amountParents(parentBag);
				}
			}
		}
	}
	amountParents("shiny gold");
	writeln(bagsFound.keys.length);
}

void p2(File f)
{
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

	ulong amountChildren(string bag) {
		ulong amount = 1;
		foreach (cont; bags[bag])
		{
			amount += cont.number * amountChildren(cont.name);
		}
		return amount;
	}

	writeln(amountChildren("shiny gold") - 1);
}
