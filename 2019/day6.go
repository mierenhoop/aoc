package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"strings"
)

func main() {
	data, err := ioutil.ReadFile("input")
	if err != nil {
		log.Fatal(err)
	}

	orbits := make(map[string]string)

	for _, line := range strings.Split(string(data), "\n") {
		if len(line) == 0 {
			continue
		}

		seperated := strings.Split(line, ")")

		orbits[seperated[1]] = seperated[0]
	}

	/*
	all := 0
	for _, other := range orbits {
		curOrbit := other
		numOrbits := 1
		for ;;numOrbits++ {
			curOrbit = orbits[curOrbit]
			if curOrbit == "" {
				break
			}
		}
		all += numOrbits
	}
	*/

	youOrbits := make(map[string]int)
	steps := 0
	curOrbit := orbits["YOU"]
	for ; ; steps++ {
		curOrbit = orbits[curOrbit]
		if curOrbit == "" {
			break
		}
		youOrbits[curOrbit] = steps
	}

	sanOrbits := make(map[string]int)
	steps = 2
	curOrbit = orbits["SAN"]
	for ; ; steps++ {
		curOrbit = orbits[curOrbit]
		if curOrbit == "" {
			break
		}
		sanOrbits[curOrbit] = steps
	}

	lowestSimilar := 100000000
	for sOrbit, sNum := range sanOrbits {
		for yOrbit, yNum := range youOrbits {
			if sOrbit == yOrbit {
				max := sNum + yNum
				if max < lowestSimilar {
					lowestSimilar = max
				}
			}
		}
	}


	fmt.Println(lowestSimilar)
}
