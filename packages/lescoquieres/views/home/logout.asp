<!--#include virtual="/startup.asp"-->
<%
for each k in cookies
    if k <> "client" then
        response.cookies(k).expires = dateadd("d", -1, date)
    end if
next
redirect config("login_page")
%>
