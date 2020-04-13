<!--#include virtual="/startup.asp"-->
<%
if request.form("save") <> "" then
    set filesystemobject = server.createobject("scripting.filesystemobject")
    if not filesystemobject.folderexists(session("projectpath") & "\areas\" & request.form("zone")) then
        filesystemobject.createfolder session("projectpath") & "\areas\" & lcase(request.form("zone"))
        response.redirect "/home/zone"
    end if
end if
%>
<!--#include virtual="/views/shared/header.asp"-->
<div class="w3-row">
    <div class="w3-col m3">
        <div class="w3-container">
            <form method="post">
                <p>
                    <label>Nom de la zone</label>
                    <input type="text" name="zone" required="required" class="w3-input w3-border" value="<%=request.form("zone") %>" />
                </p>
                <p>
                    <input type="submit" name="save" value="Ajouter la zone" class="w3-btn w3-primary" />
                </p>
            </form>
        </div>
    </div>
</div>
<!--#include virtual="/views/shared/footer.asp"-->