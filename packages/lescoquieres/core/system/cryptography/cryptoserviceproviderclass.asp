<%
class cryptoserviceproviderclass
    
    private m_Encoder
    private m_Provider

    sub class_initialize()
        set m_Encoder = server.CreateObject("System.Text.UTF8Encoding")
        set m_Provider = server.CreateObject("System.Security.cryptography.MD5Cryptoserviceprovider")
    end sub

    public default function Constructor(p_Provider)
        set m_Provider = p_Provider
        set Constructor = me
    end function

    public function HashBytes(p_value)
        dim bytes, result
        bytes = GetBytes(p_value)
        for i = 1 To LenB(bytes)
            result = result & LCase(Right("0" & Hex(AscB(MidB(bytes, i, 1))), 2))
        next
        HashBytes = UCase(result)
    end function

    private function GetBytes(p_value)
        dim result
        result = m_Provider.ComputeHash_2((m_Encoder.GetBytes_4(p_value)))
        GetBytes = result
    end function

end class
%>