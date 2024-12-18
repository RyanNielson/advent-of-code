package utils

import "math"

func AbsInt(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func PowInt(x, y int) int {
	return int(math.Pow(float64(x), float64(y)))
}
