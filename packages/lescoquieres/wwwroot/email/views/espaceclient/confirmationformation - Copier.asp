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
<div class="w3-padding-large w3-border-avis w3-margin-top w3-margin-bottom">
    <span class="w3-margin-left w3-text-theme w3-bold">Votre avis sur cette formation ?</span>
    <a href="/espaceclient/home/confirmavis?clientformation_id=<%=clientformation("clientformation_id") %>&clientformation_evaluation=3" title="<%=str("edit") %>" style="margin-top: -6px" class="w3-margin-right w3-xlarge w3-right w3-text-red w3-hover-text-theme"><i class="far fa-frown"></i></a>
    <a href="/espaceclient/home/confirmavis?clientformation_id=<%=clientformation("clientformation_id") %>&clientformation_evaluation=2" style="margin-top: -6px" class="w3-margin-right w3-xlarge w3-right w3-text-yellow w3-hover-text-theme"><i class="far fa-meh"></i></a>
    <a href="/espaceclient/home/confirmavis?clientformation_id=<%=clientformation("clientformation_id") %>&clientformation_evaluation=1" style="margin-top: -6px" class="w3-right w3-margin-right w3-xlarge w3-text-green w3-hover-text-theme"><i class="far fa-smile"></i></a>
</div>
<!--#include virtual="/areas/email/views/_shared/footer.asp"-->
