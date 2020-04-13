<%
class digitformatter
    private m_value
    private m_fallback
    private m_usefallback
    private m_digits

    sub class_initialize()
        m_usefallback = false
        m_usetrim = false
    end sub

    public function usetrim()
        m_usetrim = true
        set usetrim = me
    end function

    public function usefallback(p_usefallback)
        m_usefallback = p_usefallback
        set usefallback = me
    end function

    public function digits(p_digits)
        m_digits = p_digits
        set digits = me
    end function

    public function nofallback()
        m_fallback = empty
        set nofallback = me
    end function

    public function fallback(p_fallback)
        m_fallback = p_fallback
        set fallback = me
    end function

    public function value(p_value)
        m_value = p_value
        set value = me
    end function

    public default function tostring()
        dim result
        result = m_value
        if isnull(m_value) or isempty(m_value) then
            if m_usefallback then
                result = m_fallback
            end if
        else
            if m_usetrim and len(m_value) > m_digits then
                m_value = left(m_value, m_digits)
            end if
            m_value = cstr(m_value)
            ratio = m_digits - len(m_value)
            do while ratio > 0
                result = "0" & m_value
                ratio = ratio - 1
            loop
        end if
        tostring = result
    end function
end class
%>
