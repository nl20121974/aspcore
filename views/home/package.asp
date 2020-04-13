<!--#include virtual="/startup.asp"-->
<%
if session("projectpath") = "" then response.redirect "/home/index"
if request.form("importpackage") <> "" then
    set filesystemobject = server.createobject("scripting.filesystemobject")
    set folder = filesystemobject.getfolder(server.mappath("/packages/" & scaffoldconfig("style")))
    for each folder in folder.subfolders
        if not filesystemobject.folderexists(session("projectpath") & "\" & folder.name) then
            filesystemobject.copyfolder folder.path, session("projectpath") & "\" & folder.name
        end if
    next
    set folder = filesystemobject.getfolder(server.mappath("/packages/" & scaffoldconfig("style")))
    for each file in folder.files
        if not filesystemobject.fileexists(session("projectpath") & "\" & file.name) then
            filesystemobject.copyfile file.path, session("projectpath") & "\" & file.name
            if file.name = "config.asp" then
                set file = filesystemobject.opentextfile(session("projectpath") & "\config.asp", 1)
                content = file.readall
                file.close
                projectpath = split(session("projectpath"), "\")
                content = replace(content, "{domain}", projectpath(ubound(projectpath)))
                content = replace(content, "{connectionstring}", scaffoldconfig.connectionstring)
                set file = filesystemobject.opentextfile(session("projectpath") & "\config.asp", 2)
                file.writeline(content)
                file.close
            end if
        end if
    next
elseif request.form("supprimerfichiersexistants") <> "" then
    set filesystemobject = server.createobject("scripting.filesystemobject")
    set folder = filesystemobject.getfolder(server.mappath("/packages/" & scaffoldconfig("style")))
    for each folder in folder.subfolders
        if filesystemobject.folderexists(session("projectpath") & "\" & folder.name) then
            filesystemobject.deletefolder session("projectpath") & "\" & folder.name
        end if
    next
    set folder = filesystemobject.getfolder(server.mappath("/packages/" & scaffoldconfig("style")))
    for each file in folder.files
        if filesystemobject.fileexists(session("projectpath") & "\" & file.name) then
            filesystemobject.deletefile session("projectpath") & "\" & file.name
        end if
    next
end if
%>
<!--#include virtual="/views/shared/header.asp"-->
<div class="w3-row">
    <div class="w3-col m12">
        <div class="w3-container">
            <p> 
                <% set filesystemobject = server.createobject("scripting.filesystemobject") %>
                <% set folder = filesystemobject.getfolder(server.mappath("/packages/" & scaffoldconfig("style"))) %>
                <table class="w3-table w3-bordered w3-hoverable w3-cursor">
                    <tr><th>Package <span style="text-transform: uppercase"><%=session("style") %></span></th></tr>
                    <% for each folder in folder.subfolders %>
                    <tr>
                        <td><i class="fa fa-folder w3-margin-right w3-text-amber"></i><%=folder.name %></td>
                    </tr>
                    <% next %>
                    <% set folder = filesystemobject.getfolder(server.mappath("/packages/" & scaffoldconfig("style"))) %>
                    <% for each file in folder.files %>
                    <tr>
                        <td><i class="fas fa-file w3-margin-right w3-text-purple"></i><%=file.name %></td>
                    </tr>
                    <% next %>
                </table>
            </p>
            <form method="post">
                <p>
                    <input type="submit" name="importpackage" value="Importer le package" class="w3-btn w3-primary w3-margin-right" /><input type="submit" name="supprimerfichiersexistants" value="Supprimer les fichiers existants" class="w3-btn w3-primary" />
                </p>
            </form>
        </div>
    </div>
</div>
<!--#include virtual="/views/shared/footer.asp"-->