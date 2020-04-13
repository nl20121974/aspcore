<%
class errorserviceclass

    private m_db
    private m_errors
    
    public property let db(p_db) set m_db = p_db end property
    public property let errors(p_errors) set m_errors = p_errors end property

    function loginfo(p_info, p_message, p_type)
        dim error
        set error = m_db.entity("error").create
        error("error_form") = cstr(request.form)
        error("error_querystring") = cstr(request.querystring)
        if not isempty(cookies("utilisateur")) then
            error("utilisateur_id") = cookies("utilisateur_id")
        end if
        error("error_message") = p_message
        error("error_info") = p_info
        error("errortype_id") = p_type
        error("error_https") = not (servervariables("HTTPS") = "OFF")
        error("error_domain") = servervariables("server_name")
        error("error_scriptname") = servervariables("script_name")
        error("error_url") = servervariables("HTTP_X_ORIGINAL_URL")
        error("error_referer") = servervariables("http_referer")
        error.update
        error.close
        set error = nothing
    end function

    function logerror(p_err, p_info, p_type)
        dim error
        logerror = cdbl(p_err.number)
        if logerror <> 0 then
            set error = m_db.entity("error").create
            error("error_form") = cstr(request.form)
            error("error_querystring") = cstr(request.querystring)
            if not isempty(cookies("utilisateur")) then
                error("utilisateur_id") = cookies("utilisateur")("utilisateur_id")
                error("cabinet_id") = cookies("utilisateur")("cabinet_id")
            end if
            error("error_message") = p_err.description
            error("error_info") = p_info
            error("errortype_id") = p_type
            error("error_https") = not (servervariables("HTTPS") = "OFF")
            error("error_domain") = servervariables("server_name")
            error("error_scriptname") = servervariables("script_name")
            error("error_url") = servervariables("HTTP_X_ORIGINAL_URL")
            error("error_referer") = servervariables("http_referer")
            error.update
            error.close
            set error = nothing
        end if
    end function

end class
%>