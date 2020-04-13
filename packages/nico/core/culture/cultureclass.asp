<%
class cultureclass

    private m_current
    private m_cultures

    sub class_initialize()
        m_current = "fr-FR"
        set m_cultures = server.createobject("scripting.dictionary")
        set m_cultures("fr-FR") = server.createobject("scripting.dictionary")
        m_cultures("fr-FR")("name") = "france"
        m_cultures("fr-FR")("displayname") = "france"
        m_cultures("fr-FR")("culture") = "fr-FR"
        m_cultures("fr-FR")("lcid") = "1036"
        m_cultures("fr-FR")("datetimeformat") = "{dd/mm/yyyy}"
        m_cultures("fr-FR")("prefix") = "fr"
        set m_cultures("en-US") = server.createobject("scripting.dictionary")
        m_cultures("fr-FR")("name") = "english"
        m_cultures("fr-FR")("displayname") = "english"
        m_cultures("fr-FR")("culture") = "en-US"
        m_cultures("fr-FR")("lcid") = "1033"
        m_cultures("fr-FR")("datetimeformat") = "{yyyy/mm/dd}"
        m_cultures("fr-FR")("prefix") = "en"
    end sub

    public property let current(p_current) m_current = p_current end property

    public default function item(p_key)
        item = m_cultures(m_current)(lcase(p_key))
    end function

    sub class_terminate()
        set m_cultures = nothing
    end sub

end class
%>