<%
class modehandlerclass

    function handle()
        if request.querystring("mode") <> "" then
            if request.querystring("mode") = "debug" then
                response.cookies("mode") = "debug"
            elseif request.querystring("mode") = "normal" then
                response.cookies("mode") = ""
            end if
            for each k in request.querystring
                if k <> "mode" then
                    params = params & "&" & k & "=" & request.querystring(k)
                end if
            next
            if not isempty(params) then
                response.redirect "?" & right(params, len(params) - 1)
            else
                response.redirect "?"
            end if
        end if
    end function

end class
%>