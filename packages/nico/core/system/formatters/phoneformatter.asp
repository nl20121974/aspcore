<%
class PhoneFormatter

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

    public function Nofallback()
        m_fallback = empty
        set Nofallback = me
    end function

    public function fallback(p_fallback)
        m_fallback = p_fallback
        set fallback = me
    end function

    public function value(p_value)
        if not isnull(p_value) then
            p_value = replace(p_value, " ", "")
        end if
        m_value = p_value
        set Value = me
    end function

    public default function tostring()
        dim result, stringformat, i
        stringformat = "## ## ## ## ##"
        if IsNull(m_value) or IsEmpty(m_value) then
            if m_usefallback then
                result = m_fallback
            end if
        else
            index = 1
            for i = 1 to len(stringformat)
                if index > len(m_value) then exit for
                character = mid(stringformat, i, 1)
                if character = "#" then
                    result = result & mid(m_value, index, 1)
                    index = index + 1
                else
                    result = result & character
                end if
            next
        end if
        tostring = result
    end function

end class
%>
