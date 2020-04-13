<!--#include virtual="/startup.asp"-->
<%
view("title") = str("confirmemailobjet")
set utilisateur = db.entity("utilisateur").query("utilisateur_id = " & querystring("utilisateur_id"))
%>
<!--#include virtual="/areas/email/views/_shared/header.asp"-->
<table id="desiredinformation">
</table>
<table id="criticalinfo">
    <tbody>
        <tr>
            <td>
                <p>
                    <span><%=str("confirmationcode") %> : </span>
                    <br />
                    <br />
                    <h2><%=utilisateur("utilisateur_confirmcode") %></h2>
                </p>
            </td>
        </tr>
    </tbody>
</table>
<!--#include virtual="/areas/email/views/_shared/footer.asp"-->