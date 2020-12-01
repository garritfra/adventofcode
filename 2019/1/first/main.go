package main

import (
	"fmt"
	"io/ioutil"
	"math"
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

	sum := 0.0

	for _, line := range lines {
		fuel, _ := strconv.Atoi(line)
		result := math.Floor(float64(fuel)/3) - 2
		sum += result
	}

	fmt.Println(int(sum))
}
