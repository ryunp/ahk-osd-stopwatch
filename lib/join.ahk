join(array, delim) {
	result := ""
	for i, v in array
		result .= v (i < array.Length() ? delim : "")
	return result
}