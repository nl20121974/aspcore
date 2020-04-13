<%
class datetimetypeclass

    private m_Date
    private m_Datetime

    public function Constructor(p_value)
        if not IsDate(p_value) then exit function
        m_Datetime = CDate(p_value) 'new dateime!
    end function

    public function secondstom(p_value)
        secondstom = (p_value Mod 3600) \ 60 & "min"
    end function

    public function secondstohm(p_value)
        Seconds = (new DigitFormatter).value(Int(p_value Mod 60)).Digits(2)
        Minutes = (new DigitFormatter).value(Int(p_value \ 60 Mod 60)).Digits(2)
        Hours = (new DigitFormatter).value(Int(p_value \ 3600)).Digits(2)
        Days = (new DigitFormatter).value(Int(p_value \ 3600 \ 24)).Digits(2)
        secondstohm = secondstohm & Hours & "H" & Minutes
    end function

    public function secondstohms(p_value)
        secondstohms = p_value \ 3600 & "H" & (p_value Mod 3600) \ 60 & "M" & p_value Mod 60
    end function

    public function isisodate(p_value)
        dim regex
        isisodate = false
        if len(p_value) > 9 then
            set regex = new RegExp
            regex.Pattern = "^\d{4}\-\d{2}\-\d{2}(T\d{2}:\d{2}:\d{2}(Z|\+\d{4}|\-\d{4})?)?$"
            if regex.Test(p_value) then
                isisodate = not IsEmpty(CIsoDate(p_value))
            end if
            set regex = nothing
        end if
    end function

    Public Function toid(p_datetime) 
        toid = replace(replace(toisodate(p_datetime) & toisotime(p_datetime), "-", ""), ":", "")
        toid = right(toid, len(toid) - 2)
    End Function

    Public Function toisodatetime(p_datetime) 
        toisodatetime = toisodate(p_datetime) & "T" & toisotime(p_datetime)
    End Function

    Public Function toisodatetime2(p_datetime) 
        toisodatetime = toisodate(p_datetime) & " " & toisotime(p_datetime)
    End Function

    Public Function toisodate(datetime)
        toisodate = cstr(Year(datetime)) & "-" & StrN2(Month(datetime)) & "-" & StrN2(Day(datetime))
    End Function    

    Public Function toisotime(datetime) 
        toisotime = StrN2(Hour(datetime)) & ":" & StrN2(Minute(datetime)) & ":" & StrN2(Second(datetime))
    End Function

    Private Function StrN2(n)
        if len(cstr(n)) < 2 then StrN2 = "0" & n else StrN2 = n
    End Function

    public function cisodate(p_value)
        cisodate = cdate(replace(mid(p_value, 1, 19) , "T", " "))
    end function

    public function format(value, precision, default_value)
        if isempty(precision) then
            precision = 0
        end if
        if isdate(value) then
            m_Datetime = formatdatetime(value, precision)
        else
            m_Datetime = default_value
        end if
    end function

    public function firstdayofweek(p_date)
        firstdayofweek = dateadd("d", -weekday(p_date, 2), p_date) + 1
    end function

    public function nextdateopendays(p_Date, p_Days)
        dim result
        select case datepart("w", p_Date)
            case 6
	            result = dateadd("d", p_Days + 2, p_Date)
            case 7
	            result = dateadd("d", p_Days + 1, p_Date)
            case else
		        result = dateadd("d", p_Days, p_Date)
        end select
        nextdateopendays = result
    end function

    public function lastdayofmonth(p_date)
        lastdayofmonth = dateadd("d", -1, cdate(dateserial(year(p_date), month(p_date) + 1, 1)))
    end function

    public function remainingdaysofmonth(p_date)
        dateend = dateadd("d", -1, cdate(dateserial(year(p_date), month(p_date) + 1, 1)))
        remainingdaysofmonth = datediff("d", p_date, dateend)
    end function

    public function firstdayofmonth(p_date, p_next)
        datestart = dateadd("m", p_next, p_date)
        firstdayofmonth = dateadd("d", -day(datestart), datestart)
    end function

    public function getdaysbymonth(p_Month)
        datestart = dateserial(year(date), p_Month, 1)
        dateend = dateadd("m", 1, datestart)
        getdaysbymonth = datediff("d", datestart, dateend)
    end function

    public function lastdayofpreviousweek(p_date)
        dim result
        result = dateadd("d", -datepart("w", p_date, 2) + 1, p_date)
        lastdayofpreviousweek = dateadd("d", -1, result)
    end function

    public default function tostring(p_Pattern)
        set tostring = m_datetime
    end function

end class
%>
