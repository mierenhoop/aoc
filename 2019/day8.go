package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"strconv"
)

const WIDTH = 25
const HEIGHT = 6

type Layer [150]int

func main() {
	file, err := ioutil.ReadFile("input")
	if err != nil {
		log.Fatal(err)
	}

	var layers []Layer

	for i := 0; i < len(file)-150; i+=150 {
		layers = append(layers, readLayer(string(file)[i:i+150]))
	}

	layer := subLayers(layers)

	for y := 0; y < HEIGHT; y++ {
		for x := 0; x < WIDTH; x++ {
			thing := layer[y*WIDTH+x]
			if thing == 1 {
				print("#")
			} else if thing == 0 {
				print(".")
			} else {
				print(" ")
			}
		}
		println("")
	}

	fmt.Println(subLayers(layers))
}

func subLayers(layers []Layer) (outLayer Layer) {
	for i := 0; i < 150; i++ {
		outLayer[i] = 2
	}

	for _, layer := range layers {
		for i := 0; i < 150; i++ {
			if outLayer[i] == 2 {
				outLayer[i] = layer[i]
			}
		}
	}
	return
}


func readLayer(data string) (layer Layer) {
	for i, char := range data {
		num ,err := strconv.Atoi(string(char))
		if err != nil {
			log.Fatal(err)
		}
		layer[i] = num
	}
	return
}
