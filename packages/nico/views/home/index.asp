<!--#include virtual="/startup.asp"-->
<%
%>
<!--#include virtual="/templates/header.asp"-->
<div class="w3-row" style="margin-top: 50px">
    <div class="w3-col m4">&nbsp;</div>
    <div class="w3-col m4">
        <h2 class="w3-titlecase"><%=str("home") %>
    </div>
    <div class="w3-col m4">&nbsp;</div>
</div>
<div class="w3-row" style="margin-top: 50px">
    <div class="w3-col m3">
        <table class="w3-table w3-table-blank w3-hoverable">
            <tr onclick="location.href='/parametrage/home/index'">
                <td><%=html.icon("fa fa-poo fa-2x w3-margin-right") %></td>
                <td>
                    <%=html.label("paramétrage") %>
                    <%=html.span("Exemple de description pour la zone + penser à modifier l'îcone").css("w3-titlecase w3-text-dark-gray") %>
                </td>
            </tr>
        </table>
    </div>
    <div class="w3-col m3">
        <table class="w3-table w3-table-blank w3-hoverable">
            <tr onclick="location.href='/vente/home/index'">
                <td><%=html.icon("fa fa-poo fa-2x w3-margin-right") %></td>
                <td>
                    <%=html.label("vente") %>
                    <%=html.span("Exemple de description pour la zone + penser à modifier l'îcone").css("w3-titlecase w3-text-dark-gray") %>
                </td>
            </tr>
        </table>
    </div>
    <div class="w3-col m3">
        <table class="w3-table w3-table-blank w3-hoverable">
            <tr onclick="location.href='/rapport/home/index'">
                <td><%=html.icon("fa fa-poo fa-2x w3-margin-right") %></td>
                <td>
                    <%=html.label("rapports") %>
                    <%=html.span("Exemple de description pour la zone + penser à modifier l'îcone").css("w3-titlecase w3-text-dark-gray") %>
                </td>
            </tr>
        </table>
    </div>
</div>
<!--#include virtual="/templates/footer.asp"-->
