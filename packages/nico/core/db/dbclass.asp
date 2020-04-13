<%
class dbclass

    private m_errors
    private m_connection
    private m_pagesize
    private m_locker
    
    sub class_initialize()
        m_pagesize = 20
        set m_connection = server.createobject("adodb.connection")
        set m_errors = server.createobject("scripting.dictionary")
        set m_entities = server.createobject("system.collections.arraylist")
    end sub
    
    public property get locker() locker = m_locker end property
    public property let locker(p_locker) m_locker = p_locker end property
    public property get pagesize() pagesize = m_pagesize end property
    public property let pagesize(p_pagesize) m_pagesize = p_pagesize end property
    public property get connection() set m_connection = m_m_connection end property
    public property let connection(p_connection) set m_connection = p_connection end property
    public property get errors() set errors = m_errors end property
    public property let errors(p_errors) set m_errors = p_errors end property

    public function open(p_connectionstring)
        m_connection.open p_connectionstring
    end function

    public function script(p_sql)
        set result = server.createobject("adodb.recordset")
        result.open p_sql, m_connection, 3, 3
        set script = result
    end function
    
    public function sp(p_procedure, p_params)
        set cmd = server.createobject("adodb.command")
        set cmd.Activeconnection = m_connection
        cmd.commandText = p_Procedure
        cmd.commandType = 4
        cmd.Parameters.Refresh
        for i = 0 to UBound(p_params)
            cmd.Parameters(i + 1) = p_params(i)
        next
        set sp = cmd.execute
        set command = nothing
    end function

    public function entity(p_Entity)
        set entity = new dbentityclass
        entity.connection = m_connection
        entity.pagesize = m_pagesize
        entity.locker = m_locker
        entity.errors = m_errors
        entity.entity = p_entity

    end function

    sub class_terminate()
        if vartype(m_connection) = 9 then
            m_connection.close
            set m_connection = nothing
        end if
        if vartype(m_errors) = 9 then
            set m_errors = nothing
        end if
    end sub

end class
%>