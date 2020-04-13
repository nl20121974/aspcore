<!--#include virtual="/startup.asp"-->
<%
set columns = schemaservice.getcolumns(scaffoldconfig("table_name"))
set primarykey = schemaservice.getprimarykey(scaffoldconfig("table_name"))
set foreignkeys = schemaservice.getforeignkeys(scaffoldconfig("table_name"), "FK")
%>
<%="<!--#include virtual=""" & scaffoldconfig.areapath & "/startup.asp""-->" %>
[ view("title") = str("<%=pluralize(scaffoldconfig("table_name")) %>") ]
<%="<!--#include virtual=""/templates/header.asp""-->" %>
[ if isempty(querystring("order")) then querystring("order") = "<%=primarykey("column_name") %>2" ]
[ set <%=pluralize(scaffoldconfig("table_name")) %> = <%=scaffoldconfig("area") %>service.find<%=pluralize(scaffoldconfig("table_name")) %> ]
[ httphelper.mapcookiestoquerystring("<%=scaffoldconfig("area") %>/<%=scaffoldconfig("table_name") %>") ]
<div class="w3-row">
    <div class="w3-bar">
        [=html.btn("create").content(str("create")) ]
    </div>
</div>
<form method="get">
    <table class="w3-table-all w3-hoverable w3-margin-top">
        <thead>
            <tr><% do while not columns.eof %><%' if lcase(primarykey("column_name")) <> lcase(columns("column_name")) then %>
                <th>[=html.tableheader("<%=lcase(lcase(columns("column_name"))) %>").content(str("<%=lcase(lcase(columns("column_name"))) %>")) ]</th><%' end if %><% columns.movenext %><% loop %>
                <th></th>
            </tr>
        </thead>
        <tr><%=columns.movefirst %>
            <% do while not columns.eof %><%' if lcase(primarykey("column_name")) <> lcase(columns("column_name")) then %>
            <th>[=<%=schemaservice.writehtmlform(scaffoldconfig("table_name"), columns, "querystring") %> ]</th><%' end if %><% columns.movenext %><% loop %>
            <th>
                [=html.hidden("order").value(querystring("order")) ]
                [=html.submit("search").value(str("ok")) ]
            </th>
        </tr>
        <tbody><% columns.movefirst %>
            [ do while not <%=pluralize(scaffoldconfig("table_name")) %>.eof ]
            <tr onclick="location.href='details?<%=lcase(primarykey("column_name")) %>=[=<%=pluralize(scaffoldconfig("table_name")) %>("<%=lcase(primarykey("column_name")) %>") ]'"><% do while not columns.eof %><%' if lcase(primarykey("column_name")) <> lcase(columns("column_name")) then %>
                <td>[=<%=schemaservice.writehtmlbody(scaffoldconfig("table_name"), columns, pluralize(scaffoldconfig("table_name"))) %> ]</td><% if foreignkeys.RecordCount > 0 then foreignkeys.movefirst %><%' end if %><% columns.movenext %><% loop %>
                <td></td>
            </tr>
            [ <%=pluralize(scaffoldconfig("table_name")) %>.movenext ]
            [ loop ]
        </tbody>
    </table>
    [=html.tablefooter(<%=scaffoldconfig("area") %>service.count<%=pluralize(scaffoldconfig("table_name")) %>) ]
</form>
<%="<!--#include virtual=""/templates/footer.asp""-->" %>
[ sub commandbar ]
[ end sub ]