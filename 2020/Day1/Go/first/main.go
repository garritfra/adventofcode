package main

import (
	"fmt"
	"io/ioutil"
	"math/rand"
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

	for {
		num1, _ := strconv.Atoi(lines[rand.Intn(len(lines))])
		num2, _ := strconv.Atoi(lines[rand.Intn(len(lines))])

		if num1+num2 == 2020 {
			fmt.Println(num1, " * ", num2, " = ", num1*num2)
			break
		}
	}

}
