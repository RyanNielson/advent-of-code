package day22

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestPart1(t *testing.T) {
	assert.Equal(t, 37327623, Part1("input_example_1"))
	assert.Equal(t, 12979353889, Part1("input"))
}

func TestPart2(t *testing.T) {
	assert.Equal(t, 23, Part2("input_example_2"))
	assert.Equal(t, 1, Part2("input"))
}
