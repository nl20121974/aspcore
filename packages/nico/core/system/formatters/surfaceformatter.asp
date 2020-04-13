<%
class surfaceformatterclass

    private m_value
    private m_fallback
    private m_precision
    private m_typename
    private m_usefallback
    private m_strict

    sub class_initialize()
        m_precision = 0
        m_defaultvalue = 0
        m_usefallback = false
        m_strict = false
    end sub

    public function strict()
        m_strict = true
    end function

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
                result = formatnumber(m_defaultvalue, m_precision) & " m²"
            elseif m_usefallback then
                result = m_fallback
            end if
            exit function
        else
            if not m_strict then
                if cstr(clng(m_value)) = cstr(m_value) then
                    m_precision = 0
                else
                    m_precision = 2
                end if
            end if
            result = formatnumber(m_value, m_precision) & " m²"
        end if
        tostring = result
    end function

    public function tostring2()
        dim result
        if not isnumeric(m_value) then
            result = formatnumber(m_defaultvalue, m_precision) & " m²"
            exit function
        end if
        if cstr(clng(m_value)) = cstr(m_value) then
            m_precision = 0
        else
            m_precision = 2
        end if
        if isnumeric(m_value) then
            result = formatnumber(m_value, m_precision) & " m²"
        elseif isnumeric(m_defaultvalue) then
            result = formatnumber(m_defaultvalue, m_precision) & " m²"
        else
            if m_usefallback then
                result = m_fallback
            end if
        end if
        tostring = result
    end function
end class
%>
