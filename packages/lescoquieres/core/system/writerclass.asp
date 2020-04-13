<%
class writerclass

    private m_starttime
    private m_background
    private m_foreground
    private m_active

    sub class_initialize()
        m_starttime = timer
        m_active = true
    end sub

    public property let foreground(p_foreground) m_foreground = p_foreground end property
    public property let background(p_background) m_background = p_background end property
    public property let active(p_active) m_active = p_active end property

    sub write(p_value)
        if m_active then
            response.write "<div style=""display:block; padding: 3px 10px; background:" & m_background & "; color: " & m_foreground & """>" & p_value & "</div>"
        end if
    end sub

    sub writetype(p_var)
        write typename(p_var)
    end sub

    sub writeend()
        response.end
    end sub

    sub writetime()
        write (timer - m_starttime)
    end sub

    function handle()
        if request.querystring("mode") <> "" then
            if request.querystring("mode") = "debug" then
                response.cookies("mode") = "debug"
            elseif request.querystring("mode") = "normal" then
                response.cookies("mode") = ""
            end if
            redirect
        end if
    end function

    function redirect()
        dim result
        for each k in request.querystring
            if k <> "mode" then
                result = result & "&" & k & "=" & request.querystring(k)
            end if
        next
        if not isempty(result) then
            response.redirect "?" & right(result, len(result) - 1)
        else
            response.redirect "?"
        end if
    end function

    sub start()
        response.Cookies("mode") = "debug"
    end sub

    sub terminate()
        response.cookies("mode").expires(dateadd("d", -1, date))
    end sub

end class
%>