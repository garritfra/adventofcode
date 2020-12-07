package main

import (
	"fmt"
	"io/ioutil"
	"regexp"
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
	passports := make([]string, 0)

	current := ""

	for _, line := range lines {
		if line == "" {
			passports = append(passports, current)
			current = ""
		} else {
			current += (line + " ")
		}
	}

	passports = append(passports, current)

	sumValid := 0
	//  && regexp.MustCompile(`(byr&iyr&eyr:)`).MatchString(passport) && regexp.MustCompile(`(byr&iyr&eyr:)`).MatchString(passport)
	for _, passport := range passports {
		valid := regexp.MustCompile(`(byr:)`).MatchString(passport)
		valid = valid && regexp.MustCompile(`(iyr:)`).MatchString(passport)
		valid = valid && regexp.MustCompile(`(eyr:)`).MatchString(passport)
		valid = valid && regexp.MustCompile(`(hgt:)`).MatchString(passport)
		valid = valid && regexp.MustCompile(`(hcl:)`).MatchString(passport)
		valid = valid && regexp.MustCompile(`(ecl:)`).MatchString(passport)
		valid = valid && regexp.MustCompile(`(pid:)`).MatchString(passport)
		if valid {
			sumValid++
		}
	}
	return sumValid
}

func second(lines []string) interface{} {
	return 0
}
