<!--#include virtual="/startup.asp"-->
<%
response.lcid = 1033
response.ContentType = "application/json"
if request.servervariables("request_method") = "POST" then
    for each file in uploads()
        filename = uid & "." & file.fileext
        file.saveas cstr(format.path(config("filesdirectory") & "\ckeditor\" & filename)) 
        set json = new jsonobject
        json.add "url", "?path=editor&filename=" & filename
        json.write()
    next
end if
response.end
%>