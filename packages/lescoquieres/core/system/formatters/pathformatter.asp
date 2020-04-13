<%
class PathFormatter
    private m_Path

    public function Path(p_Path)
        m_Path = p_Path
        set Path = me
    end function

    public default function tostring()
        dim result
        result = m_Path
        result = replace(result, "/", "\")
        result = replace(result, "\\", "\")
        tostring = result
    end function
end class
%>
