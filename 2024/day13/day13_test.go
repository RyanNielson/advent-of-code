package day13

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestPart1(t *testing.T) {
	assert.Equal(t, 480, Part1("input_example_1"))
	assert.Equal(t, 28753, Part1("input"))
}

func TestPart2(t *testing.T) {
	assert.Equal(t, 102718967795500, Part2("input"))
}
