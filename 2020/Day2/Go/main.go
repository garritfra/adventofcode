package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
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
	result := 0
	for _, line := range lines {
		components := strings.FieldsFunc(string(line), split)
		min, _ := strconv.Atoi(components[0])
		max, _ := strconv.Atoi(components[1])
		target := components[2]
		password := components[3]

		matches := 0

		for _, letter := range strings.Split(password, "") {
			if letter == target {
				matches++
			}
		}

		if matches >= min && matches <= max {
			result++
		}

		matches = 0
	}

	return result
}

func second(lines []string) interface{} {
	result := 0
	for _, line := range lines {
		components := strings.FieldsFunc(string(line), split)
		min, _ := strconv.Atoi(components[0])
		max, _ := strconv.Atoi(components[1])
		target := components[2]
		password := components[3]

		letters := strings.Split(password, "")

		// Bloated XOR
		if (letters[min-1] == target && letters[max-1] != target) || (letters[min-1] != target && letters[max-1] == target) {
			result++
		}
	}

	return result
}

func split(r rune) bool {
	return r == '-' || r == ' ' || r == ':'
}
