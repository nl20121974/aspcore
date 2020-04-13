<%
class htmlcallerclass
    
    private m_method
    private m_action
    private m_Icon
    private m_Id
    private m_Hiddens
    private m_Label
    private m_span
    private m_service
    private m_success
    private m_error
    private m_css
    private m_confirm
    private m_title
    private m_onsubmit

    sub class_initialize()
        set m_hiddens = server.CreateObject("scripting.dictionary")
    end sub    
    
    public function title(p_title) m_title = p_title : set title = me end function
    public function icon(p_Icon) m_Icon = p_Icon : set Icon = me end function
    public function id(p_Id) m_Id = p_Id : set Id = me end function
    public function action(p_action) m_action = p_action : set action = me end function
    public function service(p_service) m_service = p_service : set service = me end function
    public function method(p_method) m_method = p_method : set method = me end function
    public function hide(p_Name, p_value) m_Hiddens.add p_Name, p_value : set hide = me end function
    public function label(p_Label) m_Label = p_Label : set Label = me end function
    public function span(p_span) m_span = p_span : set span = me end function
    public function css(p_css) m_css = p_css : set css = me end function
    public function success(p_success) m_success = p_success : set success = me end function
    public function confirm(p_confirm) m_confirm = p_confirm : set confirm = me end function
    public function onsubmit(p_onsubmit) m_onsubmit = p_onsubmit : set onsubmit = me end function

    public default function tostring()
        dim result, k, g
        g = replace(cstr(guid.tostring), "-", "")
        if isempty(m_confirm) then
            onclick = "$('#" & g & "').submit()"
        else
            onclick = "if (window.confirm('" & m_confirm & "')) { document.getElementById('" & g & "').submit(); }"
        end if
        if not isempty(m_onsubmit) then
            onclick = m_onsubmit & ";" & onclick
        end if
        if not isempty(m_Label) then
            result = result & "<a title=""" & m_title & """ class=""" & m_css & """ onclick=""" & onclick & """>" & m_label & "</a>" & vbcrlf
        end if
        if not isempty(m_span) then
            result = result & "<a title=""" & m_title & """ class="" " & m_css & """ onclick=""" & onclick & """>" & m_span & "</a>" & vbcrlf
        end if

        if not isempty(m_icon) then
            result = result & "<i title=""" & m_title & """ class=""" & m_icon & """ onclick=""" & onclick & """></i>" & vbcrlf
        end if
        result = result & vbtab & "<form id=""" & g & """ method=""post"" class=""w3-hide"">"
        result = result & vbcrlf & vbtab & vbtab & html.antiforgerytoken.tostring
        for each k in m_hiddens.keys
            result = result & vbcrlf & vbtab & vbtab & html.hidden(k).value(m_hiddens(k))
        next
        if not isempty(m_method) then
            result = result & vbcrlf & vbtab & vbtab & html.hidden("method_name").value(m_method)
        end if
        if not isempty(m_service) then
            result = result & vbcrlf & vbtab & vbtab & html.hidden("service_name").value(m_service)
        end if
        if not isempty(m_success) then
            result = result & vbcrlf & vbtab & vbtab & html.hidden("success").value(m_success)
        end if
        result = result & vbtab & vbcrlf & "</form>"
        tostring = vbcrlf & result
    end function

end class
%>
