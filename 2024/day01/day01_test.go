package day01

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestPart1(t *testing.T) {
	assert.Equal(t, 11, Part1("input_example_1"))
	assert.Equal(t, 1651298, Part1("input"))
}

func TestPart2(t *testing.T) {
	assert.Equal(t, 31, Part2("input_example_1"))
	assert.Equal(t, 21306195, Part2("input"))
}
