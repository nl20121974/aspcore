<%
class routehandlerclass
    
    private m_names
    private m_area
    private m_controller
    private m_action

    sub class_initialize()
        script_name = lcase(request.servervariables("script_name"))
        script_name = replace(script_name, "/areas", "")
        script_name = replace(script_name, "/views", "")
        m_names = split(script_name, "/")
    end sub
    
	public property get area() area = m_area end property
	public property get controller() controller = m_controller end property
	public property get action() action = m_action end property

    public function isactive(p_area, p_controller)
        isactive = p_area = m_area & p_controller = m_controller
    end function

    public function handle()
        m_action = getname(ubound(m_names))
        m_controller = getname(ubound(m_names) - 1)
        if ubound(m_names) >= 3 then
            m_area = getname(ubound(m_names) - 2)
        end if
    end function

    private function getname(p_index)
        getname = split(m_names(p_index), ".")(0)
    end function

end class
%>
