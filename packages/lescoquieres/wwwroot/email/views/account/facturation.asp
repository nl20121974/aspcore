<!--#include virtual="/startup.asp"-->
<%
set clientfacture = db.entity("clientfacture_details").query("clientfacture_id = " & querystring("clientfacture_id"))
set client = db.entity("client").query("client_id = " & clientfacture("client_id"))
%>
<!--#include virtual="/areas/email/views/support/_shared/header.asp"-->
<table>
    <tbody>
        <tr>
            <td>
                <p>
                    <h3><%=client("client_nomcomplet") %></h3>
                </p>
            </td>
        </tr>
    </tbody>
</table>
<table id="criticalinfo">
    <tbody>
        <tr>
            <td>
                <p>
                    <h3><%=format.pattern(str(facturation_titre), array(clientfacture("clientfacture_date"))) %></h3>
                    <p><%=format.pattern(str(facturation_texte), array(clientfacture("clientfacture_date"))) %></p>
                </p>
            </td>
        </tr>
    </tbody>
</table>
<!--#include virtual="/areas/email/views/support/_shared/footer.asp"-->
