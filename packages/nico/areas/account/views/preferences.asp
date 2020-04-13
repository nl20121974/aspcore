<!--#include virtual="/startup.asp"-->
<!--#include virtual="/views/security.asp"-->
<% 
view("title") = str("preferences")
view("returnurl") = "/account/motdepasse?utilisateur_id=" & cookies("utilisateur_id")
set utilisateur = accountservice.getidentity
%>
<!--#include virtual="/views/home/templates/header.asp"-->
<div class="w3-row">
    <div class="w3-col m3">
        <%=html.h4(str("profile")) %>
        <form method="post">
            <%=html.antiforgerytoken %>
            <%=html.hidden("service").value("accountservice") %>
            <%=html.hidden("method").value("modifierpreferences") %>
            <%=html.hidden("success").value(config("home_page")) %>
            <% with locale("utilisateur") %>
            <%=html.text("utilisateur_nom").label(.item("utilisateur_nom")).value(utilisateur("utilisateur_nom")).required.p %>
            <%=html.text("utilisateur_prenom").label(.item("utilisateur_prenom")).value(utilisateur("utilisateur_prenom")).required.p %>
            <% if utilisateur("societe_id") = 1 or utilisateur("utilisateur_societes") then %>
            <p>
                <%=html.label(str("utilisateur_theme")) %>
                <select name="utilisateur_theme" class="w3-input w3-border">
                    <% set themes = db.entity("theme").query(empty) %>
                    <% do while not themes.eof %>
                    <option value="<%=themes("theme_id") %>" style="background-color: #<%=split(themes("theme_fichier"), "_")(1) %>" <% if themes("theme_id") = utilisateur("theme_id") then %>selected<% end if %>><%=themes("theme_nom") %></option>
                    <% themes.movenext %>
                    <% loop %>
                </select>
            </p>
            <% end if %>
            <%=html.number("utilisateur_pagesize").label(.item("utilisateur_pagesize")).value(utilisateur("utilisateur_pagesize")).required.p %>
            <% end with %>
            <%=html.submit("save") %>
        </form>
        <%=html.h4(str("serveurmail")) %>
        <form method="post">
            <%=html.antiforgerytoken %>
            <% with locale("utilisateur") %>
            <p><%=html.textarea("utilisateur_signature").label(.item("utilisateur_signature")).value(utilisateur("utilisateur_signature")).css("w3-editor-light").height(200) %></p>
            <% end with %>
            <%=html.submit("save").hide %>
        </form>
    </div>
</div>
<!--#include virtual="/views/home/templates/footer.asp"-->