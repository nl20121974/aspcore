<!--#include virtual="/startup.asp"-->
<%
set tables = schemaservice.gettables(empty)
area_name = areapath(request.querystring("area"))
%>
[
class <%=request.querystring("area") %>serviceclass
    private m_db
    private m_errors
    
    public property let db(p_db) set m_db = p_db end property
    public property let errors(p_errors) set m_errors = p_errors end property
<%
do while not tables.eof
    if arraycontains(request.querystring("models"), CStr(tables("Table_Name").value)) then
        if tables("table_name") <> "sysdiagrams" then
            table_name = lcase(tables("TABLE_NAME"))
            set foreignkeys = schemaservice.getforeignkeys(table_name, "PK")
            set primarykey = schemaservice.getprimarykey(table_name)
            primkey = lcase(primarykey("COLUMN_NAME"))
%>
    '#########################################
    '<%=ucase(table_name) %>
    '#########################################
    'find<%=pluralize(table_name) %>
    public function find<%=pluralize(table_name) %>()
        set find<%=pluralize(table_name) %> = m_db.entity("<%=table_name %>")<% if request.querystring("usejoins") = "1" then %><%=schemaservice.sqljoin(table_name, false) %><% end if %>.find(querystring)
    end function
    
    'count<%=pluralize(table_name) %>
    public function count<%=pluralize(table_name) %>()
        count<%=pluralize(table_name) %> = m_db.entity("<%=table_name %>")<% if request.querystring("usejoins") = "1" then %><%=schemaservice.sqljoin(table_name, false) %><% end if %>.filter(querystring).count(empty)
    end function

    'get<%=pluralize(table_name) %>
    public function get<%=pluralize(table_name) %>()
        set get<%=pluralize(table_name) %> = m_db.entity("<%=table_name %>")<% if request.querystring("usejoins") = "1" then %><%=schemaservice.sqljoin(table_name, false) %><% end if %>.query(empty)
    end function
    
    'get<%=table_name %>
    public function get<%=table_name %>(<%=primkey %>)
        set get<%=table_name %> = m_db.entity("<%=table_name %>")<% if request.querystring("usejoins") = "1" then %><%=schemaservice.sqljoin(table_name, false) %><% end if %>.query("<%=primkey %> = " & <%=primkey %>)
    end function
    
    'getnew<%=table_name %>
    public function getnew<%=table_name %>()
        set getnew<%=table_name %> = m_db.entity("<%=table_name %>").create
    end function

    'create<%=table_name %>
	public function create<%=table_name %>()
        antiforgerytokenhandler.validate
        set <%=table_name %> = m_db.entity("<%=table_name %>").create
        m_db.entity("<%=table_name %>").automap <%=table_name %>, form
        if m_errors.count = 0 then
            <%=table_name %>.update
        end if
	end function

    'cancreate<%=table_name %>
	public function cancreate<%=table_name %>()
        cancreate<%=table_name %> = true
	end function

    'edit<%=table_name %>
	public function edit<%=table_name %>()
        antiforgerytokenhandler.validate
        set <%=table_name %> = m_db.entity("<%=table_name %>").query("<%=primkey %> = " & form("<%=primkey %>"))
        m_db.entity("<%=table_name %>").automap <%=table_name %>, form
        if m_errors.count = 0 then
            <%=table_name %>.update
        end if
	end function

    'canedit<%=table_name %>
	public function canedit<%=table_name %>(<%=primkey %>)
        canedit<%=table_name %> = true
	end function

    'delete<%=table_name %>
	public function delete<%=table_name %>()
        m_db.entity("<%=LCase(table_name) %>").delete("<%=primkey %> = " & request("<%=primkey %>"))
	end function

    'candelete<%=table_name %>
	public function candelete<%=table_name %>(<%=primkey %>)
        set candelete<%=table_name %> = true
	end function
    <% do while not foreignkeys.eof %>
    'get<%=pluralize(foreignkeys("FK_TABLE_NAME")) %>by<%=table_name %>
    public function get<%=pluralize(foreignkeys("FK_TABLE_NAME")) %>by<%=table_name %>(<%=primkey %>)
        set get<%=pluralize(foreignkeys("FK_TABLE_NAME")) %>by<%=table_name %> = m_db.entity("<%=foreignkeys("FK_TABLE_NAME") %>")<% if request.QueryString("usejoins") = "1" then %><%=schemaservice.sqljoin(foreignkeys("FK_TABLE_NAME"), false) %><% end if %>.query("<%=foreignkeys("FK_COLUMN_NAME") %> = " & <%=table_name %>("<%=lcase(primaryKey("column_name")) %>"))
    end function
    <% foreignkeys.movenext %><% loop %>
<%  end if
    end if
tables.moveNext
loop
%>
end class
%>