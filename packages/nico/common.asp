<% 
function str(p_key)
    str = strings(config("current")("culture"))(p_key)
end function

function getstring(p_pattern, p_values)
    getstring = patterns(p_pattern)
    for i = 0 to ubound(p_values)
        getstring = replace(pattern, "{" & i & "}", p_values(i))
    next
end function
%>