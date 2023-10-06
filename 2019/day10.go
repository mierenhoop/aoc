package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"strings"
)

func main() {
	file, err := ioutil.ReadFile("testinput")
	if err != nil {
		log.Fatal(err)
	}

	var data []bool

	var width int

	for _, line := range strings.Split(string(file), "\n") {
		if line == "" { continue }
		width = len(line)
		for _, entry := range line {
			val := false
			if entry == '#' {
				val = true
			}
			data = append(data, val)
		}
	}

	height := len(data) / width

	angles := make([]int, width*height)

	for i, spaceSrc := range data {
		if !spaceSrc {
			continue
		}
		xSrc := i % width
		ySrc := i / width

		var anglesSrc []float64
		for j, spaceDst := range data {
			if !spaceDst {
				continue
			}
			xDst := j % width
			yDst := j / width

			angle := float64(yDst - ySrc) / float64(xDst - xSrc)

			if !(xDst == xSrc && yDst == ySrc) {
				fmt.Printf("station: %d, %d, asteroid: %d, %d, angle: %.4f\n", xSrc, ySrc, xDst, yDst, angle)
				if !contains(anglesSrc, angle) {
					anglesSrc = append(anglesSrc, angle)
				}
			}
		}
		angles[i] = len(anglesSrc)
	}

	maxIndex := max(angles)
	fmt.Println(maxIndex % width, maxIndex / width)
	fmt.Println(angles[maxIndex])
}

func contains(list []float64, num float64) bool {
	for _, val := range list {
		if val == num {
			return true
		}
	}
	return false
}

func max(list []int) int {
	val := 0
	index := 0
	for i, listItem := range list {
		if listItem >= val {
			index = i
			val = list[index]
		}
	}
	return index
}
