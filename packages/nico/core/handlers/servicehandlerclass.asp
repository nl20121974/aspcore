<%
class servicehandlerclass

    private m_errors

    public property let errors(p_errors) set m_errors = p_errors end property

    public function handle()
        if isempty(request("servicemethod")) then
            exit function
        end if
        eval request("servicemethod")
        if m_errors.count = 0 then
            if not isempty(request("success")) then
                redirect request("success")
            end if
        else
            if not isempty(request("error")) then
                redirect request("error")
            end if
        end if
    end function

end class
%>