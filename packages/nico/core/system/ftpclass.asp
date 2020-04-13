<%
class ftpclass
    private m_ip
    private m_login
    private m_password
    private m_port

    sub class_initialize()
    end sub
    
    public property let ip(p_ip) m_ip = p_ip end property
    public property let port(p_port) m_port = p_port end property
    public property let login(p_login) m_login = p_login end property
    public property let password(p_password) m_password = p_password end property

    public function send(path, filename)
        send = true
        scriptname = guid.tostring
        'filesystem
        set filesystem = server.createobject("scripting.filesystemobject")
        'script_file
        script_filename = path & "bat\script_" & scriptname & ".txt"
        set script_file = filesystem.createtextfile(script_filename, true)
        script_file.write "open " & m_ip & vbcrlf & m_login & vbcrlf & m_password & vbcrlf & "put " & filename & vbcrlf & "close" & vbcrlf & "quit"
        script_file.close
        set ftp_fichier = nothing
        'bat_file
        bat_filename = path & "bat\bat_" & scriptname & ".bat"
        set bat_file = filesystem.createtextfile(bat_filename, true)
        bat_file_body = bat_file_body & "cmd /c" & vbcrlf
        bat_file_body = "ftp -i -s:" & script_filename & vbcrlf & "exit"
        bat_file.write bat_file_body
        bat_file.close
        set bat_file = nothing
        set filesystem = nothing
        set shell = server.createobject("wscript.shell")
        shell.run bat_filename, 0, false
        set shell = nothing
    end function

    sub class_terminate()
        set shell = nothing
    end sub
    
end class
%>