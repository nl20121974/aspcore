<%
class passwordmanagerclass
    private m_minchars
    private m_maxchars
    private m_strategies
    private m_length
    private m_pattern
    private m_resources
    
    sub class_initialize()
        set m_strategies = server.createobject("system.collections.arraylist")
    end sub
    public function buildpattern()
        for each s in m_strategies
            regex = regex & s.regex
        next
        m_pattern = "^" & regex & ".{" & m_minchars & "," & m_maxchars & "}$"
    end function
    public property let strategies(p_strategies)
        for each s in explode(",", p_strategies)
            m_strategies.add eval("new " & s & "strategyclass")
        next
    end property
    public property get warning()
        warning = strings("passwordstrategytext")
        for each s in m_strategies
            warning = warning & m_resources(s.name & "text") & ", "
        next
        if not isempty(warning) then
            warning = left(warning, len(warning) - 2)
        end if
        warning = warning & strings("passworddoitcontenir") & m_minchars & strings("passworddoitcontenir1") & m_maxchars & strings("passworddoitcontenir2")
    end property
    public property get strategies() strategies = m_strategies end property
    public property let minchars(p_minchars) m_minchars = p_minchars end property
    public property let maxchars(p_maxchars) m_maxchars = p_maxchars end property
    public property let resources(p_resources) set m_resources = p_resources end property
    public function generate()
        randomize
        randomized = int((p_max - p_min + 1) * rnd + p_min)
        m_length = randomized(m_minchars, m_maxchars)
        dim i, j, charcount, charset, charindex, temp, tempcopy
        randomize
        for i = 0 to m_strategies.count - 1
            if i < m_strategies.count - 1 then
                charcount = int(rnd * ((m_length - len(temp)) - (m_strategies.count - i) - 1)) + 1
            else
                charcount = m_length - len(temp)
            end if
            charset = m_strategies(i).chars
            for j = 1 to charcount
                charindex = int(rnd * len(charset)) + 1
                temp = temp & mid(charset, charindex, 1)
            next
        next
        do until len(temp) = 0
            charindex = int(rnd * len(temp)) + 1
            tempcopy = tempcopy & mid(temp, charindex, 1)
            temp = mid(temp, 1, charindex - 1) & mid(temp, charindex + 1)
        loop
        generate = tempcopy
    end function
    public function validate(p_password)
        set regex = new regexp
        regex.pattern = m_pattern
        regex.ignoreCase = false
        regex.global = true
        set matches = regex.execute(p_password)
        validate = matches.count > 0
    end function
    
end class

class lowercasestrategyclass
    public property get name() name = "lowercasestrategy" end property
    public property get chars() chars = "abcdefghijklmnopqrstuvwxyz" end property
    public property get regex() regex = "(?=.*[a-z])" end property
end class

class uppercasestrategyclass
    public property get name() name = "uppercasestrategy" end property
    public property get chars() chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ" end property
    public property get regex() regex = "(?=.*[A-Z])" end property
end class

class numberstrategyclass
    public property get name() name = "numberstrategy" end property
    public property get chars() chars = "0123456789" end property
    public property get regex() regex = "(?=.*[0-9])" end property
end class

class symbolstrategyclass
    public property get name() name = "symbolstrategy" end property
    public property get chars() chars = "!@#$+-*&?:" end property
    public property get regex() regex = "(?=.[!@#\$+-*&?:)" end property
end class
%>