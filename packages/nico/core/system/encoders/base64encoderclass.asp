<%
class base64encoderclass
    
    Function encode(p_value)
        dim xml, node
        Set xml = server.createobject("Msxml2.DOMDocument.3.0")
        Set node = xml.CreateElement("base64")
        node.dataType = "bin.base64"
        node.nodeTypedValue = stream_stringtobinary(p_value)
        encode = node.text
        Set node = Nothing
        Set xml = Nothing
    End Function
 
    Function decode(byval p_code)
        dim xml, node
        Set xml = server.createobject("Msxml2.DOMDocument.3.0")
        Set node = xml.CreateElement("base64")
        node.dataType = "bin.base64"
        node.text = p_code
        decode = stream_binarytostring(node.nodeTypedValue)
        Set node = Nothing
        Set xml = Nothing
    End Function
 
    private Function stream_stringtobinary(p_value)
        dim binarystream
        Set binarystream = server.createobject("adodb.stream")
        binarystream.type = 2
        binarystream.charset = "us-ascii"
        binarystream.Open
        binarystream.writeText p_value
        binarystream.position = 0
        binarystream.type = 1
        stream_stringtobinary = binarystream.read
        Set binarystream = Nothing
    End Function
 
    private Function stream_binarytostring(p_binary)
        dim binarystream
        set binarystream = server.createobject("adodb.stream")
        binarystream.type = 1
        binarystream.Open
        binarystream.write p_binary
        binarystream.position = 0
        binarystream.type = 2
        binarystream.charset = "us-ascii"
        stream_binarytostring = binarystream.ReadText
        Set binarystream = Nothing
    End Function
end class
%>