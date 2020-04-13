<!--#include virtual="/startup.asp"-->
<%
set columns = schemaservice.getcolumns(scaffoldconfig("table_name"))
set primarykey = schemaservice.getprimarykey(scaffoldconfig("table_name"))
set foreignkeys = schemaservice.getforeignkeys(scaffoldconfig("table_name"), "FK")
%>
[ sub <%=scaffoldconfig("table_name") %>_editor(<%=scaffoldconfig("table_name") %>) ]
[ db.entity("<%=scaffoldconfig("table_name") %>").automap <%=scaffoldconfig("table_name") %>, form ]
<form method="post">
    [=html.antiforgerytoken ]<% do while not columns.eof %><% if lcase(primarykey("column_name")) <> lcase(columns("column_name")) then %>
    <p>
        [=html.hidden("service").value("<%=scaffoldconfig.area %>service") ]
        [=html.hidden("method").value("create") ]
        [=html.label(str("<%=lcase(columns("column_name")) %>")) ]
        [=<%=schemaservice.writehtmlform(scaffoldconfig("table_name"), columns, scaffoldconfig("table_name")) %> ]
    </p><% end if %><% columns.movenext %><% loop %>
    [=html.submit("save") ]
</form>
[ end sub ]