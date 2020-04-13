<%
class SHA256Cryptoserviceprovider

    private m_Provider

    sub class_initialize()
        set m_Provider = (new Cryptoserviceprovider)(server.CreateObject("System.Security.cryptography.SHA256Managed"))
    end sub

    public function HashBytes(p_value)
        HashBytes = m_Provider.HashBytes(p_value)
    end function

end class
%>
