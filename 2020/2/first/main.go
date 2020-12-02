package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
)

func main() {

	result := 0

	data, err := ioutil.ReadFile("input.txt")
	if err != nil {
		fmt.Println("File reading error", err)
		return
	}
	lines := strings.Split(string(data), "\n")

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

	fmt.Println(result)

}

func split(r rune) bool {
	return r == '-' || r == ' ' || r == ':'
}
