<%
'trycreatepath
public function trycreatepath(byval p_path)
    dim index, filesystemobject, path
    set filesystemobject = server.createobject("scripting.filesystemobject")
    path = lcase(p_path)
    if right(path, 1) <> "\" then path = path & "\" 
    if left(path, 2) = "\\" then 
        index = instr(3, path, "\") 
    else 
        index = 3 
    end if
    do while index > 0 
        index = instr(index + 1, path, "\") 
        if not filesystemobject.folderexists(left(path, index)) and index > 0 then
            filesystemobject.createfolder left(path, index)
        end if 
    loop 
    set filesystemobject = nothing
end function

'pluralize
public function pluralize(p_value)
    dim val
    val = p_value
    if right(val, 1) = "y" then
        val = left(p_value, len(p_value) - 1) & "ie"
    elseif right(val, 1) = "s" then
        pluralize = val
        exit function
    end if
    pluralize = val & "s"
end function

function testend()
    response.end
end function

sub test(p_value)
    response.write "<div style=""background: #00ff90;padding: 2px 5px"">" & p_value & "</div>"
end sub

public function areauri(p_area)
    if p_area <> "" then
        areauri = lcase("/" & p_area)
    else
        areauri = empty
    end if
end function

public function areapath(p_area)
    if p_area <> "" then
        areapath = lcase("/areas/" & p_area)
    else
        areapath = empty
    end if
end function

function arraycontains(p_values, p_value)
    dim arr
    if IsNull(p_values) then
        ArraysContains = false
        exit function
    end if
    dim i
    arr = Split(p_values, ",")
    arraycontains = false
    if IsNull(p_value) or p_value = "" then
        exit function
    end if
    for i = 0 to UBound(arr)
        arr(i) = Trim(arr(i))   
        if CStr(arr(i)) = CStr(p_value) then
            arraycontains = true
            exit function
        end if
    next
end function
%>