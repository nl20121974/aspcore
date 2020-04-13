<!--#include virtual="/areas/erp/startup.asp"-->
<!--#include virtual="/areas/erp/views/security.asp"-->
<%
set utilisateur = accountservice.getidentity
view("title") = utilisateur("utilisateur_prenom") & " " & utilisateur("utilisateur_nom")
view("returnurl") = "/account/support"

if request.ServerVariables("request_method") = "POST" then
	set support = db.entity("support").create
	support("support_creation") = Now
	support("support_modification") = Now
	support("support_date") = Now
	support("support_auteur") = request.cookies("utilisateur_id")
	support("support_objet") = form("support_objet")
	support("support_message") = form("support_message")
	support.update
	close support
    set mailclient = mailservice.creermailclient(request.Cookies("utilisateur_id"))
    set mailmessage = mailservice.creermessage(form("support_objet"), form("support_message"))
    with mailmessage
	    .recipients.add config("support_email")
    end with
    set errors = mailclient.send(mailmessage)
    close mailmessage
    close mailclient
    if errors.count = 0 then
        redirect "/home/accueil"
    else
        messages.Add "mailmessage", "invalid"
    end if
end if
%>
<!--#include virtual="/templates/header.asp"-->
<% if not isempty(form("support")) then %>
<div class="w3-row">
    <div class="w3-col m6 w3-padding">
        <div class="w3-padding w3-white w3-padding-large">
            <%=html.h4(str("contacterlesupport")) %>
                <br />
                <br />
                <label>
                    Votre message est tranmis au support.<br />
                    Il sera pris en charge très rapidement.</label>
            </div>
    </div>
</div>
<% else %>
<div class="w3-row">
    <div class="w3-col m6 w3-padding">
        <div class="w3-padding w3-white w3-padding-large">
            <%=html.h4(str("contacterlesupport")) %>
                <form method="post">
                    <%=html.antiforgerytoken %>
                    <%=html.text("support_objet").label("Objet").required().p %>
                    <div class="ckedition"><%=html.textarea("support_message").label("Message").height(400).css("w3-editor-void").p %></div>
                    <p><%=html.submit("save") %></p>
                </form>
            </div>
    </div>
</div>
<% end if %>
<!--#include virtual="/templates/footer.asp"-->
