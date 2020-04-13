<%
class filehandlerclass

    private m_basedirectory
    private m_filesystem

    sub class_initialize()
        set m_filesystem = server.createObject("scripting.filesystemobject")
    end sub

    public property let basedirectory(p_basedirectory) m_basedirectory = p_basedirectory end property

    public function handle()
        if trim(request.querystring("path")) = "" or trim(request.querystring("filename")) = "" then
            exit function
        end if
        dim stream
        set stream = server.createObject("adodb.stream")
        with stream
            response.contenttype = getmimetypes(getextension(request.querystring("filename")))
            response.addheader "content-disposition", "inline;title=" & request.querystring("filename") & ";filename=" & request.querystring("filename")
            .Open
            .Type = 1
            if trim(request.querystring("path")) = "" then
                .loadfromfile(replace(m_basedirectory & "\" & replace(request.querystring("filename"), "/", "\"), "\\", "\"))
            else
                .loadfromfile(replace(m_basedirectory & "\" & request.querystring("path") & "\" & replace(request.querystring("filename"), "/", "\"), "\\", "\"))
            end if
            response.binarywrite .read
            response.flush()
            .close
        end with
        set stream = Nothing
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

end class
%>