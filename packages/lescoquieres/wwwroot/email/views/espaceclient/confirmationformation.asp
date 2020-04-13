<!--#include virtual="/startup.asp"-->
<%
view("title") = str("confirmformation")
set client = db.entity("client").query("client_id = " & querystring("client_id"))
set clientformation = espaceclientservice.getclientformations(client("client_id")) 

view("client_nom") = client("client_nom")
%>
<!--#include virtual="/areas/email/views/_shared/header.asp"-->
<table id="desiredinformation">
</table>
<table class="w3-table-all" style="border: none">
    <tr style="border: none">
        <td>
            <p style="color: #32b1b6; font-weight: bold; font-size: 24px">Confirmation de votre réservation</p>

            <% with locale("clientformation") %>
            <span class="w3-bold">
                <%=clientformation("formationtype_nom")%>
            </span>
            <br />
            <span class="">
                <%="du " & clientformation("clientformation_datedebut") & " au " & clientformation("clientformation_datefin")%>
            </span>
            <br />
            <span class="">
                <%=clientformation("formateur_nomcomplet")%>
            </span>
            <% end with %>
        </td>

    </tr>
</table>

<!--#include virtual="/areas/email/views/_shared/footer.asp"-->
