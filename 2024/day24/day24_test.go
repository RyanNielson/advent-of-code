package day24

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestPart1(t *testing.T) {
	assert.Equal(t, 4, Part1("input_example_1"))
	assert.Equal(t, 2024, Part1("input_example_2"))
	assert.Equal(t, 57270694330992, Part1("input"))
}
