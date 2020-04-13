<!--#include virtual="/startup.asp"-->
<!--#include virtual="/views/security.asp"-->
<% 
view("return_url") = "/account/preferences?utilisateur_id=" & utilisateur("utilisateur_id")
view("title") = str("modifiermdp")
set utilisateur = db.entity("utilisateur").query("utilisateur_id = " & querystring("utilisateur_id"))
if request.servervariables("request_method") = "POST" then
	if not accountservice.modifiermotdepasse(utilisateur("utilisateur_id"), form("utilisateur_motdepasse"), form("utilisateur_motdepasse_confirmation")) then
        messages.add "erreur", "ok"
    end if
end if
%>
<!--#include virtual="/views/home/templates/header.asp"-->
<div class="w3-row">
    <div class="w3-col m-4">
        <% if request.ServerVariables("request_method") = "POST" then %>
        <br />
        <% if messages.count > 0 then %>
        <p class="w3-padding w3-red w3-text-white"><%=str("erreurmdp") %></p>
        <% else %>
        <p class="w3-padding w3-light-gray"><%=str("changementmdpok") %></p>
        <% end if %>
        <% end if %>
        <form method="post">
            <%=html.antiforgerytoken %>
            <p><%=html.label(str("utilisateur_motdepasse")) & html.password("utilisateur_motdepasse").required.p %></p>
            <p><%=html.label(str("utilisateur_motdepasse_confirmation")) & html.password("utilisateur_motdepasse_confirmation").required.p %></p>
            <p><%=html.submit("save") %></p>
        </form>
    </div>
</div>
<!--#include virtual="/views/home/templates/footer.asp"-->
<% sub commandbar %>
<% end sub %>
