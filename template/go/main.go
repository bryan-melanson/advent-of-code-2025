package main

import (
	"bufio"
	"fmt"
	"os"
)

func readLines(filePath string) ([]string, error) {
	file, err := os.Open(filePath)
	if err != nil {
		return nil, err
	}
	defer file.Close()

	var lines []string
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		lines = append(lines, scanner.Text())
	}
	if err := scanner.Err(); err != nil {
		return nil, err
	}

	return lines, nil
}

func main() {
	test_val := 0
	result := solve1("data/test1")

	if result == test_val {
		fmt.Println("Part 1 Solution is ", solve1("data/input"))
	} else {
		fmt.Println("Test 1 failed!")
	}

	test_val = 0
	result = solve2("data/test2")

	if result == test_val {
		fmt.Println("Part 2 Solution is ", solve2("data/input"))
	} else {
		fmt.Println("Test 2 failed!")
	}
}
