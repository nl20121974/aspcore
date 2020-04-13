<%
class htmlinputclass

    public m_htmlproperties
    public m_kind
    public m_properties
    public m_label
    public m_p

    sub class_initialize()
        set m_htmlproperties = new htmlpropertiesclass
        set m_properties = server.createobject("scripting.dictionary")
    end sub
    
    public function label(p_label) m_label = p_label : set label = me end function
    public function p() m_p = true : set p = me end function
    'properties
    public function kind(p_kind) m_kind = p_kind : set kind = me end function
    public function spellcheck(p_spellcheck) m_properties("spellcheck") = p_spellcheck end function
    public function value(p_value) m_properties("value") = p_value : set value = me end function
    public function required() m_properties("required") = "required" : set required = me end function
    public function float() m_properties("float") = "any" : set float = me end function
    public function maxlength(p_maxlength) m_properties("maxlength") = p_maxlength : set maxlength = me end function
    public function checked(p_checked) m_properties("checked") = p_checked : set checked = me end function
    public function placeholder(p_placeholder) m_properties("placeholder") = p_placeholder : set placeholder = me end function
    'htmlpropertiesclass
    public function id(p_id) m_htmlproperties.properties.item("id") = p_id : set id = me end function
    public function css(p_css) m_htmlproperties.properties.item("class") = p_css : set css = me end function
    public function name(p_name) m_htmlproperties.properties.item("name") = p_name : set name = me end function
    public function onchange(p_onchange) m_htmlproperties.properties.item("onchange") = p_onchange : set onchange = me end function
    public function onclick(p_onclick) m_htmlproperties.properties.item("onclick") = p_onclick : set onclick = me end function
    public function style(p_style) m_htmlproperties.properties.item("style") = p_style : set style = me end function

    public default function tostring()
        dim result
        result = "<input type=""" & m_kind & """" & m_htmlproperties.tostring()
        for each k in m_properties
            result = result & " " & k & "=""" & m_properties(k) & """"
        next
        result = result & " />"
        tostring = (new htmlbuilderclass).decorate(me, result)
    end function
end class
%>