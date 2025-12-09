package main

import (
	"fmt"
	"log"
)

func solve2(input string) int {
	result := 0

	lines, err := readLines(input)
	if err != nil {
		log.Fatal(err)
	}

	for _, line := range lines {
		fmt.Printf("Line from file: %s\n", line)
	}

	return result
}
