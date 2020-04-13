<%
class moneyformatterclass
    private m_value
    private m_fallback
    private m_precision
    private m_typename
    private m_usefallback
    private m_money

    sub class_initialize()
        m_money = "€"
        m_precision = 2
        m_defaultvalue = 0
        m_usefallback = false
    end sub

    public function money(p_money)
        m_money = p_money
        set money = me
    end function


    public property let money(p_money) m_money = p_money : end property

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
        if isnumeric(m_value) then
            result = formatnumber(m_value, m_precision)
        elseif isnumeric(m_defaultvalue) then
            result = formatnumber(m_defaultvalue, m_precision)
        else
            if m_usefallback then
                result = m_fallback
            end if
        end if
        tostring = result & " " & m_money
    end function
end class
%>
