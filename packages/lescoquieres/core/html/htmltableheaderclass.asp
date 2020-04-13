<%
class htmltableheaderclass

    private m_icons
    private m_content
    private m_columnname

    public function icons(p_icons) m_icons = p_icons : set icons = me end function
    public function content(p_content) m_content = p_content : set content = me end function
    public function columnname(p_columnname) m_columnname = p_columnname : set columnname = me end function

    public function url()
        if request.querystring("order") = m_columnname then
            order_name = m_columnname & "2"
        else
            order_name = m_columnname
        end if
        url = "?order=" & order_name
        if request.querystring.Count > 0 then
            url = url & "&" & replace(replace(request.querystring, "order=" & request.querystring("order"), ""), "&&", "&")
        end if
        url = replace(url, "&&", "&")
        if right(url, 1) = "&" then url = left(url, len(url) - 1)
    end function

    public default sub tostring()
        dim result
        result = result & "<a href=""" & url() & """><span style=""display:inline-block"">" & m_content & "</span>"
        orders = split(request.querystring("order"), ",")
        if not isempty(querystring("order")) then
            if ubound(orders) >= 0 then
                order = orders(0)
            end if
            if instr(order, m_columnname & "2") > 0 then
                result = result & m_icons(0)
            elseif instr(order, m_columnname) then
                result = result & m_icons(1)
            end if
        end if
        result = result & "</a>"
        response.Write result
    end sub

end class
%>