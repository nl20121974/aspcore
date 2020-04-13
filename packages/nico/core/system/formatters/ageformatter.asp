<%
class ageformatterclass

    private m_value
    private m_fallback
    private m_precision
    private m_typename
    private m_usefallback

    sub class_initialize()
        m_precision = 0
        m_defaultvalue = 0
        m_usefallback = false
    end sub

    public function precision(p_precision)
        m_precision = p_precision
        set precision = me
    end function

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
        if not isnumeric(m_value) then
            if isnumeric(m_defaultvalue) then
                result = formatnumber(m_defaultvalue, m_precision) & " an"
            elseif m_usefallback then
                result = m_fallback
            end if
            exit function
        else
            if cstr(clng(m_value)) = cstr(m_value) then
                m_precision = 0
            else
                m_precision = 2
            end if
            if m_value > 1 then
                result = formatnumber(m_value, m_precision) & " ans"
            else
                result = formatnumber(m_value, m_precision) & " an"
            end if
        end if
        tostring = result
    end function
end class
%>
