zeroPad(string, length) {
	padLength := length - strlen(string)
	pads := ""
	while (padLength--)
		pads .= "0"
	return pads . string
}