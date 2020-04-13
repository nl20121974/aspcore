<!--#include virtual="/startup.asp"-->
<%
set columns = schemaservice.getcolumns(scaffoldconfig("table_name"))
set primarykey = schemaservice.getprimarykey(scaffoldconfig("table_name"))
%>
<%="<!--#include virtual=""" & scaffoldconfig.areapath & "/startup.asp""-->" %>
<%="<!--#include virtual=""" & scaffoldconfig.areapath & "/views/security.asp""-->" %><%=vbcrlf %>
[
view("returnurl") = "index"
view("title") = str("<%=scaffoldconfig("table_name") %>")
set <%=scaffoldconfig("table_name") %> = <%=scaffoldconfig("area") %>service.get<%=scaffoldconfig("table_name") %>(querystring("<%=lcase(primarykey("column_name")) %>"))
view("tab") = str("<%=scaffoldconfig("table_name") %>")
]
<%="<!--#include virtual=""/templates/header.asp""-->" %>
[ if request.querystring("tab") = "" then ]
<div class="w3-row">
    <div class="w3-col m6 w3-padding">
        <div class="w3-padding w3-white w3-padding-large">
        <h4>Titre encart</h4>
        <table><% do while not columns.eof %><% if lcase(primarykey("column_name")) <> lcase(columns("column_name")) then %>
            <tr>
                <td>[=html.label(str("<%=lcase(columns("column_name")) %>")) ]</td>
                <td>[=html.var(<%=schemaservice.writehtmlbody(scaffoldconfig("table_name"), columns, scaffoldconfig("table_name")) %>) ]</td>
            </tr><% end if %><% columns.movenext %><% loop %>
        </table>
        </div>
    </div>
</div>
[ end if ]<% set foreignkeys = schemaservice.getforeignkeys(scaffoldconfig("table_name"), "PK") %><%=vbcrlf %>
<% do while not foreignkeys.eof %>[ if request.querystring("tab") = "<%=pluralize(foreignkeys("FK_TABLE_NAME")) %>" then ]
[ set <%=pluralize(foreignkeys("FK_TABLE_NAME")) %> = <%=scaffoldconfig("area") %>service.get<%=pluralize(foreignkeys("FK_TABLE_NAME")) %>by<%=scaffoldconfig("table_name") %>(querystring("<%=lcase(primarykey("column_name")) %>")) ]
<% set columns = schemaservice.getcolumns(cstr(foreignkeys("FK_TABLE_NAME"))) %><table class="w3-table w3-bordered">
    <thead>
        <tr class="w3-light-gray"><% do while not columns.eof %><% if lcase(primarykey("column_name")) <> lcase(columns("column_name")) then %>
            <th>[=html.tableheader("<%=lcase(lcase(columns("column_name"))) %>").content(str("<%=lcase(lcase(columns("column_name"))) %>")) ]</th><% end if %><% columns.movenext %><% loop %><% if columns.recordcount > 0 then columns.movefirst %>
            <th></th>
        </tr>
    </thead>
    <tbody>
        [ do while not <%=pluralize(foreignkeys("FK_TABLE_NAME")) %>.eof ]
        <tr onclick="location.href='details?<%=lcase(primarykey("column_name")) %>=[=<%=pluralize(foreignkeys("FK_TABLE_NAME")) %>("<%=lcase(primarykey("column_name")) %>") ]'"><% do while not columns.eof %><% if lcase(primarykey("column_name")) <> lcase(columns("column_name")) then %>
            <td>[=<%=schemaservice.writehtmlbody(foreignkeys("FK_TABLE_NAME"), columns, pluralize(foreignkeys("FK_TABLE_NAME"))) %> ]</td><% end if %><% columns.movenext %><% loop %><% if columns.recordcount > 0 then columns.movefirst %>
            <td></td>
        </tr>
        [ <%=pluralize(foreignkeys("FK_TABLE_NAME")) %>.movenext ]
        [ loop ]
    </tbody>
</table>
[ end if ]
<% foreignkeys.movenext %>
<% loop %><% if foreignkeys.recordcount > 0 then foreignkeys.movefirst %>
<%="<!--#include virtual=""/templates/footer.asp""-->" %>
[ sub commandbar ]
[=html.commandbaritem("edit?<%=lcase(primarykey("column_name")) %>=" & querystring("<%=lcase(primarykey("column_name")) %>")).content(str("edit") & str("<%=scaffoldconfig("table_name") %>")) ]
[=html.commandbaritem("delete?<%=lcase(primarykey("column_name")) %>=" & querystring("<%=lcase(primarykey("column_name")) %>")).content(str("delete") & str("<%=scaffoldconfig("table_name") %>_delete")) ]
[=html.commandbaritem("index?<%=lcase(primarykey("column_name")) %>=" & querystring("<%=lcase(primarykey("column_name")) %>")).content(str("<%=pluralize(scaffoldconfig("table_name")) %>")) ]<% do while not foreignkeys.eof %>
[=html.commandbaritem("?<%=lcase(primarykey("column_name")) %>=" & querystring("<%=lcase(primarykey("column_name")) %>") & "&tab=<%=pluralize(foreignkeys("FK_TABLE_NAME")) %>").content(str("<%=pluralize(foreignkeys("FK_TABLE_NAME")) %>")) ]<% foreignkeys.movenext %><% loop %>
[ end sub ]