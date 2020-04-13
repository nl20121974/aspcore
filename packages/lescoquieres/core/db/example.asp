<%
'sum
set clients = db.entity("client") 'dbentity
client.top(100).desc("client_ca").where("client_nom like 'sandro'") 'dbentity
client.top(100).desc("client_ca").query("client_nom like 'sandro'") 'adodb.recordset

client.top(100).desc("client_ca").where("client_nom like 'sandro'").query(empty) 'adodb.recordset
client.top(100).desc("client_ca").query("client_nom like 'sandro'") 'adodb.recordset
client.top(100).desc("client_ca").where("client_nom like 'sandro'").query("client_nom like 'sandro'") 'adodb.recordset

client.top(100).desc("client_ca").where("client_nom like 'sandro'") 'dbentity
client.top(100).desc("client_ca").query("client_nom like 'sandro'") 'adodb.recordset

client.top(100).desc("client_ca").where("societe_id = " & cookies("societe")).filter(querystring) 'dbentity
client.top(100).desc("client_ca").where("societe_id = " & cookies("societe")).find(querystring) 'adodb.recordset
client.top(100).desc("client_ca").where("societe_id = " & cookies("societe")).filter(querystring).sort(querystring).query(empty) 'adodb.recordset

'sum
set clients = db.entity("client") 'dbentity
client.top(100).where("client_nom like 'sandro'").sum("client_ca") 'float

'max
set clients = db.entity("client") 'dbentity
client.top(100).where("client_nom like 'sandro'").max("client_ca") 'float, int, nvarchar

'count
set client = db.entity("client") 'dbentity
client.count("client_nom like 'nicolas'") 'int

'has
if db.entity("client").has("client_nom = 'nicolas'") then
    response.write "ok"
end if

'query
set client = db.entity("client") 'dbentity
client.query("client_nom = 'richard'") 'adodb.recordset

'create
set client = db.entity("client") 'dbentity
client.create 'adodb.recordset

'find
set client = db.entity("client") 'dbentity
client.find(querystring) 'adodb.recordset

'filter, find
querystring("client_nom") = "nico"
querystring("order") = "client_id"
set client = db.entity("client").filter(querystring).sort(querystring) 'dbentity

%>