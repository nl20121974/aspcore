<%
class patternformatterclass
    private m_expression
    private m_values

    public function expression(p_expression)
        m_expression = p_expression
        set expression = me
    end function

    public function values(p_values)
        m_values = p_values
        set values = me
    end function

    public default function tostring()
        set regex = new regexp
        regex.pattern = "\{.*?\}"
        regex.ignorecase = false
        regex.global = true
        set matches = regex.execute(m_expression)
        tostring = m_expression
        for each m in matches
            value = m.value
            value = replace(value, "{", "")
            value = replace(value, "}", "")
            on error resume next
            if isnull(m_values(value)) then
                tostring = replace(tostring, "{" & value & "}", empty)
            else
                tostring = replace(tostring, "{" & value & "}", m_values(value))
            end if
            on error goto 0
        next
        set matches = nothing
        set regex = nothing
    end function
end class
%>