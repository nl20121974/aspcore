<%
class htmlajaxclass
    private m_id
    private m_url
    private m_method
    private m_onload
    private m_formname
    private m_callback

    sub class_initialize()
        m_method = "GET"
        m_onload = true
        m_callback = "undefined"
    end sub

    public function id(p_id) m_id = p_id : m_formname = p_id : set id = me : end function
    public function url(p_url) m_url = p_url : set url = me : end function
    public function formname(p_formname) m_formname = p_formname : set formname = me : end function
    public function method(p_method) m_method = p_method : set method = me : end function
    public function onload(p_onload) m_onload = p_onload : set onload = me : end function
    public function callback(p_callback) m_callback = p_callback : set callback = me : end function
    
    public default function tostring()
        tostring = tostring & "<script>"
        if m_onload then
            tostring = tostring & "window.addEventListener('load', function () { "
        end if
        tostring = tostring & "register_async('" & m_id & "', '" & m_formname & "', '" & m_url & "', '" & m_method & "');"
        if m_onload then
            tostring = tostring & " });"
        end if
        tostring = tostring & "</script>"
    end function
end class
%>