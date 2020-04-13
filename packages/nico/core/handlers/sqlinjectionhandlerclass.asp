<%
class sqlinjectionhandlerclass

    private m_errorpage
    private m_blacklist

    sub class_initialize
        m_blacklist = Array("--", ";", "/*", "*/", "@@",_
            "char", "nchar", "varchar", "nvarchar",_
            "alter", "begin", "cast", "create", "cursor",_
            "declare", "delete", "drop ", "end", "exec",_
            "execute", "fetch", "insert", "kill", "open",_
            "select", "sys", "sysobjects", "syscolumns",_
            "table", "update", "union")
    end sub

    public property let errorpage(p_errorpage) m_errorpage = p_errorpage end property

    private function blacklisted(p_string)
        if (isempty(p_string)) then
            blacklisted = false
            exit function
        elseif (strcomp(p_string, "") = 0) then
            blacklisted = false
            exit function
        end if
        p_string = lcase(p_string)  
        for each black in m_blacklist
            if (InStr(p_string, " " & black & " ") <> 0) then
                blacklisted = true
                exit function
            end if
        next
        blacklisted = false  
    end function 

    public function handle()

        for each key in request.form
            if (blacklisted(request.form(key))) then
                redirect(m_errorpage & "?exception=INVALID_KEY&args=" & key & "&value=" & request.form(key))
            end if
        next

        for each key in request.querystring
            if (blacklisted(request.querystring(key))) then
                redirect(m_errorpage & "?exception=INVALID_KEY&key=" & key & "&value=" & request.querystring(key))
            end if
        next

        for each key in request.cookies
            if (blacklisted(request.cookies(key))) then
                redirect(m_errorpage & "?exception=INVALID_KEY&key=" & key & "&value=" & request.cookies(key))
            end if  
        next

        set handle = me

    end function
end class
%>