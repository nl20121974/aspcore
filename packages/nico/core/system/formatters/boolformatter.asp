<%
class BoolFormatter

    private m_value
    private m_defaultvalue
    private m_fallback
    private m_usefallback

    sub class_initialize()
        m_usefallback = false
    end sub

    public function value(p_value)
        m_value = p_value
        set Value = me
    end function

    public function usefallback(p_usefallback)
        m_usefallback = p_usefallback
        set usefallback = me
    end function

    public function fallback(p_fallback)
        m_fallback = p_fallback
        set fallback = me
    end function

    public default function tostring()
        dim result
        result = false
        if IsNull(m_value) or IsEmpty(m_value) then
            if m_usefallback then
                if not IsEmpty(m_fallback) then
                    result = m_fallback
                end if
            end if
        else
            if vartype(m_value) = 11 then
                if m_value then
                    result = m_value
                end if
            elseif m_value = 1 or m_value = "1" then
                result = true
            end if        
            if result then
                tostring = "Oui"
            else
                tostring = "Non"
            end if
        end if

    end function

end class
%>
