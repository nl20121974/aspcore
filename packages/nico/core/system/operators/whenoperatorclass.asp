<%
class whenoperator

    private m_condition
    private m_truetext
    private m_falsetext

    public function when(p_condition)
        m_condition = p_condition
        set when = me
    end function

    function thus(p_thus)
        m_truetext = p_thus
        set thus = me
    end function

    function otherwise(p_otherwise)
        m_falsetext = p_otherwise
        set otherwise = me
    end function

    public default function tostring()
        if m_condition then
            tostring = m_truetext
        elseif not isempty(m_falsetext) then
            tostring = m_falsetext
        end if
    end function

end class
%>
