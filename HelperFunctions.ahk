sortArray(arr,options="") {	; specify only "Flip" in the options to reverse otherwise unordered array items

	if	!IsObject(arr)
		return	0
	new :=	[]
	if	(options="Flip") {
		While	(i :=	arr.MaxIndex()-A_Index+1)
			new.Insert(arr[i])
		return	new
	}
	For each, item in arr
		list .=	item "`n"
	list :=	Trim(list,"`n")
	Sort, list, %options%
	Loop, parse, list, `n, `r
		new.Insert(A_LoopField)
	return	new

}

; Joins a string array together
Join(sep, params*) {
    for index,param in params
        str .= param . sep
    return SubStr(str, 1, -StrLen(sep))
}