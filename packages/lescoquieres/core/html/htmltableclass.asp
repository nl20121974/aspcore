<%
class htmltableclass

    private m_id
    private m_canpaginate
    private m_canfilter
    private m_canorder
    private m_records
    private m_columns
    private m_rowclick
    private m_rowhref
    private m_autogenerate
    private m_parser
    private m_viewname
    private m_footerquery
    private m_rowblank

    sub class_initialize()
        m_rowblank = false
        m_pagesize = 20
        m_autogenerate = false
        m_displayheader = true
        m_canpaginate = true
        m_canfilter = true
        m_canorder = true
        set m_parser = new templateparserclass
        set m_columns = server.CreateObject("system.collections.arraylist")
    end sub
    
    public property get displayheader() displayheader = m_displayheader end property
    public property let displayheader(p_displayheader) m_displayheader = p_displayheader end property
    public property get id() id = m_id end property
    public property let id(p_id) m_id = p_id end property
    public property get rowblank() rowblank = m_rowblank end property
    public property let rowblank(p_rowblank) m_rowblank = p_rowblank end property
    public property get canfilter() canfilter = m_canfilter end property
    public property let canfilter(p_canfilter) m_canfilter = p_canfilter end property
    public property get canorder() canorder = m_canorder end property
    public property let canorder(p_canorder) m_canorder = p_canorder end property
    public property get canpaginate() canpaginate = m_canpaginate end property
    public property let canpaginate(p_canpaginate) m_canpaginate = p_canpaginate end property
    public property get columns() set columns = m_columns end property
    public property let columns(p_columns)
        if not isarray(p_columns) then
            p_columns = array(p_columns)
        end if
        for each c in p_columns
            m_columns.add lcase(trim(c))
        next
    end property
    public property get rowhref() rowhref = m_rowhref end property
    public property let rowhref(p_rowhref) m_rowhref = p_rowhref end property
    public property get rowclick() rowclick = m_rowclick end property
    public property let rowclick(p_rowclick) m_rowclick = p_rowclick end property
    public property get records() set records = m_records end property
    public property let records(p_records) set m_records = p_records end property
    public property get autogenerate() autogenerate = m_autogenerate end property
    public property let autogenerate(p_autogenerate) m_autogenerate = p_autogenerate end property
    public property let viewname(p_viewname) m_viewname = p_viewname end property
    public function pagecount() pagecount = m_records.pagecount end function
    public function pagesize() pagesize = m_records.pagesize end function
    public function eof() eof = m_records.eof end function
    public function movenext() movenext = m_records.movenext end function
    public function recordcount() recordcount = m_records.recordcount end function
    public property get absolutepage() absolutepage = m_records.absolutepage end property
    public property let absolutepage(p_absolutepage) m_records.absolutepage = p_absolutepage end property
    public default function field(p_field) set field = m_records.fields(p_field) end function
    public function has(p_field) has = m_columns.contains(p_field) end function
    public function onrowclick()
        onrowclick = empty
        if not isempty(m_rowclick) then
            onrowclick = "onclick=""" & m_parser.expression(m_rowclick).object(m_records).parse & """"
        elseif not isempty(m_rowhref) then
            if m_rowblank then
                onrowclick = "onclick=""window.open('" & m_parser.expression(m_rowhref).object(m_records).parse & "')"""
            else
                onrowclick = "onclick=""location.href='" & m_parser.expression(m_rowhref).object(m_records).parse & "'"""
            end if
        end if
    end function
    
    public sub emptyrow()
        if m_eof then
            response.write "<tr><td colspan=""100"">Aucun résultat pour cette recherche</td></tr>"
        end if
    end sub

    public function col(p_column) m_columns.add lcase(p_column) : set col = me end function

    public function build()
        if m_canfilter and isempty(m_viewname) then err.Raise "10000", "Message pour RS : attention à mettre viewname", empty, empty
        dim columns, stringbuilder
        if not isempty(m_id) then
            stringbuilder = empty
            if not m_records.eof and m_records.RecordCount > 0 then
                if isempty(querystring("page")) then
                    m_records.absolutepage = 1
                else
                    m_records.absolutepage = cint(querystring("page"))
                end if
            end if
            set columns = dbconnection.OpenSchema(adSchemacolumns, array(empty, "dbo", m_viewname, empty))
            do while not columns.eof
                column_name = cstr(columns("column_name"))
                if request.QueryString(column_name) <> "" then
                    stringbuilder = stringbuilder & "&" & column_name & "=" & request.QueryString(column_name)
                else
                    if request.QueryString(column_name & "1") <> "" then
                        stringbuilder = stringbuilder & "&" & column_name & "1" & "=" & request.QueryString(column_name & "1")
                    end if
                    if request.QueryString(column_name & "2") <> "" then
                        stringbuilder = stringbuilder & "&" & column_name & "2" & "=" & request.QueryString(column_name & "2")
                    end if
                end if
                columns.movenext
            loop
            columns.close
            if not isempty(stringbuilder) then stringbuilder = Mid(stringbuilder, 2)
            if request.QueryString("order") <> "" then
                cookieresult = cookieresult & "&order=" & request.QueryString("order")
            end if
            if request.QueryString("page") <> "" then
                cookieresult = cookieresult & "&page=" & request.QueryString("page")
            end if
            if not isempty(cookieresult) then cookieresult = mid(cookieresult, 2)
            if not isempty(cookieresult) then
                fullresult = cookieresult
                if not isempty(stringbuilder) then
                    fullresult = fullresult & "&" & stringbuilder
                end if
            elseif not isempty(stringbuilder) then
                fullresult = stringbuilder
            end if
            response.Cookies(m_id) = fullresult
        end if
        set build = me
    end function

    sub class_terminate
        set m_parser = nothing
        set m_columns = nothing
    end sub
    
end class
%>
