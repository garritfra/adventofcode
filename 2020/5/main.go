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
	for _, line := range lines {
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

		for _, c := range line[8:10] {
			if string(c) == "L" {
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

		if id > highest {
			highest = id
		}

	}
	return highest
}

func second(lines []string) interface{} {
	return 0
}
