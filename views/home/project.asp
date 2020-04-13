<!--#include virtual="/startup.asp"-->
<%
if session("projectpath") = "" then response.redirect "/home/index"
view("title") = "Scaffolding"
if request.servervariables("request_method") = "POST" then
    scaffolding_directory = session("projectpath") & "\areas\" & request.querystring("area")
    if request.form("views") = "1" then
        scaffoldingservice.createviews
    end if
    if request.form("resources") = "1" then
        scaffoldingservice.createresources
    end if
    if request.form("service") = "1" then
        scaffoldingservice.createservice
    end if
    if request.form("templates") = "1" then
        scaffoldingservice.createtemplates
    end if
    if request.form("sidebar") = "1" then
        scaffoldingservice.createsidebar
    end if
    if request.form("homepage") = "1" then
        scaffoldingservice.createhomepage
    end if
end if
views_path = session("projectpath") & "\areas\" & request.querystring("area") & "\views\"
root_path = "areas\" & request.querystring("area") & "\"
set tables = schemaservice.gettables(empty)
%>
<!--#include virtual="/views/shared/header.asp"-->
<div class="w3-row">
    <div class="w3-bar">
        <a onclick="$('#save').click()" class="w3-btn w3-primary">Valider</a>
    </div>
</div>
<div id="page" class="w3-row w3-padding">
    <form method="post">
        <div class="w3-col m3">
            <input type="submit" id="save" name="save" class="w3-hide" value="Valider" />
            <div class="w3-card-4">
                <header class="w3-container w3-primary w3-left-align">
                    <a href="?cmd=refresh&area=<%=request.querystring("area") %>"><i class="fa fa-sync w3-text-green"></i></a>
                </header>
                <table class="w3-table w3-bordered w3-hoverable w3-cursor">
                    <% do while not tables.eof %>
                    <% if tables("table_name") <> "sysdiagrams" then %>
                    <tr class="table_name <% if request.querystring("cmd") = "refresh" and files.folderexists(views_path & tables("table_name")) then %>active<% end if %>" id="<%=tables("table_name") %>">
                        <td>
                        <i class="fas fa-table w3-margin-right <% if files.folderexists(views_path & tables("table_name")) then %>w3-text-yellow<% else %>w3-text-white<% end if %>"></i><%=tables("table_name") %>
                            <i id="icon_<%=tables("table_name") %>" class="fas fa-check-circle w3-margin-left w3-text-green <% if arraycontains(request.form("models"), tables("table_name")) then %>active<% end if %>"></i>
                            <input type="checkbox" <% if request.querystring("cmd") = "refresh" and files.folderexists(views_path & tables("table_name")) then %>checked<% end if %> id="checkbox_<%=tables("table_name") %>" name="models" value="<%=tables("table_name") %>" class="w3-hide" />
                        </td>
                    </tr>
                    <% end if %>
                    <% tables.movenext %>
                    <% loop %>
                </table>
            </div>
        </div>
        <div class="w3-col m9">
            <div class="w3-card-4">
                <header class="w3-container w3-primary w3-left-align">
                    Setup
                </header>
                <table class="w3-table w3-hoverable w3-cursor">
                    <tr id="views" class="table_name <% if request.form("views") = "1" then %>active<% end if %>">
                        <td><span>Views</span>
                            <i id="icon_views" class="fas fa-check-circle w3-margin-left w3-text-green w3-hide"></i>
                            <input type="checkbox" id="checkbox_views" name="views" value="1" class="w3-hide" />
                        </td>
                    </tr>
                    <tr id="resources" class="table_name <% if request.form("resources") = "1" then %>active<% end if %>">
                        <td><span>Resources</span>
                            <i id="icon_resources" class="fas fa-check-circle w3-margin-left w3-text-green w3-hide"></i>
                            <input type="checkbox" id="checkbox_resources" name="resources" value="1" class="w3-hide" />
                        </td>
                    </tr>
                    <tr id="service" class="table_name <% if request.form("service") = "1" then %>active<% end if %>">
                        <td><span>Service</span>
                            <i id="icon_service" class="fas fa-check-circle w3-margin-left w3-text-green w3-hide"></i>
                            <input type="checkbox" id="checkbox_service" name="service" value="1" class="w3-hide" />
                        </td>
                    </tr>
                    <tr id="sidebar" class="table_name <% if request.form("sidebar") = "1" then %>active<% end if %>">
                        <td><span>Sidebar</span>
                            <i id="icon_sidebar" class="fas fa-check-circle w3-margin-left w3-text-green w3-hide"></i>
                            <input type="checkbox" id="checkbox_sidebar" name="sidebar" value="1" class="w3-hide" />
                        </td>
                    </tr>
                    <% if false then %>
                    <tr id="templates" class="table_name <% if request.form("templates") = "1" then %>active<% end if %>">
                        <td><span>Templates</span>
                            <i id="icon_templates" class="fas fa-check-circle w3-margin-left w3-text-green w3-hide"></i>
                            <input type="checkbox" id="checkbox_templates" name="templates" value="1" class="w3-hide" />
                        </td>
                    </tr>
                    <% end if %>
                </table>
            </div>
            <% if scaffoldingservice.logs.count > 0 then %>
            <br />
            <div class="w3-card-4">
                <div class="w3-container">
                    <p>
                        <% for each k in scaffoldingservice.logs %>
                        <var><%=lcase(k) %></var><br />
                        <% next %>
                    </p>
                </div>
            </div>
            <% end if %>
        </div>
    </form>
</div>
<!--#include virtual="/views/shared/footer.asp"-->
<script type="text/javascript">
    $(document).ready(function () {
        $('.table_name').each(function () {
            $(this).click(function () {
                table_name = $(this).attr('id');
                $('#checkbox_' + table_name).attr('checked', !$('#checkbox_' + table_name).is(':checked'));
                $(this).toggleClass('active');
            });
        });
    });
</script>
