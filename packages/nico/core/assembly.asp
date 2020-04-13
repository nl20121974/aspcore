<!--#include virtual="/core/authentication/assembly.asp"-->
<!--#include virtual="/core/culture/assembly.asp"-->
<!--#include virtual="/core/db/assembly.asp"-->
<!--#include virtual="/core/handlers/assembly.asp"-->
<!--#include virtual="/core/html/assembly.asp"-->
<!--#include virtual="/core/helpers/assembly.asp"-->
<!--#include virtual="/core/mail/assembly.asp"-->
<!--#include virtual="/core/system/assembly.asp"-->
<%
response.codepage = 65001
response.charset = "utf-8"
set messages = server.createobject("scripting.dictionary")
set errors = server.createobject("scripting.dictionary")
set view = server.createobject("scripting.dictionary")
set strings = server.createobject("scripting.dictionary")
%>