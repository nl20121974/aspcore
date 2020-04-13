<%

class antiforgerytokenhandlerclass

    private m_condition

    sub class_initialize()
        m_condition = false
    end sub

    public property let condition(p_condition) m_condition = p_condition end property

    public function newtoken()
        newtoken = guid.tostring
        response.cookies("requestverificationtoken") = newtoken
        response.cookies("requestverificationtoken").expires = dateadd("n", 5, now)
        response.addheader "X-Frame-Options", "SAMEORIGIN"
    end function

    function renewtoken()
        if m_condition then
            if isempty(request.cookies("requestverificationtoken")) then
                newtoken
            end if
        end if
    end function
    
    function validate()
        if not isempty(request.cookies("requestverificationtoken")) then
            validate = str_compare(request.cookies("requestverificationtoken"), form("requestverificationtoken"))
        else
            validate = false
        end if
    end function

    function scan()
        if request.servervariables("REQUEST_METHOD") = "POST" then
            if not validate then
                redirect server.urlencode(request.servervariables("http_x_original_url"))
            end if
        end if
    end function
    
end class
%>