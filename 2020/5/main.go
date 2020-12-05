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
	highest := 0
	for _, id := range makeIds(lines) {

		if id > highest {
			highest = id
		}

	}
	return highest
}

func second(lines []string) interface{} {

	return 0
}

func makeIds(lines []string) []int {

	ids := make([]int, len(lines))

	for i, line := range lines {
		rows := make([]int, 128)

		for i := range rows {
			rows[i] = i
		}

		for _, c := range line[0:7] {
			if string(c) == "F" {
				// Keep lower part
				newSeats := make([]int, len(rows)/2)
				newSeats = rows[0 : len(rows)/2]
				rows = newSeats
			} else {
				// Keep upper part
				newSeats := make([]int, len(rows)/2)
				newSeats = rows[len(rows)/2 : len(rows)]
				rows = newSeats
			}
		}

		columns := make([]int, 8)
		for i := range columns {
			columns[i] = i
		}

		for _, raw := range line[7:9] {
			c := string(raw)
			if c == "L" {
				// Keep lower part
				newSeats := make([]int, len(columns)/2)
				newSeats = columns[0 : len(columns)/2]
				columns = newSeats
			} else {
				// Keep upper part
				newSeats := make([]int, len(columns)/2)
				newSeats = columns[len(columns)/2 : len(columns)]
				columns = newSeats
			}
		}

		row := rows[0]
		column := columns[0]
		id := row*8 + column

		ids[i] = id
	}

	return ids

}

func contains(list []int, x int) bool {
	for _, item := range list {
		if item == x {
			return true
		}
	}
	return false
}
