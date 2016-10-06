merge(to, from) {
	for k,v in from
		if to.HasKey(k)
			to[k] := v
}