<%
class scaffoldingserviceclass

    private m_filesystem
    private m_logs
    private m_area
    private m_projectpath
    private m_usejoins
    private m_areapath
    private m_style

	sub class_initialize()
        set m_filesystem = server.createobject("scripting.filesystemobject")
        set m_logs = server.createobject("system.collections.arraylist")
        m_areapath = lcase(session("projectpath") & "\areas\" & request.querystring("area"))
        m_area = lcase(request.querystring("area"))
        m_projectpath = lcase(session("projectpath"))
        m_usejoins = lcase(session("usejoins"))
        m_style = lcase(session("style"))
	end sub

    public property get logs() set logs = m_logs end property

    'createresources
    public function createresources()
        trycreatepath m_projectpath & "\resources"
        set tables = schemaservice.getmodels(empty)
        do while not tables.eof
            if arraycontains(request.form("models"), tables("table_name").value) then
                table_name = lcase(tables("table_name").value)
                filename = m_projectpath & "\resources\" & table_name & ".asp"
                if m_filesystem.fileexists(filename) then
                    set file = m_filesystem.opentextfile(filename, 2)
                else
                    set file = m_filesystem.createtextfile(filename, 2)
                end if
                file.writeline "<" & "%"
                file.writeline "strings(""fr"")(""" & table_name & """) = """ & table_name & """"
                file.writeline "strings(""fr"")(""" & pluralize(table_name) & """) = """ & pluralize(table_name) & """"
                set columns = schemaservice.getcolumns(table_name)
                do while not columns.eof
                    file.writeline "strings(""fr"")(""" & lcase(columns("Column_name")) & """) = """ & lcase(columns("Column_name")) & """"
                    columns.movenext
                loop
                file.writeline "%" & ">"
                set file = nothing
                m_logs.add filename
            end if
            tables.movenext
        loop
        tables.movefirst
        if m_filesystem.fileexists(m_projectpath & "\resources" & "\assembly_scaffold.asp") then
            m_filesystem.deletefile m_projectpath & "\resources" & "\assembly_scaffold.asp"
        end if
        set file = m_filesystem.createtextfile(m_projectpath & "\resources" & "\assembly_scaffold.asp", true)
        set tables = schemaservice.gettables(empty)
        do while not tables.eof
            table_name = lcase(tables("table_name").value)
            if arraycontains(request.form("models"), table_name) then
                file.writeline "<!--#include virtual=""/resources/" & table_name & ".asp""-->"
            end if
            tables.movenext
        loop
        set tables = nothing
        file.close
        set file = nothing
        m_logs.add m_projectpath & "\resources" & "\assembly_scaffold.asp"
        set tables = nothing
    end function

    'createsidebar
	public function createsidebar()
        trycreatepath m_areapath & "\templates"
        if m_filesystem.fileexists(m_areapath & "\templates" & "\sidebar.asp") then
            m_filesystem.deletefile m_areapath & "\templates" & "\sidebar.asp"
        end if
        set file = m_filesystem.createtextfile(m_areapath & "\templates" & "\sidebar.asp", true)
        file.writeline "<" & "% sub sidebar %" & ">"
        file.writeline "<" & "%=html.sidebaritem(""/" & m_area & "/home/index"").content(html.icon(""fa fa-chart-line w3-margin-right"") & html.span(str(""dashboard"")).css(""w3-titlecase"")) %" & ">"
        set tables = schemaservice.gettables(empty)
        do while not tables.eof
            table_name = lcase(tables("table_name").value)
            if arraycontains(request.form("models"), table_name) then
                file.writeline "<" & "%=html.sidebaritem(""/" & m_area & "/" & table_name & "/index"").content(html.icon(""fa fa-poo w3-margin-right"") & html.span(str(""" & pluralize(table_name) & """)).css(""w3-titlecase"")) %" & ">"
            end if
            tables.movenext
        loop
        set tables = nothing
        file.writeline "<" & "% end sub %" & ">"
        file.close
        set file = nothing
        m_logs.add m_areapath & "\templates" & "\sidebar.asp"
    end function

    'createviews
	public function createviews()
        if not m_filesystem.fileexists(m_areapath & "\views\security.asp") then
            trycreatepath m_areapath & "\views"
            set file = m_filesystem.createtextfile(m_areapath & "\views\security.asp", true)
            file.writeline "<" & "% if request.cookies(""utilisateur_id"") = """" then redirect config(""login_page"") %" & ">"
            file.close
            set file = nothing
        end if
        if not m_filesystem.fileexists(m_areapath & "\views\home\index.asp") then
            trycreatepath m_areapath & "\views\home"
            createfile m_areapath & "\views\home\index.asp", config("current")("applicationurl") & "/scaffolding/" & m_style & "/areas/homepage.asp?projectpath=" & m_projectpath & "&area=" & m_area & "&models=" & server.urlencode(request.form("models"))
        end if
        if not m_filesystem.fileexists(m_areapath & "\startup.asp") then
            set file = m_filesystem.createtextfile(m_areapath & "\startup.asp", true)
            file.writeline "<!--#include virtual=""/startup.asp""-->"
            file.writeline "<!--#include virtual=""" & "/areas/" & m_area & "/templates/sidebar.asp""-->"
            file.writeline "<" & "%"
            file.writeline "%" & ">"
            file.close
            set file = nothing
        end if
        trycreatepath m_areapath & "\templates"
        if not m_filesystem.fileexists(m_areapath & "\templates" & "\sidebar.asp") then
            set file = m_filesystem.createtextfile(m_areapath & "\templates" & "\sidebar.asp", true)
            file.writeline "<" & "% sub sidebar %" & ">"
            file.writeline "<" & "% end sub %" & ">"
            file.close
            set file = nothing
        end if
        trycreatepath m_areapath & "\views"
        set tables = schemaservice.gettables(empty)
        do while not tables.eof
            table_name = lcase(tables("table_name").value)
            if arraycontains(request.form("models"), table_name) then
                set folder = m_filesystem.getfolder(server.mappath("/scaffolding/" & m_style & "/views"))
                for each f in folder.files
                    trycreatepath m_areapath & "\views\" & table_name
                    createfile m_areapath & "\views\" & table_name & "\" & f.name, config("current")("applicationurl") & "/scaffolding/" & m_style & "/views" & "/" & f.name & "?table_name=" & tables("table_name") & "&projectpath=" & m_projectpath & "&area=" & m_area & "&usejoins=" & m_usejoins
                next
            end if
            tables.movenext
        loop
        set tables = nothing
	end function

    'createservice
	public function createservice()
        trycreatepath m_projectpath & "\services"
        createfile m_projectpath & "\services" & "\" & m_area & "serviceclass_scaffold.asp", config("current")("applicationurl") & "/scaffolding/" & m_style & "/services/dbservice.asp?usejoins=" & m_usejoins & "&models=" & request.form("models") & "&projectpath=" & m_projectpath & "&area=" & m_area
        if m_filesystem.fileexists(m_projectpath & "\services" & "\assembly_scaffold.asp") then
            m_filesystem.deletefile m_projectpath & "\services" & "\assembly_scaffold.asp"
        end if
        set file = m_filesystem.createtextfile(m_projectpath & "\services" & "\assembly_scaffold.asp", true)
        set folder = files.getfolder(session("projectpath") & "/areas")
        for each subfolder in folder.subfolders
            file.writeline "<!--#include virtual=""/services/" & subfolder.name & "serviceclass.asp""-->"
        next
        file.close
        set file = nothing
        m_logs.add m_projectpath & "\services" & "\assembly_scaffold.asp"
        set tables = nothing
	end function
    
    'createtemplates
	public function createtemplates()
        trycreatepath m_projectpath & "\templates"
        set tables = schemaservice.gettables(empty)
        do while not tables.eof
            if arraycontains(request.form("models"), cstr(tables("table_name").value)) then
                set folder = m_filesystem.getfolder(server.mappath("/scaffolding/" & m_style & "/templates"))
                for each f in folder.files
                    trycreatepath m_projectpath & "\templates\" & tables("table_name")
                    createfile m_projectpath & "\templates\" & tables("table_name") & "\" & f.name, config("current")("applicationurl") & "/scaffolding/" & m_style & "/templates/" & f.name & "?table_name=" & tables("table_name")  & "&projectpath=" & m_projectpath & "&area=" & m_area
                next
            end if
            tables.movenext
        loop
	end function
    
    'createfile
    private function createfile(p_filename, p_url)
        p_filename = lcase(p_filename)
        m_logs.add p_filename
        set engine = new templateengineclass
        engine.filename = p_filename
        engine.exe p_url, 2
    end function

	sub class_terminate()
        set m_filesystem = nothing
        set m_logs = nothing
	end sub

end class
%>