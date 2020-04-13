<!--#include virtual="/areas/erp/startup.asp"-->
<!--#include virtual="/areas/erp/views/security.asp"-->
<% 
set utilisateur = accountservice.getidentity
view("title") = utilisateur("utilisateur_prenom") & " " & utilisateur("utilisateur_nom")
view("returnurl") = "/account/motdepasse?utilisateur_id=" & cookies("utilisateur_id")
%>
<!--#include virtual="/templates/header.asp"-->
<div class="w3-row">
    <div class="w3-col m6 w3-padding">
        <div class="w3-padding w3-white w3-padding-large">
            <%=html.h4(str("mespreferences")) %>
            <form method="post">
                <%=html.antiforgerytoken %>
                <%=html.hidden("utilisateur_id").value("utilisateur_id") %>
                <%=html.hidden("servicemethod").value("accountservice.modifierpreferences") %>
                <%=html.hidden("success").value(config("home_page")) %>
                <%=html.hidden("method").value("modifierpreferences") %>
                <table>
                    <tr>
                        <td><%=html.label(str("utilisateur_nom")) %></td>
                        <td><%=html.text("utilisateur_nom").value(utilisateur("utilisateur_nom")).required %></td>
                    </tr>
                    <tr>
                        <td><%=html.label(str("utilisateur_prenom")) %></td>
                        <td><%=html.text("utilisateur_prenom").value(utilisateur("utilisateur_prenom")).required %></td>
                    </tr>
                    <tr>
                        <td><%=html.label(str("utilisateur_theme")) %></td>
                        <td>
                            <select name="utilisateur_theme" class="w3-input w3-border">
                                <% set themes = db.entity("theme").query(empty) %>
                                <% do while not themes.eof %>
                                <option value="<%=themes("theme_id") %>" style="background-color: #<%=split(themes("theme_fichier"), "_")(1) %>" <% if themes("theme_id") = utilisateur("utilisateur_theme") then %>selected<% end if %>><%=themes("theme_nom") %></option>
                                <% themes.movenext %>
                                <% loop %>
                            </select></td>
                    </tr>
                    <tr>
                        <td><%=html.label(str("utilisateur_pagesize")) %></td>
                        <td><%=html.number("utilisateur_pagesize").value(utilisateur("utilisateur_pagesize")).required%>
                        </td>
                    </tr>
                </table>
                <p>
                </p>
                <%=html.h4(str("serveurmail")) %>
                <p><%'=html.textarea("utilisateur_signature").label(str("utilisateur_signature")).content(utilisateur("utilisateur_signature")).css("w3-editor-light").height(200) %></p>
                <p><%=html.submit("save") %></p>

            </form>

        </div>
    </div>
</div>
<!--#include virtual="/templates/footer.asp"-->
<% sub commandbar %>
<%=html.commandbaritem("motdepasse").content(str("Changermotdepasse")) %>
<% end sub %>