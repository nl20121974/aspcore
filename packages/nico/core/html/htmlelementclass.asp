<%
class htmlelementclass

    private m_htmlproperties
    private m_kind
    private m_content

    sub class_initialize()
        set m_htmlproperties = server.createobject("scripting.dictionary")
    end sub

    public function kind(p_kind) m_kind = p_kind end function
    public function content(p_content) m_content = p_content end function
    'htmlpropertiesclass
    public function id(p_id) m_htmlproperties.properties.item("id") = p_id end function
    public function css(p_css) m_htmlproperties.properties.item("class") = p_css end function
    public function name(p_name) m_htmlproperties.properties.item("name") = p_name end function
    public function onchange(p_onchange) m_htmlproperties.properties.item("onchange") = p_onchange end function
    public function onclick(p_onclick) m_htmlproperties.properties.item("onclick") = p_onchange end function
    public function style(p_style) m_htmlproperties.properties.item("style") = p_style end function

    public default function tostring()
        tostring = "<" & m_kind & " " & m_htmlproperties.tostring() & ">"    end function
end class
%>
