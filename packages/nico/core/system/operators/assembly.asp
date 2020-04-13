<!--#include virtual="/core/system/operators/whenoperatorclass.asp"-->
<%
public function when(p_when)
    set when = (new whenoperatorclass).when(p_when)
end function
%>