<%
function test(p_value)
    writer.write p_value
end function

function testend()
    writer.writeend
end function

function testtype(p_value)
    writer.writetype p_value
end function

function debug(p_value)
    debugger.write p_value
end function

function debugend()
    debugger.writeend
end function

function debugtype(p_value)
    debugger.writetype p_value
end function

function str(p_key)
    str = strings(config("current")("culture"))(p_key)
end function

public function redirect(p_url)
    response.redirect p_url
end function

function str_compare(str_value, int_value)
    str_compare = cstr(str_value) = cstr(int_value)
end function

function escape(p_value)
    escape = p_value
    if vartype(p_value) = 8 then
        escape = replace(p_value, "'", "''")
    end if
end function

function formatstring(p_value, p_pattern)
    dim result, index, i
    index = 1
    for i = 1 to len(p_pattern)
        if index > len(p_value) then exit for
        character = mid(p_pattern, i, 1)
        if character = "#" then
            result = result & mid(p_value, index, 1)
            index = index + 1
        else
            result = result & character
        end if
    next
    formatstring = result
end function

function sectionexists(p_section)
    sectionexists = false
    on error resume next
    sectionexists = not getref(p_section) is nothing
    if err.number <> 0 then
        err.clear
    end if
    on error goto 0
end function

function dateinput(value_date)
    dateinput = null
    if not IsDate(value_date) then exit function
    value_date = CDate(value_date)
    dateinput = Year(value_date) & "-" & format.digit(Month(value_date), 2) & "-" & format.digit(Day(value_date), 2)
end function

function timeinput(value_date)
    timeinput = null
    on error resume next
    timeinput = left(value_date, 5)
    on error goto 0
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

function substring(p_value, p_string)
    substring = replace(p_value, p_string, "")
end function

function explode(delimiter, value)
    explode = false
    if len(delimiter) = 0 then
        exit function
    end if
    explode = split(cstr(value), delimiter)
end function

function implode(glue, pieces)
    implode = join(pieces, glue)
end function

function randomnumber(p_digits)
    dim min, max
    min = 10 ^ (p_digits - 1)
    max = min * 10 - 1
    randomize
    randomnumber = int((max - min + 1) * rnd + min)
end function

function random(p_min, p_max)
    randomize
    random = int((p_max - p_min + 1) * rnd + p_min)
end function

function array_exists(p_array, p_key)
    array_exists = false
    on error resume next
    for each k in p_array
        if isarray(p_key) then
            for each i in p_key
                if cstr(k) = cstr(i) then
                    array_exists = true
                    exit for
                end if
            next
        else
            if cstr(k) = cstr(p_key) then
                array_exists = true
                exit for
            end if
        end if
    next
    on error goto 0
end function

sub sleep(p_seconds)
    dim waituntil
    waituntil = dateadd("s", p_seconds, now)
    do until (now > waituntil)
    loop
end sub

function ceil(p_number)

    ceil = int(p_number)

    if ceil <> p_number then

        ceil = ceil + 1

    end if

end function

function floor(p_number)

    floor = int(p_number)

end function

function savebinary(text, filename)
    set stream = server.createobject("adodb.stream")
    stream.open
    stream.type = 1
    stream.write text
    stream.position = 0
    set filesystem = server.createobject("scripting.filesystemobject")
    if filesystem.fileexists(filename) then
        filesystem.deletefile filename
    end if
    set filesystem = nothing
    stream.savetofile filename, 2
    stream.close
    set stream = Nothing
end function

function dateinput(p_value)
    dateinput = null
    if not isdate(p_value) then exit function
    p_value = cdate(p_value)
    dateinput = year(p_value) & "-" & formatdigit(month(p_value), 2) & "-" & formatdigit(day(p_value), 2)
end function

function timeinput(p_value)
    timeinput = null
    on error resume next
    timeinput = left(p_value, 5)
    on error goto 0
end function

function formatdigit(p_digit, length)
    ratio = length - len(p_digit)
    do while ratio > 0
        formatdigit = "0" & formatdigit
        ratio = ratio - 1
    loop
end function

function getmimetypes(p_extension)
    set mimetypes = server.createobject("scripting.dictionary")
    mimetypes.add "dwf", "drawing/x-dwf"
    mimetypes.add "jpeg", "image/jpeg"
    mimetypes.add "jpg", "image/jpg"
    mimetypes.add "png", "image/png"
    mimetypes.add "pdf", "application/pdf"
    mimetypes.add "doc", "application/msword"
    mimetypes.add "txt", "txt/plain"
    mimetypes.add "ini", "txt/ini"
    mimetypes.add "docx", "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    getmimetypes = mimetypes(p_extension)
end function

function getextension(p_filename)
    dim items
    items = split(p_filename, ".")
    getextension = items(ubound(items))
end function

function getstring(p_pattern, p_values)
    getstring = patterns(p_pattern)
    for i = 0 to ubound(p_values)
        getstring = replace(pattern, "{" & i & "}", p_values(i))
    next
end function

%>