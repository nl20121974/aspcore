
<!--#include virtual="/core/assembly.asp"-->
<!--#include virtual="/services/assembly.asp"-->
<!--#include virtual="/config.asp"-->
<%
server.scripttimeout = 3600
response.codepage = 65001
response.charset = "utf-8"
set view = server.createobject("scripting.dictionary")
set files = server.createobject("scripting.filesystemobject")
set logs = server.createobject("system.collections.arraylist")
set scaffoldconfig = new scaffoldconfigclass
if not isempty(scaffoldconfig.connectionstring) then
    with schemaservice
        .connect scaffoldconfig.connectionstring
    end with
end if
'créer un handler qui mappe les cookies avec la "route", si route OK et cookie existe alors loop sur querystring
%>