<!--#include virtual="/startup.asp"-->
<%
view("title") = str("confirmemailobjet")
set assistance = db.entity("assistance").query("assistance_id = " & querystring("assistance_id"))
set courriermodele = db.entity("courriermodele").query("courriermodele_id = " & querystring("courriermodele_id"))
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