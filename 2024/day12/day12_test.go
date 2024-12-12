package day12

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestPart1(t *testing.T) {
	assert.Equal(t, 140, Part1("input_example_1"))
	assert.Equal(t, 772, Part1("input_example_2"))
	assert.Equal(t, 1930, Part1("input_example_3"))
	assert.Equal(t, 1488414, Part1("input"))
}

// func TestPart2(t *testing.T) {
// 	assert.Equal(t, 234568186890978, Part2("input"))
// }
