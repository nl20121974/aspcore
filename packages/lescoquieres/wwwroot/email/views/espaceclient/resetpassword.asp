<!--#include virtual="/startup.asp"-->
<%
view("title") = str("reinitialisationmdp")
set utilisateur = db.entity("utilisateur").query("utilisateur_id = " & querystring("utilisateur_id"))
view("utilisateur_id") = praticien("utilisateur_id")
%>
<!--#include virtual="/areas/email/views/_shared/header.asp"-->
<table id="desiredinformation">
</table>
<table id="criticalinfo">
    <tbody>
        <tr>
            <td>
                <p>
                    <span><%=str("votrenouveaumdp") %> : </span>
                    <br />
                    <br />
                    <h2><%=querystring("utilisateur__motdepasse") %></h2>
                </p>
            </td>
        </tr>
    </tbody>
</table>
<!--#include virtual="/areas/email/views/_shared/footer.asp"-->
