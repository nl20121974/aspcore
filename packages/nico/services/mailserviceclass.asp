<%
class mailserviceclass
    private m_db
    private m_errors
    private m_config
    
    public property let db(p_db) set m_db = p_db end property
    public property let errors(p_errors) set m_errors = p_errors end property
    public property let config(p_config) set m_config = p_config end property

    public function newmailserver()
        set newmailserver = new mailserverclass
        with newmailserver
            .sender = m_config("sender")
            .host = m_config("smtpserver")
            .port = m_config("port")
            .enablessl = m_config("enablessl")
            .username = m_config("username")
            .password = m_config("password")
        end with
    end function

    public function newmailmessage(p_subject, p_body)
        set newmessage = new mailmessageclass
        with newmessage
            .subject = p_subject
            .htmlbody = p_body
        end with
    end function

    public function newmessagefromuri(p_subject, p_uri)
        set xhttp = server.CreateObject("MSXML2.ServerXMLHTTP")
        xhttp_uri = p_uri
        xhttp.open "GET", xhttp_uri, false
        xhttp.send
        set newmessagefromuri = new mailmessageclass
        with newmessagefromuri
            .subject = p_subject
            .htmlbody = xhttp.responsetext
        end with
        set xhttp = nothing
    end function

    function sendclientcourrier(clientcourrier) 
        set client = m_db.entity("client").query("client_id = " & clientcourrier("client_id"))
        set mailclient = (new cdosmtpclientclass).setup(config("mailagent"))
        set mailmessage = new mailmessageclass
        mailmessage.subject = clientcourrier("clientcourrier_objet")
        mailmessage.htmlbody = clientcourrier("clientcourrier_contenu")
        'mailmessage.recipients.add client("client_email")
        mailmessage.recipients.add "support@security.fr"
        mailmessage.recipients.add "nicolas@security.fr"
        mailmessage.copyrecipients.add config("noreply_email")
        set clientcourrierfichiers = m_db.entity("clientcourrierfichier").query("clientcourrier_id = " & clientcourrier("clientcourrier_id"))
        do while not clientcourrierfichiers.eof
            mailmessage.attachments.add config("filesdir") & "clientcourrierfichier\" & lcase(clientcourrierfichiers("clientcourrierfichier_fichier"))
            clientcourrierfichiers.movenext
        loop
        mailclient.send mailmessage
    end function

end class
%>


