<%
class stringformatterclass
    private m_value
    private m_fallback
    private m_usefallback
    private m_length
    private m_position
    private m_character

    sub class_initialize()
        m_usefallback = false
        m_usetrim = false
        m_position = -1
        m_character = "0"
    end sub

    public function usetrim()
        m_usetrim = true
        set usetrim = me
    end function

    public function usefallback(p_usefallback)
        m_usefallback = p_usefallback
        set usefallback = me
    end function

    public function length(p_length)
        m_length = p_length
        set length = me
    end function

    public function value(p_value)
        m_value = p_value
        set value = me
    end function

    public function character(p_character)
        m_character = p_character
        set character = me
    end function

    public function position(p_position)
        m_position = p_position
        set position = me
    end function

    public default function tostring()
        dim result
        if isnull(m_value) or isempty(m_value) then
            ratio = m_length
            do while ratio > 0
                result = result & " "
                ratio = ratio - 1
            loop
        else
            m_value = cstr(m_value)
            if m_length > 0 and len(m_value) > m_length then
                m_value = left(m_value, m_length)
            end if
            ratio = m_length - len(m_value)
            do while ratio > 0
                result = result & m_character
                ratio = ratio - 1
            loop
            if m_position = -1 then
                result = result & m_value
            elseif m_position = 1 then
                result = m_value & result
            end if
        end if
        tostring = result
    end function
end class
%>
