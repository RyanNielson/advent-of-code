package day23

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestPart1(t *testing.T) {
	assert.Equal(t, 7, Part1("input_example_1"))
	assert.Equal(t, 1358, Part1("input"))
}
