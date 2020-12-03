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

	return traverse(lines, 1, 1) * traverse(lines, 3, 1) * traverse(lines, 5, 1) * traverse(lines, 7, 1) * traverse(lines, 1, 2)
}

func traverse(lines []string, xoff int, yoff int) int {
	currentX := 0
	numTrees := 0
	for i := 0; i < len(lines); i += yoff {
		line := lines[i]
		if i == 0 {
			continue
		}

		currentX += xoff

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
