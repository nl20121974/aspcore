<%
class durationformatterclass
    private m_value
    private m_fallback
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
        result = m_value
        if isnumeric(m_value) then
            hours = int((m_value mod (60 * 60 * 24)) / (60 * 60))
            minutes = int((m_value mod (60 * 60)) / 60)
            seconds = int(m_value mod (60))
        end if
        result = format.digit(hours, 2) & ":" & format.digit(minutes, 2) & ":" & format.digit(seconds, 2)
        tostring = result
    end function
end class
%>