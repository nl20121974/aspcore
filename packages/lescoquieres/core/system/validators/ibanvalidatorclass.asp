<%
class ibanvalidatorclass
    
    function mod97(byval vIban)
        dim i, m, digit
        m = 0
        for i = 1 to len(vIban)
		    if not isnumeric(Mid(vIban, i, 1)) then
			    mod97 = m
			    exit function
		    end if
            digit = cint(Mid(vIban, i, 1))
            m = (10*m + digit) mod 97
        next
        mod97 = m
    end function

    function isvalid(p_value)
	    p_value = cstr(p_value)
	    dim x
	    p_value = replace(p_value, " ", "")
	    p_value = replace(p_value, "-", "")
	    if len(p_value) < 4 then
		    isvalid = false
		    exit function
	    end if
	    p_value = right(p_value, len(p_value) - 4) & Left(p_value, 4)
	    n = 1
	    while n <= len(p_value)
		    x = mid(p_value, n, 1)
		    if not isnumeric(x) Then
			    p_value = Replace(p_value, x, Asc(cstr(x)) - 55, 1, 1)
		    end if
		    n = n + 1
	    wend
	    isvalid = (mod97(p_value) = 1)
    end function

end class
%>
