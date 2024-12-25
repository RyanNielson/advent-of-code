package day25

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestPart1(t *testing.T) {
	assert.Equal(t, 3, Part1("input_example_1"))
	assert.Equal(t, 1, Part1("input"))
	// assert.Equal(t, 57270694330992, Part1("input"))
}
