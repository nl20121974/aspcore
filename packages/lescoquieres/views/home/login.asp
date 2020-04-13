<!--#include virtual="/startup.asp"-->
<%
    if servervariables("request_method") = "POST" then
        if not isempty(form("logwithemail")) then
            accountservice.logwithemail form("utilisateur_email"), form("utilisateur_motdepasse")
            if errors.count = 0 then
            redirect config("home_page")
            end if
        elseif not isempty(form("resetpassword")) then
            accountservice.resetpassword form("utilisateur_email"), servervariables("REMOTE_ADDR")
            redirect config("home_page")
        end if
    end if
%>
<head>
    <title><%=config("application_name") %></title>
    <!--#include virtual="/templates/head.asp"-->
    <style type="text/css">
        h1 {
            text-shadow: 0 2px 2px #666;
        }

        .w3-shadow {
            text-shadow: 0 2px 2px #666;
        }

        .w3-font-110p {
            font-size: 110%;
        }

        #clock {
            position: absolute;
            bottom: 16px;
            left: 16px;
        }

            #clock p {
                color: #fff;
                font-size: 5em;
                text-shadow: 0 2px 2px #666;
                display: inline;
                margin-right: 16px;
                font-weight: normal
            }

            #clock span {
                font-size: 3em;
                text-shadow: 0 2px 2px #666;
            }

        .w3-card-4, .w3-hover-shadow:hover {
            box-shadow: none;
        }

        a, input, span {
            font-size: 110%;
        }

        a, span {
            font-size: 110%;
            text-shadow: 0 2px 2px #666;
        }

        input {
            max-width: 280px;
            display: initial !important;
        }

        span.w3-text-red {
            /*background:#fff;*/
            display: block;
        }
    </style>

</head>
<body style="background: url('/handlers/wallpaperhandler.asp?absolutepath=<%=config("wallpapersdir") %>'); background-size: cover !important; height: 100%">
    <div style="background: url('/wwwroot/images/000000-0.4.png'); background-size: cover !important; height: 100%; padding-top: 300px!important">
        <div class="w3-row idle">
            <div class="w3-col m4 w3-padding w3-display-middle">
                <div class="w3-card-4">
                    <header class="w3-container w3-center w3-margin-bottom">
                        <img class="w3-center" src="/wwwroot/images/logo.png" style="width: 300px;" />
                    </header>
                    <% if querystring("affichage") = "" then %>
                    <div class="w3-container w3-center">
                        <form method="post">
                            <% if errors("logwithemail") = "invalid" then %>
                            <p class="w3-text-red"><%=str("logwithemailerror") %></p>
                            <% elseif errors("logwithemail") = "unauthorized" then %>
                            <p class="w3-text-red"><%=str("txterrorunauthorized") %></p>
                            <% end if %>
                            <input autocomplete="false" name="hidden" type="text" class="w3-hide">
                            <% if errors.exists("utilisateur_email") then %><p class="w3-text-red">
                                <%=str("utilisateur_email_errormessage") %>
                            <p>
                                <% end if %>
                                <% if isempty(cookies("lastuser")) then %>
                            <p>
                                <%=html.email("utilisateur_email").placeholder(str("utilisateur_email")).css("w3-light-gray w3-center").required.style("display:initial").css("w3-padding w3-input w3-border w3-light-gray w3-center").p %>
                            </p>
                            <% else %>
                            <br />
                            <h1 class="w3-shadow w3-text-white"><%=request.cookies("lastuser") %></h1>
                            <%=html.hidden("utilisateur_email").value(request.cookies("lastuser")) %>
                            <% end if %>
                            <% if errors.exists("utilisateur_motdepasse") then %>
                            <p class="w3-text-red"><%=str("utilisateur_motdepasse_errormessage") %></p>
                            <% end if %>
                            <p>
                                <%=html.password("utilisateur_motdepasse").placeholder(str("utilisateur_motdepasse")).p.css("w3-light-gray w3-center").required.style("display:inline;").css("w3-padding w3-input w3-border w3-light-gray w3-center") %>
                            </p>
                            <br />
                            <%=html.submit("logwithemail").value("Se connecter").css("w3-uppercase w3-white w3-bold w3-btn ").p %>
                            <div class="w3-container w3-center">
                                <p>
                                    <a href="?affichage=resetpassword" class="w3-underline-reset w3-text-white"><%=str("resetpass") %></a>
                                </p>
                            </div>
                        </form>
                    </div>
                    <% elseif querystring("affichage") = "resetpassword" then %>
                    <div class="w3-container w3-center">
                        <form method="post">
                            <% if errors.exists("resetpassword") then %>
                            <p class="w3-text-red"><%=str("resetpassworderror") %></p>
                            <% end if %>
                            <p class="w3-text-white w3-shadow w3-font-110p"><%=str("resetpasswordtxt") %></p>
                            <%=html.antiforgerytoken %>
                            <% if not isempty(form("resetpassword")) then %>
                            <% if errors.count = 0 then %>
                            <p class="w3-text-green"><%=str("motdepasseenvoye") %></p>
                            <% else %>
                            <p class="w3-text-red"><%=str("motdepassenonenvoye") %></p>
                            <% end if %>
                            <% end if %>
                            <p>
                                <%=html.email("utilisateur_email").placeholder(str("utilisateur_email")).css("w3-light-gray w3-center").required.style("display:initial").css("w3-padding w3-input w3-border w3-light-gray w3-center").p %>
                            </p>
                            <%=html.submit("resetpassword").value(str("resetpass")).css("w3-uppercase w3-white w3-bold w3-btn ").p %>
                        </form>
                    </div>
                    <div class="w3-container w3-center">
                        <p>
                            <a href="/" class="w3-underline-reset w3-text-white"><%=str("seconnecter") %></a>
                        </p>
                    </div>
                    <% end if %>
                </div>
            </div>
        </div>

        <% debugger.writetime %>
        <div id="clock" class="w3-text-white w3-hide-small">
            <p id="hours"></p>
            <p>:</p>
            <p id="minutes"></p>
            <br>
            <span id="date"></span>
        </div>
    </div>
    <script src="/wwwroot/js/jquery-3.3.1.min.js"></script>
    <script src="/wwwroot/js/jquery.idle.js"></script>
    <script src="/wwwroot/js/clock.js?time=<%=time %>"></script>
    <script>
        $(document).ready(function() {  
/*             $(".idle").idle(
                function() { 
                // When idle
                $(".idle").fadeTo("slow",.0);
                }, 
                function() {
                // When active again
                $(".idle").fadeTo("fast",1);
                }, 
                { after: 2000 }
            );
 */        });
    </script>
</body>
</html>