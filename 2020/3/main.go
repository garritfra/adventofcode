package main

import (
	"fmt"
	"io/ioutil"
	"strings"
)

func main() {

	data, err := ioutil.ReadFile("input.txt")
	if err != nil {
		fmt.Println("File reading error", err)
		return
	}
	lines := strings.Split(string(data), "\n")

	fmt.Println("First result:", first(lines))
	fmt.Println("Second result:", second(lines))

}

func first(lines []string) interface{} {
	currentX := 0
	numTrees := 0
	for i, line := range lines {
		if i == 0 {
			continue
		}

		currentX += 3

		objects := strings.Split(line, "")

		if currentX >= len(objects) {
			currentX %= len(objects)
		}

		if objects[currentX] == "#" {
			numTrees++
		}

	}

	return numTrees
}

func second(lines []string) interface{} {
	result := 0

	return result
}
