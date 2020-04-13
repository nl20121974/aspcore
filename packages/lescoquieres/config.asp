<% 
set config = server.createobject("scripting.dictionary")
set config("connections") = server.createobject("scripting.dictionary")
config("application_name") = "{domain}"
config("support_email") = "support@security.fr"
config("noreply_email") = "ne-pas-repondre@savati.net"
config("home_page") = "/erp/home/index"
config("login_page") = "/home/login"
config("logout_page") = "/home/logout"
config("error_page") = "/home/error"
config("authorization_error_page") = "/home/authorizationerror"
config("default_culture") = "fr-FR"
config("filesdir") = "C:\inetpub\wwwroot\lescoquieres\files\"
config("themepath") = "/wwwroot/css/themes"
set config("mailagent") = server.createobject("scripting.dictionary")
with config("mailagent")
    .item("sender") = "ne-pas-repondre@savati.net"
    .item("sendername") = "ne-pas-repondre@savati.net"
    .item("smtpserver") = "82.97.16.91"
    .item("port") = 366
    .item("enablessl") = false
    .item("username") = "ne-pas-repondre@savati.net"
    .item("password") = "Security0-"
end with
set config("supported_cultures") = server.createobject("system.collections.arraylist")
with config("supported_cultures")
    .add "fr-FR"
    .add "en-US"
end with
set config("profiles") = server.createobject("scripting.dictionary")
set config("profiles")("production") = server.createobject("scripting.dictionary")
with config("profiles")("production")
    .item("host") = "10.250.250.100"
    .item("key") = "prod"
    .item("name") = "{domain}"
    .item("domain") = "{domain}.savati.net"
    .item("connectionstring") = "{connectionstring}"
end with
set config("profiles")("development") = server.createobject("scripting.dictionary")
with config("profiles")("development")
    .item("key") = "dev"
    .item("name") = "{domain}"
    .item("domain") = "{domain}.savati.net"
    .item("connectionstring") = "{connectionstring}"
end with
set config("profiles")("local") = server.createobject("scripting.dictionary")
with config("profiles")("local")
    .item("key") = "local"
    .item("name") = "{domain}"
    .item("domain") = "localhost"
    .item("connectionstring") = "driver={SQL Server}; Server=82.97.16.90; uid=lescoquieres13102019; pwd=!85LesCO1319!; database=lescoquieres"
end with
set config("current") = server.createobject("scripting.dictionary")
config("current")("culture") = "fr"
config("current")("domain") = request.servervariables("server_name")
for each profile in config("profiles").items
    if lcase(profile("domain")) = lcase(config("current")("domain")) then
        set config("current")("profile") = profile
        exit for
    end if
next
if request.servervariables("https") = "OFF" then
    config("current")("applicationurl") = "https://" & config("current")("domain")
else
    config("current")("applicationurl") = "http://" & config("current")("domain")
end if
set config("html") = server.createobject("scripting.dictionary")
set config("html")("styles") = server.createobject("scripting.dictionary")
with config("html")("styles")
    .item("text") = "w3-input w3-border"
    .item("password") = "w3-input w3-border"
    .item("input") = "w3-input w3-border"
    .item("list") = "w3-input w3-border"
    .item("checklist") = "w3-input w3-border"
    .item("number") = "w3-input w3-border"
    .item("file") = "w3-input"
    .item("check") = "w3-check"
    .item("radio") = "w3-radio"
    .item("button") = "w3-btn w3-theme"
    .item("submit") = "w3-btn w3-theme"
    .item("select") = "w3-input w3-border"
    .item("textarea") = "w3-input w3-border"
    .item("anchor") = "w3-text-theme"
    .item("baritem") = "w3-bar-item w3-theme w3-hover-theme"
    .item("sidebaritem") = "w3-bar-item w3-theme w3-hover-theme"
    .item("commandbaritem") = "w3-bar-item w3-text-dark-gray w3-hover-text-gray"
    .item("arrow-down") = "fas fa-arrow-down w3-margin-left"
    .item("arrow-up") = "fas fa-arrow-up w3-margin-left"
    .item("label") = "w3-show w3-bold"
    .item("icons_sort") = array("<i class=""fa fa-arrow-up w3-margin-left""></i>", "<i class=""fa fa-arrow-down w3-margin-left""></i>")
    .item("row") = "w3-row"
    .item("required") = "w3-text-red w3-margin-left w3-bold"
    set .item("table") = server.createobject("scripting.dictionary")
    .item("table")("bordered") = "w3-table w3-bordered"
    .item("table")("all") = "w3-table-all w3-bordered"
    .item("table")("tr") = "w3-light-gray"
    .item("table")("tablefooter") = "w3-right w3-margin-top"
end with
set config("html")("properties") = server.createobject("scripting.dictionary")
with config("html")("properties")
    .item("pagesize") = "25"
    .item("fallback") = str("notcommunicated")
end with
%>