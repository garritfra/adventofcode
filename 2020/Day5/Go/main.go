package main

import (
	"fmt"
	"io/ioutil"
	"sort"
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
	highest := 0
	for _, id := range makeIds(lines) {

		if id > highest {
			highest = id
		}

	}
	return highest
}

func second(lines []string) interface{} {
	ids := makeIds(lines)
	sort.Ints(ids)

	for i, id := range ids {
		if ids[i+1] != id+1 {
			return id + 1
		}
	}
	return 0
}

func makeIds(lines []string) []int {

	ids := make([]int, 0)

	for _, line := range lines {
		binary := ""

		for _, c := range line {
			if string(c) == "F" || string(c) == "L" {
				// Keep lower part
				binary += "0"
			} else if string(c) == "R" || string(c) == "B" {
				// Keep upper part
				binary += "1"
			}
		}

		id, _ := strconv.ParseInt(binary, 2, 64)
		ids = append(ids, int(id))
	}

	return ids

}
