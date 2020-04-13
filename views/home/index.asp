<!--#include virtual="/startup.asp"-->
<%
if request.form("projectpath") <> "" then
    session("projectpath") = request.form("projectpath")
    session("usejoins") = request.form("usejoins")
    session("style") = request.form("style")
    response.redirect "/home/package"
end if
%>
<!--#include virtual="/views/shared/header.asp"-->
<div class="w3-row">
    <div class="w3-col m3">
        <div class="w3-container">
            <form method="post">
                <p>
                    <label>Repertoire de travail</label>
                    <input type="text" name="projectpath" required="required" class="w3-input w3-border" value="<% if request.form("projectpath") <> "" then %><%=request.form("projectpath") %><% else %><%=session("projectpath") %><% end if %>" />
                </p>
                <p>
                    <label>Utiliser les jointures</label>
                    <input type="checkbox" name="usejoins" value="1" checked="false" required="required" value="<% if request.form("usejoins") <> "" then %><%=request.form("usejoins") %><% else %><%=session("usejoins") %><% end if %>" class="w3-check" />
                </p>
                <p>
                    <label>Présentation</label>
                    <% set filesystemobject = server.createobject("scripting.filesystemobject") %>
                    <% set folder = filesystemobject.getfolder(server.mappath("/scaffolding")) %>
                    <select name="style" class="w3-input w3-border">
                        <% for each subfolder in folder.subfolders %>
                        <option value="<%=subfolder.name %>" <% if request.form("style") = subfolder.name then %>selected<% elseif session("usejoins") = subfolder.name then %>selected<% end if %>"><%=subfolder.name %></option>
                        <% next %>
                    </select>
                </p>
                <p>
                    <input type="submit" name="save" value="Me connecter" class="w3-btn w3-primary" />
                </p>
            </form>
        </div>
    </div>
</div>
<!--#include virtual="/views/shared/footer.asp"-->