<%
class htmltextareaclass
    
    private m_kind
    private m_height
    private m_content
    public m_p
    public m_htmlproperties
    public m_properties
    public m_label

    sub class_initialize()
        m_p = false
        set m_htmlproperties = new htmlpropertiesclass
        set m_properties = server.createobject("scripting.dictionary")
    end sub

    public function label(p_label) m_label = p_label : set label = me end function
    public function p() p = true : set p = me end function
    public function height(p_height) m_height = p_height : set content = me end function
    public function content(p_content) m_content = p_content : set content = me end function
    'properties
    public function kind(p_kind) m_kind = p_kind : set kind = me end function
    public function spellcheck(p_spellcheck) m_properties("spellcheck") = p_spellcheck end function
    public function placeholder(p_placeholder) m_properties("placeholder") = p_placeholder : set placeholder = me end function
    public function rows(p_rows) m_properties("rows") = p_rows : set rows = me end function
    'htmlpropertiesclass
    public function id(p_id) m_htmlproperties.properties.item("id") = p_id : set id = me end function
    public function css(p_css) m_htmlproperties.properties.item("class") = p_css : set css = me end function
    public function name(p_name) m_htmlproperties.properties.item("name") = p_name : set name = me end function
    public function onchange(p_onchange) m_htmlproperties.properties.item("onchange") = p_onchange : set onchange = me end function
    public function onclick(p_onclick) m_htmlproperties.properties.item("onclick") = p_onclick : set onclick = me end function
    public function style(p_style) m_htmlproperties.properties.item("style") = p_style : set style = me end function
    public function required() m_htmlproperties.properties.item("required") = true : set required = me end function
    
    public default function tostring()
        dim result
        if not isempty(m_htmlproperties("required")) then
            result = result & "<span class=""w3-text-red""><b>*</b></span>" & vbcrlf
        end if
        result = result & "<br>"
        if not isempty(m_Height) then
            result = result & "<style type=""text/css"">#" & m_htmlproperties("id") & "_wrapper .ck-editor__editable { min-height: " & m_height & "px; } </style>" & vbcrlf
        end if
        result = result & "<textarea" & m_htmlproperties.tostring()
        for each k in m_properties
            result = result & " " & k & "=""" & m_properties(k) & """"
        next
        result = result & ">"
        result = result & m_content
        result = result & "</textarea>"
        tostring = (new htmlbuilderclass).decorate(me, result)
    end function

    sub class_terminate()
        set m_htmlproperties = nothing
        set m_properties = nothing
    end sub

end class
%>
