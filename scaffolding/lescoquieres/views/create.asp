<!--#include virtual="/startup.asp"-->
<%
set columns = schemaservice.getcolumns(scaffoldconfig("table_name"))
set primarykey = schemaservice.getprimarykey(scaffoldconfig("table_name"))
set foreignkeys = schemaservice.getforeignkeys(scaffoldconfig("table_name"), "FK")
%>
<%="<!--#include virtual=""" & scaffoldconfig.areapath & "/startup.asp""-->" %><%=vbcrlf %>
<%="<!--#include virtual=""" & scaffoldconfig.areapath & "/views/security.asp""-->" %><%=vbcrlf %>
[
view("returnurl") = "index"
view("title") = str("create") & str("<%=scaffoldconfig("table_name") %>")
set <%=scaffoldconfig("table_name") %> = <%=scaffoldconfig("area") %>service.getnew<%=scaffoldconfig("table_name") %>()
]
<%="<!--#include virtual=""/templates/header.asp""-->" %>
<div class="w3-row">
    <div class="w3-col m6 w3-padding">
        <div class="w3-padding w3-white w3-padding-large">
            <h4>Titre encart</h4>
                <form method="post">
                    [=html.antiforgerytoken ]
                    [=html.hidden("servicemethod").value("<%=scaffoldconfig("area") %>service.create<%=scaffoldconfig("table_name") %>") ]
                    [=html.hidden("success").value("index") ]
                    <table><% do while not columns.eof %><% if lcase(primarykey("column_name")) <> lcase(columns("column_name")) then %>
                        <tr>
                            <td>[=html.label(str("<%=lcase(columns("column_name")) %>")) ]<% if not columns("Is_Nullable") then %>[=html.star ]<% end if %></td>
                            <td>[=<%=schemaservice.writehtmlform(scaffoldconfig("table_name"), columns, scaffoldconfig("table_name")) %> ]</td>
                        </tr><% end if %><% columns.movenext %><% loop %>
                    </table>
                    <p>[=html.submit("save") ]</p>
                </form>
        </div>
    </div>
</div>
<%="<!--#include virtual=""/templates/footer.asp""-->" %>
[ sub commandbar ]
[=html.commandbaritem("index") ]
[ end sub ]