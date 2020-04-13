<%
class mailserverclass
    private m_sender
    private m_error
    private m_host
    private m_port
    private m_enablessl
    private m_username
    private m_password
    private m_errors

    sub class_initialize()
        set m_errors = server.createobject("scripting.dictionary")
        set m_attachments = server.createobject("cdo.configuration")
        m_enablessl = true
    end sub

    public property get errors() set errors = m_errors end property
    public property let errors(p_errors) set m_errors = p_errors end property
    public property get host() host = m_host end property
    public property let host(p_host) m_host = p_host end property
    public property get port() port = m_port end property
    public property let port(p_port) m_port = p_port end property
    public property get enablessl() enablessl = m_enablessl end property
    public property let enablessl(p_enablessl) m_enablessl = p_enablessl end property
    public property get sender() sender = m_sender end property
    public property let sender(p_sender) m_sender = p_sender end property
    public property get username() username = m_username end property
    public property let username(p_username) m_username = p_username end property
    public property get password() password = m_password end property
    public property let password(p_password) m_password = p_password end property

    public default function constructor(p_host, p_port, p_enablessl, p_sender, p_username, p_password)
        m_host = p_host
        m_port = p_port
        m_enablessl = p_enablessl
        m_sender = p_sender
        m_username = p_username
        m_password = p_password
        set constructor = me
    end function
    
    public function setup(p_setup)
        m_host = p_setup("smtpserver")
        m_port = p_setup("port")
        m_enablessl = p_setup("enablessl")
        m_sender = p_setup("sender")
        m_username = p_setup("username")
        m_password = p_setup("password")
        set setup = me
    end function

    function sendrecipient(p_message, p_recipient)
        'on error resume next
        set message = server.createobject("cdo.message")
        set configuration = createobject("cdo.configuration")
        with configuration
            .Fields("http://schemas.microsoft.com/cdo/configuration/smtpserver") = m_host
            .Fields("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = m_port
            .Fields("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 'cdosendusingport
            .Fields("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = m_enablessl
            .Fields("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 60
            if not isempty(m_username) and not isempty(m_password) then
            .Fields("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1
            .Fields("http://schemas.microsoft.com/cdo/configuration/sendusername") = m_username
            .Fields("http://schemas.microsoft.com/cdo/configuration/sendpassword") = m_password
            end if
            .Fields.update
        end with
        set message.configuration = configuration
        with message
            .sender = m_sender
            .From = m_username
            .to = p_recipient
            for each r in p_message.copyrecipients
                .cc = r
            next
            .subject = p_message.subject
            if not IsEmpty(p_message.body) then
                .body = p_message.body
            end if
            if not IsEmpty(p_message.htmlbody) then
                .htmlbody = p_message.htmlbody
            end if
            for each attachment in p_message.attachments
                .addattachment(attachment)
            next
        end with
        'on error resume next
        message.send
        if err.number <> 0 then
            m_errors("send_error") = "error"
        end if
        on error goto 0
        set message = Nothing
        if err.number <> 0 then
            m_errors.add p_recipient, "invalid"
        end if
        on error goto 0
        set sendrecipient = m_errors
    end function

    function send(p_message)
        dim r, e
        if p_message.recipients.count = 0 and p_message.copyrecipients.count = 0 then
            m_errors.add "email", "norecipient"
        end if
        if isempty(p_message.body) and isempty(p_message.htmlbody) then
            m_errors.add "email", "nobody"
        end if
        for each r in p_message.recipients
            for each e in sendrecipient(p_message, r)
                'on error resume next
                m_errors(e) = "invalid"
                on error goto 0
            next
        next
        set send = m_errors
    end function

    sub class_terminate()
        set m_configuration = nothing
    end sub

end class
%>