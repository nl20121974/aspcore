<!--#include virtual="/areas/erp/startup.asp"-->
<!--#include virtual="/areas/erp/views/security.asp"-->
<% 
view("return_url") = "/account/preferences"
set utilisateur = accountservice.getidentity
view("title") = utilisateur("utilisateur_prenom") & " " & utilisateur("utilisateur_nom")
view("returnurl") = "/account/motdepasse?utilisateur_id=" & cookies("utilisateur_id")
if request.servervariables("request_method") = "POST" then
	if not accountservice.modifiermotdepasse(utilisateur("utilisateur_id"), form("utilisateur_motdepasse"), form("utilisateur_motdepasse_confirmation")) then
        messages.add "erreur", "ok"
    end if
end if
%>
<!--#include virtual="/templates/header.asp"-->
<div class="w3-row">
    <div class="w3-col m6 w3-padding">
        <div class="w3-padding w3-white w3-padding-large">
            <%=html.h4(str("Changermotdepasse")) %>
            <% if request.ServerVariables("request_method") = "POST" then %>
                <br />
                <% if messages.count > 0 then %>
                <p class="w3-padding w3-red w3-text-white"><%=str("erreurmdp") %></p>
                <% else %>
                <p class="w3-padding w3-light-gray"><%=str("changementmdpok") %></p>
                <% changementdumotdepasse="ok" %>
                <% end if %>
            <% end if %>
            <% if changementdumotdepasse<>"ok" then %>
            <form method="post">
                <%=html.antiforgerytoken %>
                <p><%=html.label(str("utilisateur_motdepasse")) & html.password("utilisateur_motdepasse").required.p %></p>
                <p><%=html.label(str("utilisateur_motdepasse_confirmation")) & html.password("utilisateur_motdepasse_confirmation").required.p %></p>
                <p><%=html.submit("save") %></p>
            </form>
            <% end if %>
         </div>
    </div>
</div>
<!--#include virtual="/templates/footer.asp"-->
<% sub commandbar %>
<%=html.commandbaritem("preferences").content(str("mespreferences")) %>
<% end sub %>
