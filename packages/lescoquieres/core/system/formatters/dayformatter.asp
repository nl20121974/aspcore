<%
class DayFormatter

    private m_value
    private m_fallback
    private m_precision
    private m_usefallback

    sub class_initialize()
        m_precision = 2
        m_usefallback = false
    end sub

    public function usefallback(p_usefallback)
        m_usefallback = p_usefallback
        set usefallback = me
    end function

    public function precision(p_precision)
        m_precision = p_precision
        set precision = me
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
        result = null
        if IsDate(m_value) then
            if isempty(m_precision) then
                result = FormatDateTime(m_value)
            else
                result = FormatDateTime(m_value, m_precision)
            end if
        else
            if m_usefallback then
                result = m_fallback
            end if
        end if
        tostring = result
    end function

end class
%>
