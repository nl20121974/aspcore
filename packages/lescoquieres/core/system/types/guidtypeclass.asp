<%
class guidtypeclass

	private m_size

	sub class_initialize()
		m_size = 36
	end sub

	public function size(p_size) m_size = p_size : set size = me : end function
	
    public default function tostring()
	    set typelib = server.createobject("scriptlet.typelib")
	    tostring = mid(server.createobject("scriptlet.typelib").guid, 2, m_size)
	    set typelib = nothing
    end function

end class
%>
