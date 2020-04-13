<%
class htmlchecklistclass

    private htmlpropertiesclass
    private m_properties
    private m_key
    private m_text
    private m_value
    private m_items
    private m_blank
    public m_label
    public m_p

    sub class_initialize()
        set m_htmlproperties = new htmlpropertiesclass
        set m_properties = server.createobject("scripting.dictionary")
    end sub
    
    public property get properties() set properties = m_properties end property
    public function label(p_label) m_label = p_label : set label = me end function
    public function p() m_p = true : set p = me end function
    public function blank(p_blank) m_blank = p_blank : set blank = me end function
    public function required() m_properties("required") = "required" : set required = me end function
    public function text(p_text) m_properties("text") = p_text : set text = me end function
    public function key(p_key) m_key = p_key : set key = me end function
    public function items(p_items) set m_items = p_items : set items = me end function
    public function value(p_value) m_value = p_value : set Value = me end function
    public function defaulttext(p_defaulttext) m_defaulttext = p_defaulttext : set defaulttext = me end function
    'htmlpropertiesclass
    public function id(p_id) m_htmlproperties.properties.item("id") = p_id : set id = me end function
    public function css(p_css) m_htmlproperties.properties.item("class") = p_css : set css = me end function
    public function name(p_name) m_htmlproperties.properties.item("name") = p_name : set name = me end function
    public function onchange(p_onchange) m_htmlproperties.properties.item("onchange") = p_onchange : set onchange = me end function
    public function onclick(p_onclick) m_htmlproperties.properties.item("onclick") = p_onclick : set onclick = me end function
    public function style(p_style) m_htmlproperties.properties.item("style") = p_style : set style = me end function

    public default function tostring()
        dim result
        result = result & vtab & "<select " & m_htmlproperties.tostring()
        for each k in m_properties
            result = result & " " & k & "=""" & m_properties(k) & """"
        next
        result = result & ">" & vbcrlf
        if not isempty(m_blank) then
            result = result & vtab & vtab & "<option value="""">" & m_blank & "</option>"
        end if
        for i = -1 to 0
            result = result & vtab & vtab & "<option value=""" & i & """"
            if not isnull(m_value) and not isnull(m_items(m_key)) then
                if cstr(m_value) = cstr(i) then
                    result = result & " selected=""selected"" "
                end if
            end if    
            result = result & ">" & cultureinfo("boolean")(i + 1) & "</option>" & vbcrlf
        next
        result = result & vtab & "</select>"
        tostring = result
    end function

end class
%>
