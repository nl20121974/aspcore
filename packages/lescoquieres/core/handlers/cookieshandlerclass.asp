<%
class cookieshandlerclass

    private m_cookies
    private m_expires

    sub class_initialize()
        m_expires = dateadd("yyyy", 1, date)
        set m_cookies = server.createobject("scripting.dictionary")
    end sub

    public property get cookies() set cookies = m_cookies end property
    public property let expires(p_expires) m_expires = p_expires end property

    public function handle()
        m_cookies.removeall
        for each k in request.cookies
            if trim(request.cookies(k)) <> "" then
                m_cookies.add k, request.cookies(k)
            end if
        next
    end function
    
    function add(p_key, p_value)
        if not isnull(p_value) or trim(p_value) <> "" then
            response.cookies(p_key) = p_value
            response.cookies(p_key).expires = m_expires
            handle
        end if
    end function

    function remove(p_key)
        response.cookies(p_key).expires = date - 1
        handle
    end function

    function removeall()
        for each k in request.cookies
            response.cookies(k).expires = date - 1
        next
        handle
    end function

end class
%>
