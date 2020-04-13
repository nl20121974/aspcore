<%
class resourceformatterclass

    private m_value
    private m_fallback
    private m_usefallback
    private m_trim

    sub class_initialize()
        m_trim = false
        m_usefallback = false
    end sub

    public function usefallback(p_usefallback)
        m_usefallback = p_usefallback
        set usefallback = me
    end function

    public function Nofallback()
        m_fallback = empty
        set Nofallback = me
    end function

    public function fallback(p_fallback)
        m_fallback = p_fallback
        set fallback = me
    end function

    public function value(p_value)
        m_value = p_value
        set Value = me
    end function

    public function Trim()
        m_trim = true
        set Trim = me
    end function

    public default function tostring()
        dim result
        if IsNull(m_value) or IsEmpty(m_value) then
            if m_usefallback then
                result = m_fallback
            end if
        else
            if m_trim then
                m_value = replace(m_value, "<p>&nbsp;</p>", "")
                m_value = replace(m_value, "<p>", "")
                m_value = replace(m_value, "</p>", "<br>")
                result = m_value
            else
                result = m_value
            end if
        end if
        tostring = result
    end function

end class
%>
