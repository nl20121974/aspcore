<!--#include virtual="/startup.asp"-->
<%
set support = db.entity("support").query("support_id = " & querystring("support_id"))
set utilisateur = db.entity("utilisateur_details").query("utilisateur_id = " & querystring("utilisateur_id"))
%>
<!--#include virtual="/areas/email/views/support/_shared/header.asp"-->
<table>
    <tbody>
        <tr>
            <td>
                <p>
                    <h3><%=utilisateur("utilisateur_nomcomplet") %></h3>
                    <p><%=utilisateur("cabinet_nom") %></p>
                </p>
            </td>
        </tr>
    </tbody>
</table>

<table id="desiredinformation">
    <tbody>
        <tr>
            <td>
                <p>
                    <h3><%=support("support_objet") %></h3>
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
                    <p><%=support("support_message") %></p>
                </p>
            </td>
        </tr>
    </tbody>
</table>
<!--#include virtual="/areas/email/views/support/_shared/footer.asp"-->
