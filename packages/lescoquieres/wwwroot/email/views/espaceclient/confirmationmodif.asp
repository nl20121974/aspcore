<!--#include virtual="/startup.asp"-->
<%
view("title") = str("reinitialisationmdp")
set praticien = db.entity("praticien").query("praticien_id = " & querystring("praticien_id"))
view("praticien_prenom") = praticien("praticien_prenom")
%>
<!--#include virtual="/areas/email/views/_shared/header.asp"-->
<table id="desiredinformation">
</table>
<table id="criticalinfo">
    <tbody>
        <tr>
            <td>
                <p>
                    <span>Les modifications de vos informations ont bien été enregistrées.</span>
                    <br />
                    <br />
                </p>
            </td>
        </tr>
    </tbody>
</table>
<!--#include virtual="/areas/email/views/_shared/footer.asp"-->
