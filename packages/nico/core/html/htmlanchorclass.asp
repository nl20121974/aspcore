<%
class htmlanchorclass

    private m_content
    private m_href
    private m_htmlproperties
    private m_properties

    sub class_initialize()
        set m_htmlproperties = new htmlpropertiesclass
        set m_properties = server.createobject("scripting.dictionary")
    end sub
    
    public function content(p_content) m_content = p_content : set content = me end function
    public function href(p_href) m_properties("href") = p_href : set href = me end function
    'htmlpropertiesclass
    public function id(p_id) m_htmlproperties.properties.item("id") = p_id : set id = me end function
    public function css(p_css) m_htmlproperties.properties.item("class") = p_css : set css = me end function
    public function name(p_name) m_htmlproperties.properties.item("name") = p_name : set name = me end function
    public function onchange(p_onchange) m_htmlproperties.properties.item("onchange") = p_onchange : set onchange = me end function
    public function onclick(p_onclick) m_htmlproperties.properties.item("onclick") = p_onchange : set onclick = me end function
    public function style(p_style) m_htmlproperties.properties.item("style") = p_style : set style = me end function

    public default function tostring()
        tostring = "<a " & m_htmlproperties.tostring()
        for each k in m_properties
            tostring = tostring & " " & k & "=" & m_properties(k)
        next
        tostring = tostring & "><span>" & m_content & "</span></a>"
    end function
end class
%>