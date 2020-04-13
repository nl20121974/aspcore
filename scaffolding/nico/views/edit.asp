<!--#include virtual="/startup.asp"-->
<%
set columns = schemaservice.getcolumns(scaffoldconfig("table_name"))
set primarykey = schemaservice.getprimarykey(scaffoldconfig("table_name"))
set foreignkeys = schemaservice.getforeignkeys(scaffoldconfig("table_name"), "FK")
%>
<%="<!--#include virtual=""" & scaffoldconfig.areapath & "/startup.asp""-->" %><%=vbcrlf %>
[
view("returnurl") = "details?<%=lcase(primarykey("column_name")) %>=" & querystring("<%=lcase(primarykey("column_name")) %>")
view("title") = str("edit") & str("<%=scaffoldconfig("table_name") %>")
set <%=scaffoldconfig("table_name") %> = <%=scaffoldconfig("area") %>service.get<%=scaffoldconfig("table_name") %>(querystring("<%=primarykey("column_name") %>"))
]
<%="<!--#include virtual=""/templates/header.asp""-->" %>
<form method="post">
    [=html.antiforgerytoken ]
    [=html.hidden("<%=lcase(primarykey("column_name")) %>").value(querystring("<%=lcase(primarykey("column_name")) %>")) ]
    [=html.hidden("servicemethod").value("<%=scaffoldconfig("area") %>service.edit<%=scaffoldconfig("table_name") %>") ]
    [=html.hidden("success").value("details?<%=lcase(primarykey("column_name")) %>=" & querystring("<%=lcase(primarykey("column_name")) %>")) ]<% do while not columns.eof %><% if lcase(primarykey("column_name")) <> lcase(columns("column_name")) then %>
    <p>
        [=html.label(str("<%=lcase(columns("column_name")) %>")) ]
        [=<%=schemaservice.writehtmlform(scaffoldconfig("table_name"), columns, scaffoldconfig("table_name")) %> ]
    </p><% end if %><% columns.movenext %><% loop %>
    [=html.submit("save") ]
</form>
<%="<!--#include virtual=""/templates/footer.asp""-->" %>
[ sub commandbar ]
[=html.commandbaritem("details?<%=lcase(primarykey("column_name")) %>=" & querystring("<%=lcase(primarykey("column_name")) %>")).content(str("details") & str("<%=scaffoldconfig("table_name") %>")) ]
[ end sub ]