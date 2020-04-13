<%
class daytimeformatterclass

    private m_value
    private m_fallback
    private m_precision
    private m_usefallback

    sub class_initialize()
        m_usefallback = false
    end sub

    public function usefallback(p_usefallback)
        m_usefallback = p_usefallback
        set usefallback = me
    end function

    public function fallback(p_fallback)
        m_fallback = p_fallback
        set fallback = me
    end function

    public function value(p_value)
        m_value = p_value
        set Value = me
    end function

    public default function tostring()
        dim result
        if not isnull(m_value) then
            result = formatdatetime(m_value, 2) & " " & replace(formatdatetime(m_value, 4), ":", "H")
        end if
        if isempty(result) then
            if m_usefallback then
                result = m_fallback
            end if
        end if
        tostring = result
    end function

end class
%>
