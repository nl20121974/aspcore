<%
class htmlcontentclass

    public m_properties
    public m_htmlproperties
    public m_kind
    public m_content
    public m_label
    public m_p
    public m_fallback

    sub class_initialize()
        set m_properties = server.createobject("scripting.dictionary")
        set m_htmlproperties = new htmlpropertiesclass
    end sub
    
    public property get properties() set properties = m_properties end property
    
    public function fallback(p_fallback) m_fallback = p_fallback : set fallback = me end function
    public function kind(p_kind) m_kind = p_kind : set kind = me end function
    public function label(p_label) m_label = p_label : set label = me end function
    public function p() m_p = true : set p = me end function
    public function content(p_content) m_content = p_content : set content = me end function
    'htmlpropertiesclass
    public function id(p_id) m_htmlproperties.properties.item("id") = p_id : set id = me end function
    public function css(p_css) m_htmlproperties.properties.item("class") = p_css : set css = me end function
    public function name(p_name) m_htmlproperties.properties.item("name") = p_name : set name = me end function
    public function onchange(p_onchange) m_htmlproperties.properties.item("onchange") = p_onchange : set onchange = me end function
    public function onclick(p_onclick) m_htmlproperties.properties.item("onclick") = p_onclick : set onclick = me end function
    public function style(p_style) m_htmlproperties.properties.item("style") = p_style : set style = me end function

    public default function tostring()
        dim result
        if isnull(m_content) or isempty(m_content) then
            result = "<" & m_kind & " " & m_htmlproperties.tostring() & ">" & m_fallback & "</" & m_kind & ">"
        else
            result = "<" & m_kind & " " & m_htmlproperties.tostring() & ">" & m_content & "</" & m_kind & ">"
        end if
        tostring = (new htmlbuilderclass).decorate(me, result)
    end function
end class
%>
