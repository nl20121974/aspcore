<%
class htmlantiforgerytokenclass

    sub class_initialize()
        m_paragraph = false
    end sub

    public default function tostring()
        tostring = "<input name=""requestverificationtoken"" type=""hidden"" value=""" & cookies("requestverificationtoken") & """ />"
    end function

end class
%>
