<!--#include virtual="/startup.asp"-->
<%
set columns = schemaservice.getcolumns(scaffoldconfig("table_name"))
set primarykey = schemaservice.getprimarykey(scaffoldconfig("table_name"))
set foreignkeys = schemaservice.getforeignkeys(scaffoldconfig("table_name"), "FK")
%>
<%="<!--#include virtual=""" & scaffoldconfig.areapath & "/startup.asp""-->" %>
[
view("title") = str("<%=scaffoldconfig("table_name") %>/details")
set <%=scaffoldconfig("table_name") %> = <%=scaffoldconfig("area") %>service.get<%=scaffoldconfig("table_name") %>(querystring("<%=lcase(primarykey("column_name")) %>"))
]
<%="<!--#include virtual=""/templates/header.asp""-->" %>
<% do while not columns.eof %><% if lcase(primarykey("column_name")) <> lcase(columns("column_name")) then %>[=html.label(str("<%=lcase(columns("column_name")) %>")) & html.var(<%=schemaservice.writehtmlbody(scaffoldconfig("table_name"), columns, scaffoldconfig("table_name")) %>) ]</p><% if foreignkeys.RecordCount > 0 then foreignkeys.movefirst %><% end if %><% columns.movenext %><% loop %>
<% set columns = nothing %>
<% do while not foreignkeys.eof %>
[ if request.querystring("tab") = "pluralize(foreignkeys("FK_TABLE_NAME")) %>" then ]
[ set <%=pluralize(foreignkeys("FK_TABLE_NAME")) %> = db.entity("<%=foreignkeys("FK_TABLE_NAME") %>")<% if request.QueryString("usejoins") = "1" then %><%=schemaservice.sqljoin(foreignkeys("FK_TABLE_NAME"), false) %><% end if %>.where("<%=foreignkeys("FK_COLUMN_NAME") %> = " & <%=table_name %>("<%=lcase(primaryKey("column_name")) %>")).list ]
<% set columns = schemaservice.getcolumns(cstr(foreignkeys("FK_TABLE_NAME"))) %>
<table class="w3-table w3-bordered">
    <thead>
        <tr class="w3-light-gray"><% do while not columns.eof %><% if lcase(primarykey("column_name")) <> lcase(columns("column_name")) then %>
            <th>[=html.tableheader("<%=lcase(lcase(columns("column_name"))) %>").content(str("<%=lcase(lcase(columns("column_name"))) %>")) ]</th><% end if %><% columns.movenext %><% loop %><% if columns.recordcount > 0 then columns.movefirst %>
            <th></th>
        </tr>
    </thead>
    <tbody>
        [ do while not <%=pluralize(foreignkeys("FK_TABLE_NAME")) %>.eof ]
        <tr onclick="location.href='details?<%=lcase(primarykey("column_name")) %>=[=<%=pluralize(foreignkeys("FK_TABLE_NAME")) %>("<%=lcase(primarykey("column_name")) %>") ]'">
            <% do while not columns.eof %><% if lcase(primarykey("column_name")) <> lcase(columns("column_name")) then %>
            <td>[=<%=schemaservice.writehtmlbody(foreignkeys("FK_TABLE_NAME"), columns, pluralize(foreignkeys("FK_TABLE_NAME"))) %> ]</td>
            <% end if %><% columns.movenext %><% loop %>
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
[=html.commandbaritem("edit?<%=lcase(primarykey("column_name")) %>=" & querystring("<%=lcase(primarykey("column_name")) %>")).content(str("edit") & str("<%=scaffoldconfig("table_name") %>")).css("w3-bar-item w3-hover-text-gray") ]
[=html.commandbaritem("delete?<%=lcase(primarykey("column_name")) %>=" & querystring("<%=lcase(primarykey("column_name")) %>")).content(str("delete") & str("<%=scaffoldconfig("table_name") %>_delete")).css("w3-bar-item w3-hover-text-gray") ]
[=html.commandbaritem("index?<%=lcase(primarykey("column_name")) %>=" & querystring("<%=lcase(primarykey("column_name")) %>")).content(str("<%=pluralize(scaffoldconfig("table_name")) %>")).css("w3-bar-item w3-hover-text-gray") ]
<% do while not foreignkeys.eof %>
[=html.commandbaritem("?<%=lcase(primarykey("column_name")) %>=" & querystring("<%=lcase(primarykey("column_name")) %>") & "&tab=<%=pluralize(foreignkeys("FK_TABLE_NAME")) %>").content(str("<%=pluralize(foreignkeys("FK_TABLE_NAME")) %>")).css("w3-bar-item w3-hover-text-gray") ]
<% foreignkeys.movenext %><% loop %>
[ end sub ]