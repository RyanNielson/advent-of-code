package utils

import (
	"os"
	"strings"
)

func Lines(path string) []string {
	data := readFile(path)

	return strings.Split(data, "\n")
}

func readFile(path string) string {
	data, err := os.ReadFile(path)

	if err != nil {
		panic(err)
	}

	return strings.TrimSpace(string(data))
}
