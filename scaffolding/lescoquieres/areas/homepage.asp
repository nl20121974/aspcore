<!--#include virtual="/startup.asp"-->
<%="<!--#include virtual=""" & scaffoldconfig.areapath & "/startup.asp""-->" %><%=vbcrlf %>
<%="<!--#include virtual=""" & scaffoldconfig.areapath & "/views/security.asp""-->" %><%=vbcrlf %>
[ view("title") = str("tableaudebord") ]
[ view("tab") = str("tableaudebord") ]
<%="<!--#include virtual=""/templates/header.asp""-->" %>
[ sub styles ]
<style type="text/css">
    #tableaubord .w3-table td, .w3-table th, .w3-table-all td, .w3-table-all th {
        padding: 16px 8px;
        vertical-align: middle;
        border: none !important;
    }

    #tableaubord table tr td:first-child {
        width: 75px;
        text-align: center;
    }

    #tableaubord .w3-table-all tr:nth-child(even) {
        background-color: inherit;
    }

    #tableaubord .w3-card-4 .w3-container {
        height: 250px;
        padding: 0
    }

    #tableaubord .w3-badge {
        border-radius: 4px;
        width: 100%
    }

    #tableaubord .w3-card-4 {
        border-radius: 3px;
    }
</style>
[ end sub ]
<div id="tableaubord">
    <div class="w3-row-padding">
        <div class="w3-col-m12">
            <div class="w3-container">
                <h4>Bienvenue <%=request.Cookies("utilisateur_prenom") %> !</h4>
            </div>
        </div>
    </div>
</div>
<div class="w3-row">
    <div class="w3-col m3">
        <div class="w3-card-4">
            <header class="w3-theme-l5">
                <p>ENCART 1</p>
            </header>
            <div class="w3-container">
                <table class="w3-table w3-bordered w3-hoverable">
                </table>
            </div>
        </div>
    </div>
</div>


<%="<!--#include virtual=""/templates/footer.asp""-->" %>
