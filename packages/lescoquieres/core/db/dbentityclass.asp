<%
class dbentityclass
    private m_connection
    private m_entity
    private m_where
    private m_order
    private m_pagesize
    private m_columns
    private m_sql
    private m_top
    private m_result
    private m_filter
    private m_errors
    private m_joins
    private m_take
    private m_recordset
    private m_cookie
    private m_table
    private m_only
    private m_groupby
    private m_offset
    private m_fetchnext
    private m_debugger

    sub class_initialize()
        set m_joins = server.CreateObject("system.collections.arraylist")
    end sub

    public property let connection(byref p_connection) set m_connection = p_connection end property
    public property let cookie(p_cookie) m_cookie = p_cookie end property
    public property let entity(p_entity) m_entity = p_entity end property
    public property let errors(byref p_errors) set m_errors = p_errors end property
    public property get sql() sql = m_sql end property
    public property let table(p_table) set m_table = p_table end property
    public property let pagesize(p_pagesize) m_pagesize = p_pagesize end property
    public property let locker(p_locker) m_where = p_locker end property
    public property get recordset() recordset = m_recordset end property
    
    public function totstring()
        tostring = query(empty).getstring(,,,",")
        tostring = left(getstring, len(getstring) - 1)
    end function

    public function automap(byref recordset, data)
        set columns = get_columns(m_entity)
        primarykey = get_pk(m_entity)("column_name")
        creation = isempty(recordset(primarykey))
        if m_handleerrors then on error resume next
        do while not columns.eof
            column_name = lcase(columns("column_name"))
            if data.exists(column_name) then
                debugger.write column_name & ":" & data(column_name)
                recordset(column_name) = formatdata(columns("data_type"), data(column_name), creation)
                if err.number <> 0 then
                    m_errors(column_name) = array(column_name, data(column_name), err.description, err.number)
                end if
            end if
            debugger.write column_name
            columns.movenext
        loop
        if m_handleerrors then on error goto 0
        columns.close
        set columns = nothing
        automap = true
    end function

    public function copy(p_old, p_new)
        dim columns, column_name
        set columns = get_columns(m_entity)
        do while not columns.eof
            column_name = lcase(columns("column_name"))
            p_new(column_name) = p_old(column_name)
            columns.movenext
        loop
        columns.close
        set columns = nothing
    end function

    public function groupby(p_groupby)
        m_groupby = p_groupby
        set groupby = me
    end function

    public function sum(p_column)
        dim result
        m_sql = m_sql & "select round(sum(" & p_column & "), 2) as result from " & m_entity
        if not IsEmpty(m_Where) then
            m_sql = m_sql & " where " & m_Where
        end if
        debugger.write m_sql
        set result = server.CreateObject("adodb.recordset")
        result.open m_sql, m_connection, 3, 3
        sum = result("result")
    end function

    public function find(p_params)
        filter p_params
        sort p_params
        set find = offset((cint(p_params("page")) - 1) * m_pagesize).fetchnext(m_pagesize).query(empty)
    end function

    public function filter(p_filters)
        dim recordset
        set recordset = server.CreateObject("adodb.recordset")
        recordset.open "select top 0 * from " & m_entity, m_connection, 3, 3
        if p_filters.count > 0 then
            for each column in recordset.Fields
                columnName = lcase(column.Name)
                dataType = column.Type
                if p_filters.Exists(columnName) then
                    if not isempty(p_filters(columnname)) then
                        m_filter = m_filter & " and " & formatfilter(columnname, dataType, p_filters(columnName), empty)
                    end if
                else
                    if p_filters.Exists(columnName & "1") then
                        if not isempty(p_filters(columnname & "1")) then
                            m_filter = m_filter & " and " & formatfilter(columnname, dataType, p_filters(columnName & "1"), ">=")
                        end if
                    end if
                    if p_filters.Exists(columnName & "2") then
                        if not isempty(p_filters(columnname & "2")) then
                            m_filter = m_filter & " and " & formatfilter(columnname, dataType, p_filters(columnName & "2"), "<=")
                        end if
                    end if
                end if
            next
            if (not isempty(m_filter) or Trim(m_filter) <> "") then
                if isempty(m_where) then
                    m_where = m_where & Mid(m_filter, 5)
                else
                    m_where = m_where & m_filter
                end if
            end if 
            set filter = me
        end if
    end function

    public function sort(p_sort)
        if isempty(p_sort("order")) then exit function
        dim recordset
        set recordset = server.CreateObject("adodb.recordset")
        recordset.open "select top 0 * from " & m_entity, m_connection, 3, 3
        for each column in recordset.Fields
            columnname = lcase(column.name)
            if ArrayContains(p_sort("order"), columnName & "2") then
                if not isempty(m_order) then m_order = m_order & ", "
                m_order = m_order & columnName & " desc"
            elseif ArrayContains(p_sort("order"), columnName) then
                if not isempty(m_order) then m_order = m_order & ", "
                m_order = m_order & columnName
            end if
        next
        set sort = me
    end function
    
    public function take(p_take)
        m_take = p_take
        set take = me
    end function

    public function offset(p_offset)
        m_offset = p_offset
        set offset = me
    end function

    public function fetchnext(p_fetchnext)
        m_fetchnext = p_fetchnext
        set fetchnext = me
    end function

    public function join(p_join)
        m_joins.add(p_join)
        set join = me
    end function

    public function top(p_top)
        m_top = p_top
        set top = me
    end function
    
    public function where(p_where)
        if not isempty(m_where) then
            m_where = m_where & " and "
        end if
        m_where = m_where & p_where
        set where = me
    end function

    public function asc(p_asc)
        if not isempty(m_order) then m_order = m_order & ", "
        m_order = m_order & p_asc
        set asc = me
    end function

    public function desc(p_desc)
        if not isempty(m_order) then m_order = m_order & ","
        m_order = m_order & " " & p_desc & " desc"
        set desc = me
    end function

    public function create()
        set m_recordset = server.CreateObject("adodb.recordset")
        m_recordset.open "select top 0 * from " & m_entity, m_connection, 1, 2
        m_recordset.addnew
        set create = m_recordset
    end function

    public function delete(p_where)    
        m_sql = m_sql & "delete from " & m_entity
        if not isempty(p_where) then
            m_sql = m_sql & " where " & p_where
        end if
        set result = server.CreateObject("adodb.recordset")
        result.open m_sql, m_connection, 3, 3
        set result = nothing
    end function

    public function max(p_column)
        dim result
        m_sql = m_sql & "select case when max(" & p_column & ") is null then 0 else max(" & p_column & ") end as value from " & m_entity
        if not isempty(m_where) then
            m_sql = m_sql & " where " & m_where
        end if
        set result = server.CreateObject("adodb.recordset")
        debugger.write m_sql
        result.open m_sql, m_connection, 3, 3
        max = result("value")
        result.close
        set result = nothing
    end function

    public function min(p_column)
        dim result
        m_sql = m_sql & "select case when min(" & p_column & ") is null then 0 else min(" & p_column & ") end as value from " & m_entity
        set result = server.CreateObject("adodb.recordset")
        result.open m_sql, m_connection, 3, 3
        min = result("value")
        result.close
        set result = nothing
    end function

    public function has(p_where)
        has = count(p_where) > 0
    end function

    public function count(p_where)
        dim result
        m_sql = m_sql & "select count(*) as result from " & m_entity
        if not isempty(m_where) then
            m_sql = m_sql & " where " & m_where
            if not isempty(p_where) then
                m_sql = m_sql & " and " & p_where
            end if
        end if
        if not isempty(p_where) then
            m_sql = m_sql & " where " & p_where
        end if
        debugger.write m_sql
        set result = server.CreateObject("adodb.recordset")
        result.open m_sql, m_connection, 3, 3
        count = result("result")
        result.close
        set result = nothing
    end function

    public function query(p_query)
        m_sql = m_sql & "select "
        if not isempty(m_top) then
            m_sql = m_sql & " top " & m_top & " "
        end if
        if not isempty(m_take) then
            m_sql = m_sql & " " & m_take & " "
        else
            m_sql = m_sql & " * "
        end if
        m_sql = m_sql & " from " & m_entity
        if m_joins.count > 0 then
            for each j in m_joins
                m_sql = m_sql & " left join "
                m_sql = m_sql & " " & j & " "
            next
        end if
        if not isempty(m_where) then
            m_sql = m_sql & " where " & m_where
            if not isempty(p_query) then
                m_sql = m_sql & " and " & p_query
            end if
        else
            if not isempty(p_query) then
                m_sql = m_sql & " where " & p_query
            end if
        end if
        if not isempty(m_groupby) then
            m_sql = m_sql & " group by " & m_groupby
        end if
        if not isempty(m_order) then m_sql = m_sql & " order by " & m_order
        if not isempty(m_offset) then
            m_sql = m_sql & " offset " & m_offset & " rows "
        end if
        if not isempty(m_fetchnext) then
            m_sql = m_sql & " fetch next " & m_fetchnext & " rows only"
        end if
        set m_recordset = server.CreateObject("adodb.recordset")
        m_recordset.CursorLocation = 3
        debugger.write m_sql
        starttime = timer
        m_recordset.open m_sql, m_connection, 3, 3
        if err_number <> 0 then
            err.raise err_number
        end if
        difftime = timer - starttime
        debugger.write difftime * 1.0
        set query = m_recordset
    end function
    
    private function get_columns(table_name)
        dim sql
        sql = sql & "select lower(c.name) as column_name,  lower(t.name) as table_name, ty.name as data_type, ty.system_type_id as data_type_id, c.max_length, c.is_computed, c.is_nullable, c.precision, c.is_identity "
        sql = sql & "from sys.columns c inner join sys.tables t ON c.object_id = t.object_id "
        sql = sql & "inner join sys.types ty ON c.user_type_id = ty.user_type_id  "
        sql = sql & "where t.name = '" & table_name & "' and c.is_identity = 0 and c.is_computed = 0"
        set get_columns = server.CreateObject("adodb.recordset")
        get_columns.open sql, m_connection, 3, 3
    end function
    
    private function get_pk(table_name)
        dim sql
        sql = "select lower(c.name) as column_name, c.is_identity from sys.columns c inner join sys.tables t ON c.object_id = t.object_id where t.name = '" & table_name & "' and c.is_identity = 1"
        set get_pk = server.CreateObject("adodb.recordset")
        get_pk.open sql, m_connection, 3, 3
    end function

    private function formatfilter(columnName, p_DataType, p_value, p_Comparer)
        if isempty(p_Comparer) then
            select case p_DataType
                case adDouble, adSingle, adInteger, adNumeric, adBoolean
                    formatfilter = columnName & " = " & p_value
                case adDBTimeStamp
                    formatfilter = columnName & " = '" & p_value & "'"
                case adWChar, adVarWChar, adLongVarWChar, 200
                    'COLLATE Latin1_general_CI_AI pour que la recherche ne soit pas sensible aux accents
                    formatfilter = columnName & " COLLATE Latin1_general_CI_AI like '%" & p_value & "%'"
            end select
        else
            select case p_DataType
                case adDouble, adSingle, adInteger, adNumeric, adCurrency
                    formatfilter = columnName & " " & p_Comparer & " " & p_value
                case adDate, adDBDate
                    formatfilter = " cast(" & columnName & " as date) " & p_Comparer & " cast('" & p_value & "' as date)"
                case adDBTime, adDBTimeStamp
                    if instr(p_value, "T") <> 0 then
                        formatfilter = " cast(" & columnName & " as datetime) " & p_Comparer & " cast('" & replace(p_value, "T", " ") & "' as datetime)"
                    else
                        formatfilter = " cast(" & columnName & " as date) " & p_Comparer & " cast('" & p_value & "' as date)"
                    end if
            end select
        end if
    end function

    private function formatdata(p_datatype, p_value, p_creation)
        if isempty(p_value) then
            formatdata = null
            exit function
        end if
        formatdata = p_value
        if not isnull(formatdata) then
            if p_datatype = "float" then
                if p_creation then
                    formatdata = replace(formatdata, ".", ",")
                else
                    formatdata = replace(formatdata, ",", ".")
                end if
            elseif p_datatype = "nvarchar" then
                formatdata = format.text(p_value).trim().tostring
                if formatdata = "" then
                    formatdata = null
                end if
            elseif p_datatype = "datetime" then
                if instr(p_value, "T") then
                    formatdata = replace(p_value, "T", " ") & ":00"
                end if
            elseif p_datatype = "smalldatetime" then
                if instr(p_value, "T") then
                    formatdata = replace(p_value, "T", " ") & ":00"
                end if
            end if
        end if
    end function

    sub class_terminate
        if false then
        set m_joins = nothing
        if vartype(m_errors) = 9 then
            m_recordset.close
            set m_recordset = nothing
        end if
        end if
    end sub

end class
%>
