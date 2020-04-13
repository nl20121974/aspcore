<%
class Formatter

    private m_fallback
    private m_usefallback
    private m_defaultmoney
    private m_defaultvaluetype

    sub class_initialize()
        m_usefallback = false
    end sub

    public property let defaultmoney(p_defaultmoney) m_defaultmoney = p_defaultmoney : end property

    public function usefallback(p_usefallback)
        m_usefallback = p_usefallback
        set usefallback = me
    end function

    public function Withfallback(p_fallback)
        m_fallback = p_fallback
        set Withfallback = me
    end function

    public property get fallback() fallback = m_fallback end property
    public property let fallback(p_fallback) m_fallback = p_fallback end property
    
    public function Path(p_Path)
        set Path = (new PathFormatter).Path(p_Path)
    end function

    public function Bool(p_value)
        set Bool = (new BoolFormatter).value(p_value).fallback(m_fallback).usefallback(m_usefallback)
    end function

    public function Day(p_value)
        set Day = (new DayFormatter).value(p_value).fallback(m_fallback).usefallback(m_usefallback)
    end function
    
    public function daytime(p_value)
        set daytime = (new daytimeformatterclass).value(p_value).fallback(m_fallback).usefallback(m_usefallback)
    end function

    public function duration(p_value)
        set duration = (new durationformatterclass).value(p_value).fallback(m_fallback).usefallback(m_usefallback)
    end function

    public function money(p_value)
        set money = (new moneyformatterclass).value(p_value).fallback(m_fallback).usefallback(m_usefallback)
        money.money = m_defaultmoney
    end function

    public function Price(p_value)
        set Price = (new PriceFormatter).value(p_value).fallback(m_fallback).usefallback(m_usefallback)
    end function

    public function surface(p_value)
        set surface = (new surfaceformatterclass).value(p_value).fallback(m_fallback).usefallback(m_usefallback)
    end function

    public function Number(p_value)
        set Number = (new NumberFormatter).value(p_value).fallback(m_fallback).usefallback(m_usefallback)
    end function

    public function Percent(p_value)
        set Percent = (new PercentFormatter).value(p_value).fallback(m_fallback).usefallback(m_usefallback)
    end function

    public function Text(p_value)
        set Text = (new TextFormatter).value(p_value).fallback(m_fallback).usefallback(m_usefallback)
    end function

    public function hour(p_value)
        set hour = (new hourformatterclass).value(p_value).fallback(m_fallback).usefallback(m_usefallback)
    end function

    public function Phone(p_value)
        set Phone = (new PhoneFormatter).value(p_value).fallback(m_fallback).usefallback(m_usefallback)
    end function

    public function Digit(p_value, p_Digits)
        set Digit = (new DigitFormatter).value(p_value).Digits(p_Digits).fallback(m_fallback).usefallback(m_usefallback)
    end function

    public function string(p_value, p_length)
        set string = (new stringformatterclass).value(p_value).length(p_length)
    end function

    public function pattern(p_expression, p_values)
        set pattern = (new patternformatterclass).expression(p_expression).values(p_values)
    end function

end class
%>