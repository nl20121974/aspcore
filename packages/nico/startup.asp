<!--#include virtual="/core/assembly.asp"-->
<!--#include virtual="/services/assembly.asp"-->
<!--#include virtual="/strings.asp"-->
<!--#include virtual="/resources/assembly.asp"-->
<!--#include virtual="/config.asp"-->
<!--#include virtual="/common.asp"-->
<%
response.addheader "Access-Control-Allow-Origin", config("current")("applicationurl")
'db
set db = new dbclass
with db
    .open config("current")("profile")("connectionstring")
    .errors = errors
end with
'services
set errorservice = new errorserviceclass
with errorservice
    .db = db
    .errors = errors
end with
set mailservice = new mailserviceclass
with mailservice
    .db = db
    .errors = errors
end with
set accountservice = new accountserviceclass
with accountservice
    .db = db
    .errors = errors
end with
'html
with html
    .styles = config("html")("styles")
    .properties = config("html")("properties")
    .errors = errors
end with
'handlers
with antiforgerytokenhandler
    .condition = true
    .renewtoken
end with
with cookieshandler
    .expires = dateadd("yyyy", 1, date)
    .handle
end with
with filehandler
    .basedirectory = config("filesdir")
    .handle
end with
with formhandler
    .handle
end with
with modehandler
    .handle
end with
with querystringhandler
    .handle
end with
with routehandler
    .handle
end with
with servicehandler
    .errors = errors
    .handle
end with
with sqlinjectionhandler
    .errorpage = config("error_page")
    .handle
end with
if querystring("edition") = "excel" then
    response.contenttype = "application/vnd.ms-excel;"
end if
%>