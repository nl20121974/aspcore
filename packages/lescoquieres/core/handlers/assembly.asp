<!--#include virtual="/core/handlers/antiforgerytokenhandlerclass.asp"-->
<!--#include virtual="/core/handlers/cookieshandlerclass.asp"-->
<!--#include virtual="/core/handlers/filehandlerclass.asp"-->
<!--#include virtual="/core/handlers/formhandlerclass.asp"-->
<!--#include virtual="/core/handlers/modehandlerclass.asp"-->
<!--#include virtual="/core/handlers/querystringhandlerclass.asp"-->
<!--#include virtual="/core/handlers/routehandlerclass.asp"-->
<!--#include virtual="/core/handlers/servicehandlerclass.asp"-->
<!--#include virtual="/core/handlers/sqlinjectionhandlerclass.asp"-->
<%
'instances
set antiforgerytokenhandler = new antiforgerytokenhandlerclass
set cookieshandler = new cookieshandlerclass
set filehandler = new filehandlerclass
set formhandler = new formhandlerclass
set modehandler = new modehandlerclass
set querystringhandler = new querystringhandlerclass
set routehandler = new routehandlerclass
set servicehandler = new servicehandlerclass
set sqlinjectionhandler = new sqlinjectionhandlerclass
%>
<%
'facilities
set servervariables = request.servervariables
set form = formhandler.form
set querystring = querystringhandler.querystring
set cookies = cookieshandler.cookies
%>