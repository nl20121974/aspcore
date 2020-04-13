<%
class htmlbuilderclass
    public function decorate(p_element, p_result)
        if not isempty(m_p) then
            decorate = decorate & "<p>" & vbcrlf
        end if
        if not isempty(p_element.m_label) then
            decorate = decorate & vtab & "<label>" & p_element.m_label & "</label>" & vbcrlf
        end if
        if not isempty(p_element.m_htmlproperties("required")) then
            decorate = decorate & "<span class=""w3-text-red""><b>*</b></span>" & vbcrlf
        end if
        decorate = decorate & p_result & vbcrlf
        if not isempty(m_height) then
            decorate = decorate & "<style type=""text/css"">#" & p_element.htmlproperties("id") & "_wrapper .ck-editor__editable { min-height: " & m_height & "px; } </style>" & vbcrlf
        end if
        if not isempty(m_label) then
            decorate = decorate & vtab & "</label>" & vbcrlf
        end if
        if not isempty(m_p) then
            decorate = decorate & "</p>" & vbcrlf
        end if
    end function
end class
%>