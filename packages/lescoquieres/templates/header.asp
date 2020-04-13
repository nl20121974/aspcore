<!DOCTYPE html>
<html lang="fr">
<head>
    <title><% if view.exists("tab") then %><%=view("tab") %><% elseif view.exists("title") then %><%=view("title") %><% else %><%=config("application_name") %><% end if %></title>
    <!--#include virtual="/templates/head.asp"-->
</head>
<body class="w3-light-grey">
    <% if not isempty(routehandler.area) then %>
    <nav class="w3-sidebar w3-theme w3-collapse w3-top" style="z-index: 3; width: 270px;" id="sidebar">
        <div class="w3-bar-block w3-large w3-padding w3-theme-l4"><i class="fas fa-meteor w3-margin-right w3-text-red"></i><%=config("application_name") %></div>
        <br>
        <div class="w3-center">
            <div class="w3-dropdown-hover w3-margin-right w3-hide-large w3-hide-medium w3-center">
                <button class="w3-button" style="padding: 0!important">
                    <img src="/wwwroot/images/avatar.png" class="w3-circle w3-margin-right" style="width: 26px"><%=request.Cookies("utilisateur_prenom") %><i class="fas fa-chevron-down w3-margin-left"></i></button>
                    <div class="w3-dropdown-content w3-bar-block w3-border" style="">
                    <a href="/erp/account/preferences" class="w3-bar-item w3-btn"><i class="fa fa-users w3-margin-right"></i><%=str("mespreferences") %></a>
                    <a href="/erp/account/support" class="w3-bar-item w3-btn"><i class="fa fa-envelope w3-margin-right"></i><%=str("contacterlesupport") %></a>
                    <a href="/home/logout" class="w3-bar-item w3-btn"><i class="fa fa-toggle-on w3-margin-right"></i><%=str("sedeconnecter") %></a>
                </div>
            </div>
        </div>
        <br />
        <% if sectionexists("commandbar") then %>
        <div class="w3-bar-block w3-hide-large">
            <% on error resume next %>
            <% commandbar %>
            <% on error goto 0 %>
            <!--#include virtual="/templates/helpbar.asp"-->
            <hr class="w3-gray">
        </div>
        <% end if %>
        <div class="w3-bar-block">
            <% sidebar %>
        </div>
    </nav>
    <div class="w3-overlay w3-hide-large" onclick="w3_close()" style="cursor: pointer" title="close side menu" id="overlay"></div>
    <% end if %>
    <div class="w3-main" style="margin-left: 270px; margin-bottom: 60px;">
        <div class="w3-row w3-white w3-top">
            <div class="w3-col-m12">
                <div class="w3-col m9">
                    <a href="javascript:void(0)" class="w3-button w3-theme w3-margin-right w3-large w3-hide-large" onclick="w3_open()">☰</a>
                    <% if view.exists("returnurl") then %>
                    <%=html.anchor(view("returnurl")).content(html.icon("fa fa-arrow-left w3-margin-right w3-center")).css("w3-hover-theme w3-padding-return w3-center") %>
                    <% end if %>
                    <%=html.span(view("title")).css("w3-large w3-titlecase") %>
                </div>
                <div class="w3-col m3">
                    <div class="w3-dropdown-hover w3-margin-right w3-hide-small">
                        <button class="w3-button" style="padding: 0!important">
                            <img src="/wwwroot/images/avatar.png" class="w3-circle w3-margin-right" style="width: 26px"><%=request.Cookies("utilisateur_prenom") %><i class="fas fa-chevron-down w3-margin-left"></i></button>
                        <div class="w3-dropdown-content w3-bar-block w3-border" style="">
                            <a href="/erp/account/preferences" class="w3-bar-item w3-btn"><i class="fa fa-users w3-margin-right"></i><%=str("mespreferences") %></a>
                            <a href="/erp/account/support" class="w3-bar-item w3-btn"><i class="fa fa-envelope w3-margin-right"></i><%=str("contacterlesupport") %></a>
                            <a href="/home/logout" class="w3-bar-item w3-btn"><i class="fa fa-toggle-on w3-margin-right"></i><%=str("sedeconnecter") %></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="w3-row w3-margin-left w3-padding" style="margin-top: 60px">
            <div class="w3-col <% if sectionexists("commandbar") then %>m10<% else %>m12<% end if %>">
