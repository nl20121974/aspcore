<%=html.commandbaritem(view("returnurl")).content("Obtenir de l'aide") %>
<% if config("current")("profile")("key") = "dev" or true then %>
<% if request.cookies("mode") <> "debug" then %>
<%=html.commandbaritem("?mode=debug&" & request.QueryString).content("Mode debug") %>
<% else %>
<%=html.commandbaritem("?mode=normal&" & request.QueryString).content("Mode normal") %>
<% end if %>
<% end if %>