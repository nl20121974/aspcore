<%
class querystringhandlerclass

    private m_keys
    private m_querystring

    sub class_initialize()
        set m_querystring = server.createobject("scripting.dictionary")
        set m_keys = server.createobject("system.collections.arraylist")
    end sub

    public property get querystring() set querystring = m_querystring end property

    public function handle()
        for each k in request.querystring
            if trim(request.querystring(k)) <> "" then
                m_keys.add k
            end if
        next
        m_keys.sort
        for each k in m_keys
            m_querystring.add k, request.querystring(k)
        next
        if isempty(request.querystring("page")) then
            m_querystring("page") = 1
        else
            m_querystring("page") = clng(request.querystring("page"))
        end if
    end function

end class
%>
