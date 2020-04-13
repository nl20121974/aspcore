<!--#include virtual="/startup.asp"-->
<%
if servervariables("request_method") = "POST" then
    if accountservice.login(form("utilisateur_login"), form("utilisateur_password")) then
        redirect config("home_page")
    else
        messages.add "utilisateur_login", "invalid"
    end if
end if
%>
<!--#include virtual="/templates/header.asp"-->
<div class="w3-row" style="margin-top: 150px">
    <div class="w3-col m4">&nbsp;</div>
    <div class="w3-col m4">
        <div class="w3-card-4 w3-white">
            <div class="w3-container">
                <% if messages("utilisateur_login") = "invalid" then %>
                <% if errors("utilisateur_protectionip") = "invalid" then %>
                <p class="w3-text-red"><%=str("login_error_ip") %></p>
                <% else %>
                <p class="w3-text-red"><%=str("login_error_credentials") %></p>
                <% end if %>
                <% end if %>
                <form method="post">
                    <p><%=html.label(str("utilisateur_login")) & html.text("utilisateur_login") %></p>
                    <p><%=html.label(str("utilisateur_password")) & html.password("utilisateur_password") %></p>
                    <%=html.submit("save").value("Valider").p %>
                </form>
            </div>
        </div>
    </div>
    <div class="w3-col m4">&nbsp;</div>
</div>
<!--#include virtual="/templates/footer.asp"-->
