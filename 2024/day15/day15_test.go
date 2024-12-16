package day15

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestPart1(t *testing.T) {
	assert.Equal(t, 10092, Part1("input_example_2"))
	assert.Equal(t, 1, Part1("input"))
}

// func TestPart2(t *testing.T) {
// 	// assert.Equal(t, 102718967795500, Part2("input", 101, 103))
// }
