<%
class HMACSHA256cryptoserviceproviderclass
    
    private m_Provider

    public default function Constructor(p_Key)
        set provider = server.CreateObject("System.Security.cryptography.HMACSHA256")
        provider.Key = p_Key
        set m_Provider = (new Cryptoserviceprovider)(provider)
        set Constructor = me
    end function

    public function HashBytes(p_value)
        HashBytes = m_Provider.HashBytes(p_value)
    end function

end class
%>
