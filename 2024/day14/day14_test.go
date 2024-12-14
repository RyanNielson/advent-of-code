package day14

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestPart1(t *testing.T) {
	assert.Equal(t, 12, Part1("input_example_1", 11, 7))
	assert.Equal(t, 218295000, Part1("input", 101, 103))
}

// func TestPart2(t *testing.T) {
// 	assert.Equal(t, 102718967795500, Part2("input"))
// }
