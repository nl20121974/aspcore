<%
class mailmessageclass

    private m_sender
    private m_recipients
    private m_copyrecipients
    private m_subject
    private m_body
    private m_htmlbody
    private m_username
    private m_password
    private m_attachments

    sub class_initialize()
        set m_recipients = server.createobject("system.collections.arraylist")
        set m_copyrecipients = server.createobject("system.collections.arraylist")
        set m_attachments = server.createobject("system.collections.arraylist")
    end sub
    
    public property get sender() sender = m_sender end property
    public property let sender(p_sender) m_sender = p_sender end property
    public property get username() username = m_username end property
    public property let username(p_username) m_username = p_username end property
    public property get password() password = m_password end property
    public property let password(p_password) m_password = p_password end property
    public property get body() body = m_body end property
    public property let body(p_body) m_body = p_body end property
    public property get htmlbody() htmlbody = m_htmlbody end property
    public property let htmlbody(p_htmlbody) m_htmlbody = p_htmlbody end property
    public property get subject() subject = m_subject end property
    public property let subject(p_subject) m_subject = p_subject end property
    public property get recipients() set recipients = m_recipients end property
    public property let recipients(p_recipients) set m_recipients = p_recipients end property
    public property get copyrecipients() set copyrecipients = m_copyrecipients end property
    public property let copyrecipients(p_copyrecipients) set m_copyrecipients = p_copyrecipients end property
    public property get attachments() set attachments = m_attachments end property
    public property let attachments(p_attachments) set m_attachments = p_attachments end property

    public function importfromurl(p_url)
        set httprequest = server.createobject("msxml2.serverxmlhttp") 
        httprequest.open "GEt", p_url, false
        httprequest.send
        m_htmlbody = httprequest.responsebody
        set httprequest = nothing
    end function

end class
%>