module day4;

import std;

void p1(File file)
{
	alias PassWord = string[string];
	PassWord curPassWord;
	PassWord[] passWords;
	foreach (line; file.byLine.chain([""]))
	{
		if (line.empty)
		{
			passWords ~= curPassWord;
			curPassWord = null;
		}
		else
		{
			foreach (field; line.splitter(' '))
			{
				string key;
				string value;
				field.formattedRead!"%s:%s"(key, value);
				curPassWord[key] = value;
			}
		}
	}
	uint invalid = 0;
	foreach (ref passWord; passWords)
	{
		foreach (key; ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"])
		{
			if (!passWord.keys.canFind(key))
			{
				invalid++;
				passWord = null;
				break;
			}
		}
	}

	writeln(passWords.length - invalid);
}

void p2(File file)
{
	alias PassWord = string[string];
	PassWord curPassWord;
	PassWord[] passWords;
	foreach (line; file.byLine.chain([""]))
	{
		if (line.empty)
		{
			passWords ~= curPassWord;
			curPassWord = null;
		}
		else
		{
			foreach (field; line.splitter(' '))
			{
				string key;
				string value;
				field.formattedRead!"%s:%s"(key, value);
				curPassWord[key] = value;
			}
		}
	}
	uint invalid = 0;
	foreach (ref passWord; passWords)
	{
		foreach (key; ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"])
		{
			if (!passWord.keys.canFind(key))
			{
				invalid++;
				passWord = null;
				break;
			}
		}
	}

	foreach (ref passWord; passWords)
	{
		if (passWord == null)
			continue;
		foreach (key; passWord.keys)
		{
			bool isValid = false;
			string val = passWord[key];
			try
			{
				switch (key)
				{
				case "byr":
					if (val.to!int >= 1920 && val.to!int <= 2002)
						isValid = true;
					break;
				case "iyr":
					if (val.to!int >= 2010 && val.to!int <= 2020)
						isValid = true;
					break;
				case "eyr":
					if (val.to!int >= 2020 && val.to!int <= 2030)
						isValid = true;
					break;
				case "hgt":
					if (val.endsWith("cm"))
					{
						uint num = val[0 .. $ - 2].to!int;
						if (num >= 150 && num <= 193)
							isValid = true;
					}
					else if (val.endsWith("in"))
					{
						uint num = val[0 .. $ - 2].to!int;
						if (num >= 59 && num <= 76)
							isValid = true;
					}
					break;
				case "hcl":

					bool hcl(string val)
					{
						if (val.length == 7 && val[0] == '#')
						{
							foreach (c; val[1 .. $])
							{
								if (!lowerHexDigits.canFind(c))
									return false;
							}
							return true;
						}
						return false;
					}

					if (hcl(val))
						isValid = true;
					break;
				case "ecl":
					if (["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].canFind(val))
						isValid = true;
					break;
				case "pid":
					if (val.length == 9 && val.all!(isDigit))
						isValid = true;
					break;
				case "cid":
					isValid = true;
					break;
				default:
					break;
				}
			}
			catch (Exception)
			{
				isValid = false;
			}
			if (!isValid)
			{
				invalid++;
				passWord = null;
				break;
			}
		}
	}
	writeln(passWords.length - invalid);
}
