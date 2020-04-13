
<!--#include virtual="/core/system/cryptography/assembly.asp"-->
<!--#include virtual="/core/system/encoders/assembly.asp"-->
<!--#include virtual="/core/system/formatters/assembly.asp"-->
<!--#include virtual="/core/system/operators/assembly.asp"-->
<!--#include virtual="/core/system/types/assembly.asp"-->
<!--#include virtual="/core/system/validators/assembly.asp"-->
<!--#include virtual="/core/system/common.asp"-->
<!--#include virtual="/core/system/ftpclass.asp"-->
<!--#include virtual="/core/system/jsonclass.asp"-->
<!--#include virtual="/core/system/parserclass.asp"-->
<!--#include virtual="/core/system/wkhtmltopdfclass.asp"-->
<!--#include virtual="/core/system/writerclass.asp"-->
<% 
set debugger = new writerclass
with debugger
    .active = request.cookies("mode") = "debug"
    .background = "#4CAF50!important"
    .foreground = "black"
end with
set writer = new writerclass
with writer
    .active = true
    .background = "#ffc107!important"
    .foreground = "black"
end with
%>