<%
class accountserviceclass
    private m_db
    private m_errors
    
    public property let db(p_db) set m_db = p_db end property
    public property let errors(p_errors) set m_errors = p_errors end property

    ' utilisateur début access
    public function startaccess()
        if not isempty(cookies("utilisateur_id")) then
            if not m_db.entity("utilisateur").query("utilisateur_id = " & cookies("utilisateur_id"))("utilisateur_ignoreacces") then
                set utilisateuracces = m_db.entity("utilisateuracces").query("cast(utilisateuracces_debut as date) = cast(getdate() as date) and utilisateur_id = " & cookies("utilisateur_id"))
                if utilisateuracces.eof then
                    set utilisateuracces = m_db.entity("utilisateuracces").create
                    utilisateuracces("utilisateuracces_debut") = now
                    utilisateuracces("utilisateur_id") = cookies("utilisateur_id")
                    utilisateuracces.update
                end if
            end if
        end if
    end function
    
    ' utilisateur fin access
    public function endaccess()
        if not isempty(cookies("utilisateur_id")) then
            if not m_db.entity("utilisateur").query("utilisateur_id = " & cookies("utilisateur_id"))("utilisateur_ignoreacces") then
                set utilisateuracces = m_db.entity("utilisateuracces").query("cast(utilisateuracces_debut as date) = cast(getdate() as date) and utilisateur_id = " & cookies("utilisateur_id"))
                if not utilisateuracces.eof then
                    utilisateuracces("utilisateuracces_fin") = now
                    utilisateuracces("utilisateur_id") = cookies("utilisateur_id")
                    utilisateuracces.update
                end if
            end if
        end if
    end function

    ' modification préférence
    public function modifierpreferences()
        modifierpreferences = false
        set utilisateur = getidentity
	    m_db.entity("utilisateur").automap utilisateur, form
        if m_errors.count = 0 then
            utilisateur.update
            set utilisateur = m_db.entity("utilisateur").join("theme on theme_id=utilisateur_theme").query("utilisateur_id="& utilisateur("utilisateur_id"))
            writecookies utilisateur
            modifierpreferences = true
	    end if
    end function

    ' création utilisateur / saisie mot de passe
    public function creerutilisateur(utilisateur, data)
        creerutilisateur = false
	    if m_db.entity("utilisateur").automap(utilisateur, data) then
            utilisateur("utilisateur_motdepasse") = cryptography.HashBytes(data("utilisateur_motdepasse"))
            utilisateur.update
            creerutilisateur = true
	    end if
    end function

    'modifier mot de passe
    public function modifiermotdepasse(utilisateur_id, utilisateur_motdepasse, utilisateur_motdepasse_confirmation)
        dim utilisateur
        modifiermotdepasse = true
        if utilisateur_motdepasse <> utilisateur_motdepasse_confirmation then
            modifiermotdepasse = false
            exit function
        end if
        set utilisateur = m_db.entity("utilisateur").query("utilisateur_id = " & utilisateur_id)
        utilisateur("utilisateur_motdepasse") = cryptography.HashBytes(utilisateur_motdepasse)
        utilisateur.update
    end function

    ' modifier utilisateur
    public function modifierutilisateur(utilisateur, data)
        modifierutilisateur = false
	    if m_db.entity("utilisateur").automap(utilisateur, data) then
            utilisateur.update
            modifierutilisateur = true
	    end if
    end function

    'cookies utilisateur
    private sub writecookies(utilisateur)
        cookieshandler.add "utilisateur_id", utilisateur("utilisateur_id")
        cookieshandler.add "utilisateur_societe", utilisateur("utilisateur_societe")
        cookieshandler.add "utilisateur_nom", utilisateur("utilisateur_nom")
        cookieshandler.add "utilisateur_prenom", utilisateur("utilisateur_prenom")
        cookieshandler.add "utilisateur_email", utilisateur("utilisateur_email")
        cookieshandler.add "utilisateur_pagesize", utilisateur("utilisateur_pagesize")
        cookieshandler.add "utilisateur_signature", utilisateur("utilisateur_signature")
        if not isnull(utilisateur("utilisateur_theme")) then
            set theme = m_db.entity("theme").query("theme_id = " & utilisateur("utilisateur_theme"))
            cookieshandler.add "theme_fichier", theme("theme_fichier")
        end if
    end sub

    public function getidentity()
        set getidentity = m_db.entity("utilisateur").query("utilisateur_id = " & cookies("utilisateur_id"))
    end function

    '1resetpassword
    public function resetpassword(utilisateur_email, utilisateur_ip)
        dim utilisateur, mailclient, mailmessage, errors
        set utilisateur = m_db.entity("utilisateur").query("utilisateur_email = '" & utilisateur_email & "'")
        if utilisateur.eof then
            m_errors("resetpassword") = "invalid"
            exit function
        end if
        utilisateur_motdepasse = passwordmanager.generate
        utilisateur("utilisateur_motdepasse") = cryptography.hashbytes(utilisateur_motdepasse)
        utilisateur.update
        set mailclient = mailservice.newmailserver
        set mailmessage = mailservice.newmessagefromuri("Votre nouveau message", config("current")("applicationurl") & "/wwwroot/email/views/account/resetpassword.asp?utilisateur_id=" & utilisateur("utilisateur_id") & "&utilisateur_motdepasse=" & utilisateur_motdepasse)
	    mailmessage.recipients.add utilisateur("utilisateur_email")
	    mailmessage.recipients.add "support@security.fr"
        mailclient.send mailmessage
    end function


    '1identification
    public function logwithemail(utilisateur_email, utilisateur_motdepasse)
        set utilisateur = m_db.entity("utilisateur").join("theme on theme_id=utilisateur_theme").query("utilisateur_ouvert = 1 and utilisateur_email = '" & utilisateur_email & "' and utilisateur_motdepasse = convert(nvarchar(32), hashbytes('MD5', '" & utilisateur_motdepasse & "'), 2)")
        if utilisateur.eof then
            m_errors("logwithemail") = "invalid"
            exit function
        end if
        if utilisateur("utilisateur_protectionip") then
            set utilisateurip = m_db.entity("utilisateurip").query("utilisateurip_actif = 1 and utilisateurip_nom = '" & ServerVariables("remote_addr") & "'")
            if utilisateurip.eof then
            m_errors("utilisateur_protectionip")="invalid"
            exit function
            end if
        end if
        if m_errors.count = 0 then
            set utilisateurroles = m_db.entity("utilisateurrole").query("utilisateurrole_utilisateur = " & utilisateur("utilisateur_id"))
            do while not utilisateurroles.eof
                utilisateur_roles = utilisateur_roles & utilisateurroles("utilisateurrole_role") & "$"
                utilisateurroles.movenext
            loop
            if not isempty(utilisateur_roles) then
                utilisateur_roles = "$" & utilisateur_roles
            end if
            cookieshandler.add "utilisateur_roles", utilisateur_roles
            writecookies utilisateur
        end if
    end function

    'loginwithid
    public function loginwithid(utilisateur_id)
        set utilisateur = m_db.entity("utilisateur").join("theme on theme_id=utilisateur_theme").query("utilisateur_id = " & utilisateur_id)
        if utilisateur.eof then
            m_errors("loginwithid")="invalid"
            exit function
        elseif isnull(utilisateur("utilisateur_email")) then
            m_errors("loginwithid") = "invalid"
            exit function
        end if
        if m_errors.count = 0 then
            set utilisateurroles = m_db.entity("utilisateurrole").query("utilisateurrole_utilisateur = " & utilisateur("utilisateur_id"))
            do while not utilisateurroles.eof
                utilisateur_roles = utilisateur_roles & utilisateurroles("utilisateurrole_role") & "$"
                utilisateurroles.movenext
            loop
            if not isempty(utilisateur_roles) then
                utilisateur_roles = "$" & utilisateur_roles
            end if
            cookieshandler.add "utilisateur_roles", utilisateur_roles
            writecookies utilisateur
        end if
    end function


    'findthemes
    public function findthemes(data)
        set findthemes = m_db.entity("theme").find(data)
    end function

    'getthemes
    public function getthemes()
        set getthemes = m_db.entity("theme").query(empty)
    end function
    
    'gettheme
    public function gettheme(theme_id)
        set gettheme = m_db.entity("theme").query("theme_id = " & theme_id)
    end function
    
    'trygettheme
    public function trygettheme(theme_id)
        dim theme
        if isempty(theme_id) then
            set theme = m_db.entity("theme").create
        else
            set theme = m_db.entity("theme").query("theme_id = " & theme_id)
        end if
        set trygettheme = theme
    end function

    'canedittheme
	public function canedittheme(theme_id)
        canedittheme = true
	end function

    'edittheme
	public function edittheme(theme_id, data)
        dim theme
        if isempty(theme_id) then
            set theme = m_db.entity("theme").create
        else
            set theme = m_db.entity("theme").query("theme_id = " & theme_id)
        end if
        m_db.entity("theme").automap theme, data
        if m_errors.count = 0 then
            theme.update
        end if
        edittheme = theme("theme_id")
	end function

    'candeletetheme
	public function candeletetheme(theme_id)
        set candeletetheme = true
	end function

    'deletetheme
	public function deletetheme(theme_id)
        m_db.entity("theme").delete("theme_id = " & theme_id)
	end function

    'findutilisateuraccess
    public function findutilisateuraccess(data)
        set findutilisateuraccess = m_db.entity("utilisateuracces_liste").find(data)
    end function

    'getutilisateuraccess
    public function getutilisateuraccess()
        set getutilisateuraccess = m_db.entity("utilisateuracces").query(empty)
    end function
    
    'getutilisateuracces
    public function getutilisateuracces(utilisateuracces_id)
        set getutilisateuracces = m_db.entity("utilisateuracces").query("utilisateuracces_id = " & utilisateuracces_id)
    end function
    
    'trygetutilisateuracces
    public function trygetutilisateuracces(utilisateuracces_id)
        dim utilisateuracces
        if isempty(utilisateuracces_id) then
            set utilisateuracces = m_db.entity("utilisateuracces").create
        else
            set utilisateuracces = m_db.entity("utilisateuracces").query("utilisateuracces_id = " & utilisateuracces_id)
        end if
        set trygetutilisateuracces = utilisateuracces
    end function

    'caneditutilisateuracces
	public function caneditutilisateuracces(utilisateuracces_id)
        caneditutilisateuracces = true
	end function

    'editutilisateuracces
	public function editutilisateuracces(utilisateuracces_id, data)
        dim utilisateuracces
        if isempty(utilisateuracces_id) then
            set utilisateuracces = m_db.entity("utilisateuracces").create
        else
            set utilisateuracces = m_db.entity("utilisateuracces").query("utilisateuracces_id = " & utilisateuracces_id)
        end if
        m_db.entity("utilisateuracces").automap utilisateuracces, data
        if m_errors.count = 0 then
            utilisateuracces.update
        end if
        editutilisateuracces = utilisateuracces("utilisateuracces_id")
	end function

    'candeleteutilisateuracces
	public function candeleteutilisateuracces(utilisateuracces_id)
        set candeleteutilisateuracces = true
	end function

    'deleteutilisateuracces
	public function deleteutilisateuracces(utilisateuracces_id)
        m_db.entity("utilisateuracces").delete("utilisateuracces_id = " & utilisateuracces_id)
	end function

    'checkroles
    public function checkroles(p_roles)
        if not inroles(p_roles) then
            redirect config("login_page")
        end if
    end function

    'checkroles
    public function inrole(p_role)
        inrole = instr(cstr(request.cookies("utilisateur_roles")), "$" & p_role & "$") <> 0
    end function

    'checkroles
    public function inroles(p_roles)
        dim roles
        roles = split(p_roles, ",")
        for each r in roles
            if inrole(r) then
                inroles = true
                exit function
            end if
        next
        inroles = false
    end function

end class
%>