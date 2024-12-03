package day03

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestPart1(t *testing.T) {
	assert.Equal(t, 161, Part1("input_example_1"))
	assert.Equal(t, 182619815, Part1("input"))
}

func TestPart2(t *testing.T) {
	assert.Equal(t, 48, Part2("input_example_2"))
	assert.Equal(t, 80747545, Part2("input"))
}
