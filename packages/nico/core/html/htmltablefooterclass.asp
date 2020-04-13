<%
class htmltablefooterclass
    
    private m_page
    private m_recordcount
    private m_querystring
    private m_pagesize
    private m_pagecount
    private m_css

    sub class_initialize()
        m_page = querystring("page")
        for each k in querystring
            if k <> "page" and k <> "search" and not isempty(querystring(k)) then
                m_querystring = m_querystring & "&" & k & "=" & querystring(k)
            end if
        next
    end sub

    public function pagesize(p_pagesize) m_pagesize = cint(p_pagesize) : set pagesize = me end function
    public function css(p_css) m_css = p_css : set css = me end function

    public function recordcount(p_recordcount)
        m_recordcount = p_recordcount
        m_pagecount = cdbl(m_recordcount * 1.0 / m_pagesize)
        if m_pagecount > (m_recordcount / m_pagesize) then
            m_pagecount = clng(m_pagecount) + 1
        elseif m_pagecount < (m_recordcount / m_pagesize) then
            m_pagecount = clng(m_pagecount) - 1
        else
            m_pagecount = clng(m_pagecount)
        end if
        set recordcount = me
    end function

    public default function tostring %>
<% if m_recordcount > 0 then %>
<nav class="<%=m_css %>">
    <div class="w3-bar w3-border">
        <% if m_pagecount > 1 then %>
        <a class="w3-btn">
            <span><%=m_page %> / <%=m_pagecount %></span>
        </a>
        <a <% if m_pagecount = 1 then %>disabled<% end if %> class="w3-btn <% if m_page = 1 then %>w3-disabled<% end if %>" <% if m_page = 1 then %>onclick="return false;" <% end if %> href="?page=<%=m_page - 1 %><% if not IsEmpty(m_querystring) then %><%=m_querystring %><% end if %>">
            <span>&larr;</span>
        </a>
        <% max_count = m_page + 10 %>
        <% if max_count > m_pagecount then %>
        <% max_count = m_pagecount %>
        <% end if %>
        <select <% if m_pagecount = 1 then %>disabled<% end if %> class="w3-btn <% if m_pagecount = 1 then %>w3-disabled<% end if %>" id="page" name="page" onchange="this.form.submit();">
            <% dim i %>
            <% for i = 1 to max_count %>
            <option value="<%=i %>" <% if m_page = i then %>selected<% end if %>><%=format.digit(i, 2).tostring() %></option>
            <% next %>
        </select>
        <a <% if m_pagecount = 1 then %>disabled<% end if %> class="w3-btn <% if m_page = m_pagecount then %>w3-disabled<% end if %>" <% if m_page = m_pagecount then %>onclick="return false;" <% end if %> href="?page=<%=m_page + 1 %><% if not IsEmpty(m_querystring) then %><%=m_querystring %><% end if %>">
            <span>&rarr;</span>
        </a>
        <% end if %>
        <a class="w3-btn">
            <span><%=m_recordcount & " " & "trouvés" %></span>
        </a>
    </div>
</nav>
<% end if %>
<% end function

end class
%>