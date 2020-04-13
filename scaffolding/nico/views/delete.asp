<!--#include virtual="/startup.asp"-->
<%
set columns = schemaservice.getcolumns(scaffoldconfig("table_name"))
set primarykey = schemaservice.getprimarykey(scaffoldconfig("table_name"))
%>
<%="<!--#include virtual=""" & scaffoldconfig.areapath & "/startup.asp""-->" %>
[
view("returnurl") = "details?<%=lcase(primarykey("column_name")) %>=" & querystring("<%=lcase(primarykey("column_name")) %>")
view("title") = str("<%=scaffoldconfig("table_name") %>/details")
set <%=scaffoldconfig("table_name") %> = <%=scaffoldconfig("area") %>service.get<%=scaffoldconfig("table_name") %>(querystring("<%=lcase(primarykey("column_name")) %>"))
]
<%="<!--#include virtual=""/templates/header.asp""-->" %>
<% do while not columns.eof %><% if lcase(primarykey("column_name")) <> lcase(columns("column_name")) then %>
[=html.label(str("<%=lcase(columns("column_name")) %>")) & html.var(<%=schemaservice.writehtmlbody(scaffoldconfig("table_name"), columns, scaffoldconfig("table_name")) %>) ]</p><% end if %><% columns.movenext %><% loop %>
<form method="post">
    [=html.antiforgerytoken ]
    [=html.hidden("<%=lcase(primarykey("column_name")) %>").value(<%=scaffoldconfig("table_name") %>("<%=primarykey("column_name") %>")) ]
    [=html.hidden("service").value("<%=scaffoldconfig("area") %>service") ]
    [=html.hidden("method").value("delete<%=scaffoldconfig("table_name") %>") ]
    [=html.hidden("success").value("index") ]
    <p>[=str("doyouconfirmdelete") ]</p>
    [=html.submit("save").value(str("confirmdelete")) ][=html.anchor("details?<%=lcase(primarykey("column_name")) %>=" & querystring("<%=lcase(primarykey("column_name")) %>")).content(str("cancel")).css("w3-btn w3-theme") ]
</form>
<%="<!--#include virtual=""/templates/footer.asp""-->" %>
[ sub commandbar ]
[=html.commandbaritem("details?<%=lcase(primarykey("column_name")) %>=" & querystring("<%=lcase(primarykey("column_name")) %>")).content(str("details") & str("<%=scaffoldconfig("table_name") %>")) ]
[ end sub ]