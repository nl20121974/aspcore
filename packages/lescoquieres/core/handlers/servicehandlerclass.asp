<%
class servicehandlerclass

    private m_errors

    public property let errors(p_errors) set m_errors = p_errors end property

    public function handle()
        if isempty(form("servicemethod")) then
            exit function
        end if
        eval form("servicemethod")
        if m_errors.count = 0 then
            if not isempty(form("success")) then
                redirect form("success")
            end if
        else
            if not isempty(form("error")) then
                redirect form("error")
            end if
        end if
    end function

end class
%>