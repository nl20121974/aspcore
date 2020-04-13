<!--#include virtual="/startup.asp"-->
<%
view("title") = str("initpasswordtitre")
set utilisateur = db.entity("utilisateur").query("utilisateur_id = " & querystring("utilisateur_id"))
view("utilisateur_prenom") = utilisateur("utilisateur_prenom")
%>
<!--#include virtual="/areas/email/views/_shared/header.asp"-->
<table id="desiredinformation">
</table>
<table id="criticalinfo">
    <tbody>
        <tr>
            <td>
                <p>
                    <span><%=str("initpasswordtext") %> : </span>
                    <br />
                    <br />
                    <h2><%=querystring("utilisateur_motdepasse") %></h2>
                </p>
            </td>
        </tr>
    </tbody>
</table>
<!--#include virtual="/areas/email/views/_shared/footer.asp"-->