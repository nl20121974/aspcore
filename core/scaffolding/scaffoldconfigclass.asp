<%
class scaffoldconfigclass
    private m_connectionstring

    sub class_initialize()
        if value("projectpath") <> "" then
            set json = (new jsonreader).read(value("projectpath") & "\config.json")
            m_connectionstring = json("connectionstring")
        end if
    end sub

    public property get areauri()
        if value("area") <> "" then
            areauri = lcase("/" & value("area"))
        else
            areauri = empty
        end if
    end property

    public property get areapath()
        if value("area") <> "" then
            areapath = lcase("/areas/" & value("area"))
        else
            areapath = empty
        end if
    end property

    public property get connectionstring() connectionstring = m_connectionstring end property

    public default function value(p_key)
        if session("projectpath") <> "" then
            value = lcase(session(p_key))
        else
            value = lcase(request.querystring(p_key))
        end if
    end function
end class
%>