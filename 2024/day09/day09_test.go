package day09

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestPart1(t *testing.T) {
	assert.Equal(t, 1928, Part1("input_example_1"))
	assert.Equal(t, 6390180901651, Part1("input"))
}

// func TestPart2(t *testing.T) {
// 	assert.Equal(t, 34, Part2("input_example_1"))
// 	assert.Equal(t, 1032, Part2("input"))
// }
