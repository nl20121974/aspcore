<%
class httphelperclass

    public function mapcookiestoquerystring(p_key)
        cookie = ubound(split(cookies(p_key), "&"))
        for i = 0 to cookie
            cookieentry = split(cookie, "=")
            querystring(cookieentry(0)) = cookieentry(1)
        next
    end function

end class
%>