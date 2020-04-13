<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" />
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins">
<link rel="stylesheet" href="/wwwroot/css/site.css?time=<%=time %>">
<% if request.Cookies("theme_fichier") <> "" then %>
<link rel="stylesheet" href="/wwwroot/css/themes/<%=request.Cookies("theme_fichier") %>.css" />
<% else %>
<link rel="stylesheet" href="/wwwroot/css/themes/2018_f0ede5.css" />
<% end if %>
<link rel="stylesheet" href="/wwwroot/css/w3.overwrite.css?time=<%=time %>">