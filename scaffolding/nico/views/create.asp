<!--#include virtual="/startup.asp"-->
<%
set columns = schemaservice.getcolumns(scaffoldconfig("table_name"))
set primarykey = schemaservice.getprimarykey(scaffoldconfig("table_name"))
set foreignkeys = schemaservice.getforeignkeys(scaffoldconfig("table_name"), "FK")
%>
<%="<!--#include virtual=""" & scaffoldconfig.areapath & "/startup.asp""-->" %><%=vbcrlf %>
[
view("returnurl") = "index"
view("title") = str("create") & str("<%=scaffoldconfig("table_name") %>")
set <%=scaffoldconfig("table_name") %> = <%=scaffoldconfig("area") %>service.getnew<%=scaffoldconfig("table_name") %>()
]
<%="<!--#include virtual=""/templates/header.asp""-->" %>
<form method="post">
    [=html.antiforgerytoken ]
    [=html.hidden("servicemethod").value("<%=scaffoldconfig("area") %>service.create<%=scaffoldconfig("table_name") %>") ]
    [=html.hidden("success").value("index") ]<% do while not columns.eof %><% if lcase(primarykey("column_name")) <> lcase(columns("column_name")) then %>
    <p>
        [=html.label(str("<%=lcase(columns("column_name")) %>")) ]
        [=<%=schemaservice.writehtmlform(scaffoldconfig("table_name"), columns, scaffoldconfig("table_name")) %> ]
    </p><% end if %><% columns.movenext %><% loop %>
    [=html.submit("save") ]
</form>
<%="<!--#include virtual=""/templates/footer.asp""-->" %>
[ sub commandbar ]
[=html.commandbaritem("index") ]
[ end sub ]