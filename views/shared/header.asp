<!DOCTYPE html>
<html>
<head>
    <title><%=view("title") %></title>
    <meta charset="Windows-1252">
    <meta name="robots" content="noindex, nofollow">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="/wwwroot/css/site.css?time=<%=Time %>" />
    <link rel="stylesheet" href="/wwwroot/css/themes/1a1a1a.css?time=<%=Time %>" />
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" />
    <style type="text/css">
        #page .w3-bar-block .w3-bar-item {
            padding: 1px 16px;
        }
    </style>
</head>
<body>
    <nav class="w3-sidebar w3-collapse w3-theme-d1" style="z-index: 3; width: 270px" id="mySidebar">
        <% if session("projectpath") <> "" then %>
        <br />
        <div class="w3-bar-block">
            <a href="#" class="w3-bar-item w3-button w3-padding-16 w3-hide-large w3-dark-grey w3-hover-black" onclick="w3_close()" title="Fermer"><i class="fa fa-remove fa-fw"></i>Fermer</a>
            <a href="/home/package" class="w3-bar-item w3-btn <% if instr(request.servervariables("script_name"), "home/project") <> 0 and request.querystring("area") = "" then %>w3-black<% end if %>">PACKAGE</a>
            <% if files.folderexists(session("projectpath") & "/areas") then %>
            <span class="w3-bar-item">ZONES<a href="/home/zone"><i class="fa fa-plus w3-text-primary w3-margin-left"></i></a></span>
            <% set folder = files.getfolder(session("projectpath") & "/areas") %>
            <% if folder.subfolders.count > 0 then %>
            <hr>
            <% for each subfolder in folder.subfolders %>
            <a href="/home/project?area=<%=subfolder.name %>" style="text-transform: uppercase" class="w3-bar-item w3-btn <% if request.querystring("area") = subfolder.name then %>w3-black<% end if %>"><%=subfolder.name %></a>
            <% next %>
            <% end if %>
            <% end if %>
            <a href="/home/index" class="w3-bar-item w3-btn">Se déconnecter</a>
        </div>
        <% end if %>
    </nav>
    <div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor: pointer" title="close side menu" id="myOverlay"></div>
    <div class="w3-main" style="margin-left: 270px;">
