<%
class jsonreader
    public function read(byval p_path)
        set filesystemobject = server.createobject("scripting.filesystemobject")
        set json = new jsonobject
        set read = json.parse(server.createobject("scripting.filesystemobject").opentextfile(p_path, 1).readall())
        set json = nothing
        set filesystemobject = nothing
    end function
end class
%>