<%
class formhandlerclass

    private m_keys
    private m_form

    sub class_initialize()
        set m_form = server.createobject("scripting.dictionary")
    end sub

    public property get form() set form = m_form end property

    public function handle()
        dim smartupload, keys
        set keys = server.createobject("system.collections.arraylist")
        if instr(1, request.servervariables("http_content_type"), "multipart", 1) = 1 then
            set smartupload = server.createobject("aspsmartupload.smartupload")
            smartupload.maxfilesize = 2000000000
            smartupload.upload
            for each k in smartupload.form
                keys.add k
            next
            keys.sort
            for each k in keys
                if trim(smartupload.form(k)) <> "" then
                    m_form.add k, smartupload.form(k)
                else
                    m_form.add k, empty
                end if
            next
            set m_form("files") = smartupload.files
        else
            for each k in request.form
                keys.add k
            next
            keys.sort
            for each k in keys
                if trim(request.form(k)) <> "" then
                    m_form.add k, request.form(k)
                else
                    m_form.add k, empty
                end if
            next
        end if
    end function

end class
%>
