package utils

import (
	"os"
	"strings"
)

func FileText(path string) string {
	return readFile(path)
}

func FileLines(path string) []string {
	data := readFile(path)

	return strings.Split(data, "\n")
}

func FileCharacters(path string) [][]string {
	data := readFile(path)

	lines := strings.Split(data, "\n")

	var characters [][]string
	for _, line := range lines {
		characters = append(characters, strings.Split(line, ""))
		// characters[y] = strings.Split(line, "")
	}

	return characters
}

func readFile(path string) string {
	data, err := os.ReadFile(path)

	if err != nil {
		panic(err)
	}

	return strings.TrimSpace(string(data))
}
