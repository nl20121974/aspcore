<hr>
<%=html.commandbaritem("/account/preferences").content("Mes préférences") %>
<%=html.commandbaritem("/support").content("Contacter le support") %>
<%=html.commandbaritem("/account/logout").content("Se déconnecter") %>
<% if config("current")("profile")("key") <> "prod" or true then %>
<% if request.cookies("mode") <> "debug" then %>
<%=html.commandbaritem("?mode=debug&" & request.querystring).content("Mode debug") %>
<% else %>
<%=html.commandbaritem("?mode=normal&" & request.querystring).content("Mode normal") %>
<% end if %>
<% end if %>