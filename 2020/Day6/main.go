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
	groups := make([]string, 0)

	current := ""

	for _, line := range lines {
		if line == "" {
			groups = append(groups, current)
			current = ""
		} else {
			current += line
		}
	}

	groups = append(groups, current)

	sum := 0

	for _, group := range groups {
		unique := string(unique([]byte(group)))
		len := len(unique)
		sum += len
	}

	return sum
}

func second(lines []string) interface{} {
	groups := make([]string, 0)

	current := ""

	for _, line := range lines {
		if line == "" {
			groups = append(groups, current)
			current = ""
		} else {
			current += line
		}
	}

	groups = append(groups, current)

	sum := 0

	for _, group := range groups {
		unique := string(unique([]byte(group)))
		len := len(unique)
		sum += len
	}

	return sum
}

func unique(intSlice []byte) []byte {
	keys := make(map[byte]bool)
	list := []byte{}
	for _, entry := range intSlice {
		if _, value := keys[entry]; !value {
			keys[entry] = true
			list = append(list, entry)
		}
	}
	return list
}
