<%
class wkhtmltopdfclass
    private m_shell
    private m_command
    private m_location
    private m_document
    private m_error
    private m_filename
    private m_header
    private m_footer
    private m_Result
    private m_T10
    private m_dpi
    private m_cover
    private m_margt
    private m_margl
    private m_margb
    private m_margr
    private m_async

    private sub class_initialize()
        set m_shell = server.CreateObject ("wscript.shell")
        m_command = "cmd /c ""C:\Program Files\wkhtmltopdf\bin\wkhtmltopdf.exe"" "
        m_error = false
    end sub

    public function async()
        m_async = true
        set async = me
    end function
    public function cover(p_cover)
        m_cover = p_cover
    end function
    public property get Result() Result = m_Result end property
    public function footer(p_footer)
        m_footer = p_footer
        set footer = me
    end function
    public function margt(p_margt)
        m_margt = p_margt
        set margt = me
    end function
    public function margb(p_margb)
        m_margb = p_margb
        set margb = me
    end function
    public function margl(p_margl)
        m_margl= p_margl
        set margl = me
    end function
    public function margr(p_margr)
        m_margr = p_margr
        set margr = me
    end function
    public function header(p_header)
        m_header = p_header
        set header = me
    end function
    public function guid()
        m_filename = CreateGuid() & ".pdf"
        set guid = me
    end function
    public property get filepath
        filepath = "/" & m_location & "/" & m_filename
    end property
    public function document(p_document)
        m_document = p_document
        set document = me
    end function
    public function dpi(p_dpi)
        m_dpi = p_dpi
        set dpi = me
    end function
    public function location(p_location)
        m_location = p_location
        set location = me
    end function
    public function filename(p_filename)
        m_filename = p_filename
        set filename = me
    end function
    public function build()
        m_command = m_command & "  --dpi 300 "
        if not isempty(m_margt) then
            m_command = m_command & "  -T " & m_margt & "mm "
        end if
        if not isempty(m_margl) then
            m_command = m_command & "  -L " & m_margl & "mm "
        end if
        if not isempty(m_margb) then
            m_command = m_command & "  -B " & m_margb & "mm "
        end if
        if not isempty(m_margr) then
            m_command = m_command & "  -R " & m_margr & "mm "
        end if
        if not isempty(m_header) then
            m_command = m_command & " --header-html " & m_header' & " --header-spacing 20"
        end if
        if not isempty(m_footer) then
            m_command = m_command & " --footer-html " & m_footer' & " --footer-spacing 20"
        end if
        if not isempty(m_cover) then
            m_command = m_command & " cover " & m_cover
        end if
        m_command = m_command & " " & m_document & " " & format.path(m_location & "\" & m_filename)
        set build = me
    end function
    public function run()
        if m_async then
            m_shell.run m_command, 0, false
        else
            run = false
            m_Result = m_shell.run(m_command, 0, true)
            if m_Result = 0 then
                run = true
            end if
        end if
    end function
    private sub class_terminate()
        set m_shell = nothing
    end sub
end class
%>