<!--#include virtual="/startup.asp"-->
<%
wallpapers_directory = "C:\inetpub\wwwroot\_wallpapers\"
set filesystemobject = server.createobject("scripting.filesystemobject")
set folder = filesystemobject.getfolder(wallpapers_directory)
set randoms = server.createobject("system.collections.arraylist")
index = 0
for each f in folder.files
    randoms.add f.name
next
randomize
index = int((randoms.count - 1) * rnd)
filename = randoms(index)
dim stream
set stream = server.createobject("adodb.stream")
with stream
    response.buffer = false
    response.contenttype = getmimetypes(getextension(filename))
    response.addheader "content-disposition", "inline;title=" & filename & ";filename=" & filename
    .open
    .type = 1
    .loadFromFile(replace(wallpapers_directory & replace(filename, "/", "\"), "\\", "\"))
    response.binarywrite .Read
    response.flush()
    .close
end with
set stream = nothing
%>