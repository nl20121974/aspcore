<%
class schemaserviceclass

    private m_connection

	sub class_initialize()
        set m_connection = server.createobject("adodb.connection")
	end sub

    public function connect(p_connectionstring)
        m_connection.Open p_connectionstring
        set connect = me
    end function
    
    'sqljoin
    public function sqljoin(p_tablename, p_strict)
        dim foreignkeys
        sqljoin = empty 
        set foreignkeys = getforeignkeys(p_tablename, "FK")
        do while not foreignkeys.eof
        if p_strict then
            sqljoin = sqljoin & ".join(""" & lcase(foreignkeys("PK_TABLE_NAME")) & " on " & lcase(foreignkeys("PK_TABLE_NAME")) & "." & lcase(foreignkeys("PK_COLUMN_NAME")) & " = " & lcase(foreignkeys("FK_TABLE_NAME")) & "." & lcase(foreignkeys("FK_COLUMN_NAME")) & """)" 
        else
            sqljoin = sqljoin & ".join(""" & lcase(foreignkeys("PK_TABLE_NAME")) & " on " & lcase(foreignkeys("PK_COLUMN_NAME")) & " = " & lcase(foreignkeys("FK_COLUMN_NAME")) & """)" 
        end if
        foreignkeys.movenext 
        loop 
        set foreignkeys = nothing
    end function

    'getmodels
	public function getmodels(p_tablename)
        if isempty(p_tablename) then
            set getmodels = m_connection.openschema(adschematables, Array(empty, "dbo", empty, empty))
        else
            set getmodels = m_connection.openschema(adschematables, Array(empty, "dbo", p_tablename, empty))
        end if
	end function

    'gettablesbyschema
	public function gettablesbynames(p_names)
        dim tables
        set tables = server.createobject("adodb.recordset")
        tables.open "select name as table_name from sys.tables where SCHEMA_NAME(schema_id) = 'dbo' and name <> 'sysdiagrams' and name in (" & p_names & ")", m_connection, 3, 3
        set gettablesbynames = tables
	end function

    'gettables
	public function gettables(p_tablename)
        set gettables = m_connection.openschema(adschematables, Array(empty, "dbo", p_tablename, "table"))
	end function

    'getviews
	public function getviews(p_tablename)
        set getviews = m_connection.openschema(adschematables, Array(empty, "dbo", p_tablename, "view"))
	end function

    'getcolumns
	public function getcolumns(p_tablename)
        set getcolumns = m_connection.openschema(adschemacolumns, Array(empty, "dbo", p_tablename, empty))
	end function

    'getNameColumn
	public function getnamingcolumn(columns)
        do while not columns.eof
            if columns("Data_Type") = 130 then
                getnamingcolumn = lcase(columns("column_name"))
                columns.movefirst
                exit function
            end if
            columns.MoveNext
        loop
	end function

    'getforeignkeys
	public function getforeignkeys(p_tablename, p_KeyType)
        if p_KeyType = "PK" then
            set getforeignkeys = m_connection.openschema(adSchemaforeignkeys, array(empty, empty, cstr(p_tablename), empty, empty, empty))
        elseif p_KeyType = "FK" then
            set getforeignkeys = m_connection.openschema(adSchemaforeignkeys, array(empty, empty, empty, empty, empty, cstr(p_tablename)))
        end if
	end function

    'getprimarykey
	public function getprimarykey(p_tablename)
        set getprimarykey = m_connection.openschema(adSchemaPrimaryKeys, Array(empty, empty, cstr(p_tablename)))
	end function
    
    'writehtmlbody
    function writehtmlbody(p_tablename, p_columns, p_Recordset)
        dim foreignkeys
        namingcolumn = empty
        set foreignkeys = getforeignkeys(p_tablename, "FK")
        for i = 0 to foreignkeys.recordcount - 1
            if foreignkeys("FK_COLUMN_NAME") = columns("Column_Name") then
                set cols = getcolumns(CStr(foreignkeys("PK_TABLE_NAME")))
                namingcolumn = getnamingcolumn(cols)
                if isempty(namingcolumn) then
                    namingcolumn = lcase(foreignkeys("FK_COLUMN_NAME"))
                end if
                set cols = nothing
                exit for
            end if
            foreignkeys.MoveNext
        next
        if foreignkeys.recordcount > 0 then foreignkeys.movefirst
        if not isempty(namingcolumn) and false then
            result = "format.text(" & lcase(p_Recordset) & "(""" & lcase(namingcolumn) & """)" & ")"
        else
            field_value = p_Recordset & "(""" & lcase(p_columns("Column_Name")) & """)"
            select case p_columns("DATA_TYPE")
                case adCurrency
                    result = "format.price(" & field_value & ")"
                case adDate, adDBDate, adDBTime, adDBTimeStamp
                    result = "format.day(" & field_value & ")"
                case adBoolean
                    result = "format.bool(" & field_value & ")"
                case adInteger, adDouble, adNumeric
                    result = "format.number(" & field_value & ")"
                case else
                    result = "format.text(" & field_value & ")"
            end select
        end if
        writehtmlbody = result
    end function

    'writehtmlform
    function writehtmlform(p_tablename, p_columns, p_modeltype_name)
        dim result, column_name, foreignkeys
        column_name = empty
        set foreignkeys = getforeignkeys(p_tablename, "FK")
        for i = 0 to foreignkeys.recordcount - 1
            if foreignkeys("FK_COLUMN_NAME") = columns("Column_Name") then
                set cols = getcolumns(CStr(foreignkeys("PK_TABLE_NAME")))
                column_name = getnamingcolumn(cols)
                if isempty(column_name) then
                    column_name = foreignkeys("FK_COLUMN_NAME")
                end if
                PK_TABLE_NAME = foreignkeys("PK_TABLE_NAME")
                PK_COLUMN_NAME = foreignkeys("PK_COLUMN_NAME")
                set cols = nothing
                exit for
            end if
            foreignkeys.MoveNext
        next
        if foreignkeys.recordcount > 0 then foreignkeys.movefirst
        if not isempty(column_name) then
            if p_modeltype_name = "querystring" then
                result = "html.list(""" & columns("Column_Name") & """).items(" & request.querystring("area") & "service.get" & PK_TABLE_NAME & "s).key(""" & PK_COLUMN_NAME & """).text(""" & column_name & """).blank(str(""choose""))"
            else
                result = "html.list(""" & columns("Column_Name") & """).items(" & request.querystring("area") & "service.get" & PK_TABLE_NAME & "s).key(""" & PK_COLUMN_NAME & """).text(""" & column_name & """).blank(str(""all""))"
            end if
        else
            column_name = lcase(columns("Column_Name"))
            select case p_columns("DATA_TYPE")
                case adDate, adDBDate, adDBTime, adDBTimeStamp
                    result = "html.day(""" & column_name & """)"
                case adWChar
                    if cdbl(columns("Character_Maximum_Length")) = 1073741823 then
                        result = "html.textarea(""" & column_name & """)"
                    else
                        result = "html.text(""" & column_name & """)"
                    end if
                case adBoolean
                    result = "html.checklist(""" & column_name & """)"
                    if p_modeltype_name = "querystring" then
                        result = result & ".blank(""str(""all"")"")"
                    else
                        result = result & ".blank(""str(""choose"")"")"
                    end if
                case adInteger, adNumeric
                    result = "html.number(""" & column_name & """)"
                case adDouble, adSingle
                    result = "html.number(""" & column_name & """)"
                case else
                    result = "html.text(""" & column_name & """)"
            end select
        end if
        if p_columns("DATA_TYPE") = adWChar then
            if cdbl(columns("Character_Maximum_Length")) = 1073741823 then
                writehtmlform = result & ".content(" & p_modeltype_name & "(""" & columns("Column_Name") & """))"
            else
                writehtmlform = result & ".value(" & p_modeltype_name & "(""" & columns("Column_Name") & """))"
            end if
        else
            writehtmlform = result & ".value(" & p_modeltype_name & "(""" & columns("Column_Name") & """))"
        end if
        if not p_columns("Is_Nullable") and p_modeltype_name <> "querystring" then
            writehtmlform = writehtmlform & ".required"
        end if
    end function

	sub class_terminate()
        set m_connection = nothing
	end sub

end class
%>