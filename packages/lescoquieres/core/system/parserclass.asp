<%
class parserclass
    private m_expression
    private m_object
    private m_result
    private m_pattern

    sub class_initialize()
        m_pattern = "\{.*?\}"
    end sub

    public function expression(p_expression)
        m_expression = p_expression
        set expression = me
    end function

    public function object(p_object)
        set m_object = p_object
        set object = me
    end function

    public property get result()
        result = m_result
    end property

    function find(p_pattern)
        set regex = new regexp
        regex.pattern = p_pattern
        regex.ignoreCase = false
        regex.global = false
        set find = regex.execute(m_expression)
    end function

    function parse(p_pattern)
        parseParts
        dim matches
        m_result = m_expression
        set regex = new regexp
        regex.pattern = p_pattern
        regex.ignoreCase = false
        regex.global = true
        set matches = regex.execute(m_expression)
        for each m in matches
            on error resume next
            if not isnull(m_object(clean(m.value))) and not isempty(m_object(clean(m.value))) then
                m_result = replace(m_result, m.value, m_object(clean(m.value)))
            end if
            on error goto 0
        next
        parse = m_result
    end function

    function cleanpart(p_value, p_delimiters)
        dim i
        for i = 1 to len(p_delimiters)
            p_value = replace(p_value, mid(p_delimiters, i, 1), "")
        next
        cleanpart = p_value
    end function
end class
%>