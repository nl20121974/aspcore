<%
class htmlpropertiesclass

    private m_properties
    private m_kind

    sub class_initialize()
        set m_properties = server.createobject("scripting.dictionary")
    end sub
    
    public property get properties() set properties = m_properties end property

    public function id(p_id) m_properties("id") = p_id end function
    public function css(p_css) m_properties("class") = p_css end function
    public function name(p_name) m_properties("name") = p_name end function
    public function onchange(p_onchange) m_properties("onchange") = p_onchange end function
    public function onclick(p_onclick) m_properties("onclick") = p_onchange end function
    public function style(p_style) m_properties("style") = p_style end function
    public function required(p_required) m_properties("required") = p_required end function

    public default function item(p_key)
        item = m_properties(lcase(p_key))
    end function

    public function tostring()
        for each k in m_properties
            tostring = tostring & " " & k & "=""" & formatvalue(m_properties(k)) & """"
        next
    end function

    private function formatvalue(p_value)
        formatvalue = p_value
        if m_kind = "date" then
            formatvalue = dateinput(p_value)
        elseif m_kind = "time" then
            formatvalue = timeinput(p_value)
        elseif m_kind = "number" then
            if not isnull(p_value) then
                formatvalue = replace(p_value, ",", ".")
            end if
        end if
    end function

    sub class_terminate()
        set m_properties = nothing
    end sub
    

end class
%>
