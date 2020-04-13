<!DOCTYPE html>
<html lang="fr">
<head>
    <title><%=config("application_name") %></title>
    <!--#include virtual="/templates/head.asp"-->
</head>
<body>
    <% if not isempty(routehandler.area) then %>
    <nav class="w3-sidebar w3-theme w3-collapse w3-top" style="z-index: 3; width: 300px;" id="sidebar">
        <br>
        <div class="w3-bar-block">
            <% if view.exists("returnurl") then %>
            <%=html.anchor(view("returnurl")).content(html.icon("fa fa-arrow-left w3-margin-right") & html.span(str("back"))).css("w3-bar-item w3-button") %>
            <% end if %>
        </div>
        <br>
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
            <%=html.sidebaritem("/home/index").content(html.icon("fa fa-home w3-margin-right") & html.span(str("home")).css("w3-titlecase")) %>
            <% sidebar %>
        </div>
    </nav>
    <header class="w3-top w3-hide-large w3-theme">
        <a href="javascript:void(0)" class="w3-button w3-theme w3-margin-right w3-large" onclick="w3_open()">☰</a>
        <span><%=config("application_name") %></span>
    </header>
    <div class="w3-overlay w3-hide-large" onclick="w3_close()" style="cursor: pointer" title="close side menu" id="overlay"></div>
    <% end if %>
    <div class="w3-main w3-padding" style="margin-left: 300px; margin-bottom: 60px;">
        <div class="w3-row">
            <div class="w3-col-m12">
                <%=html.p(view("title")).css("w3-large w3-titlecase") %>
            </div>
        </div>
        <div class="w3-row">
            <div class="w3-col <% if sectionexists("commandbar") then %>m9<% else %>m12<% end if %>">
