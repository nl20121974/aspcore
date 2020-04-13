<%
class htmlhandlerclass
    private m_errors
    private m_styles
    private m_properties

    sub class_initialize()
    end sub

    public property let errors(p_errors) set m_errors = p_errors : end property
    public property let styles(p_styles) set m_styles = p_styles : end property
    public property let properties(p_properties) set m_properties = p_properties : end property

    public function antiforgerytoken()
        set antiforgerytoken = new htmlantiforgerytokenclass
    end function

    public function caller()
        set caller = new htmlcallerclass
    end function

    public function hidden(p_name)
        set hidden = getinput(p_name, "hidden")
    end function

    public function text(p_name)
        set text = getinput(p_name, "text").css(m_styles("text"))
    end function

    public function file(p_name)
        set file = getinput(p_name, "file").css(m_styles("file"))
    end function

    public function checkbox(p_name)
        set checkbox = getinput(p_name, "checkbox").css(m_styles("checkbox"))
    end function

    public function radio(p_name)
        set radio = getinput(p_name, "radio").css(m_styles("radio"))
    end function

    public function password(p_name)
        set password = getinput(p_name, "password").css(m_styles("password"))
    end function

    public function number(p_name)
        set number = getinput(p_name, "number").css(m_styles("number"))
    end function

    public function email(p_name)
        set email = getinput(p_name, "email").css(m_styles("email"))
    end function

    public function tel(p_name)
        set tel = getinput(p_name, "tel").css(m_styles("tel"))
    end function

    public function submit(p_name)
        set submit = getinput(p_name, "submit").id(p_name).css(m_styles("submit"))
    end function

    public function tableheader(p_Columnname)
        set tableheader = (new htmltableheaderclass).Columnname(p_Columnname).icons(m_styles("icons_sort"))
    end function

    public function tablefooter(p_recordcount)
        set tablefooter = (new htmltablefooterclass).pagesize(m_properties("pagesize")).recordcount(p_recordcount).css(m_styles("table")("tablefooter"))
    end function

    public function action()
        set action = (new actionclass).action(p_Action)
    end function

    public function textarea(p_name)
        set textarea = (new htmltextareaclass).name(p_name).id(p_name).css(m_styles("textarea"))
    end function

    public function list(p_name)
        set list = (new htmllistclass).name(p_name).id(p_name).css(m_styles("list"))
    end function
    
    public function day(p_name)
        set day = getinput(p_name, "date").css(m_styles("date"))
    end function

    public function daytime(p_name)
        set daytime = getinput(p_name, "datetime-local").css(m_styles("datetime-local"))
    end function

    public function week()
        set week = new htmlweek
    end function

    public function month()
        set month = new htmlmonth
    end function

    public function year()
        set year = new htmlyear
    end function

    public function anchor(p_href)
        set anchor = (new htmlanchorclass).href(p_href)
    end function

    public function baritem(p_href)
        set baritem = (new htmlanchorclass).href(p_href).css(m_styles("baritem"))
    end function

    public function sidebaritem(p_href)
        set sidebaritem = (new htmlanchorclass).href(p_href).css(m_styles("sidebaritem"))
    end function

    public function commandbaritem(p_href)
        set commandbaritem = (new htmlanchorclass).href(p_href).css(m_styles("commandbaritem"))
    end function

    public function pagebaritem(p_href)
        set pagebaritem = (new htmlanchorclass).href(p_href).css(m_styles("pagebaritem"))
    end function

    public function button(p_name)
        set button = (new htmlanchorclass).id(p_name).name(p_name).css(m_styles("button"))
    end function
    
    public function trigger(p_id)
        set trigger = (new htmlanchorclass).onclick("$('#" & p_id & "').click()").css(m_styles("trigger"))
    end function

    public function confirm(p_href, p_message)
        set confirm = (new htmlanchorclass).href(p_href).css(m_styles("delete")).onclick("return window.confirm('" & p_message & "');")
    end function

    public function icon(p_css)
        set icon = (new htmlcontentclass).kind("i").css(p_css)
    end function

    public function span(p_content)
        set span = (new htmlcontentclass).kind("span").content(p_content)
    end function

    public function label(p_content)
        set label = (new htmlcontentclass).kind("label").content(p_content).css(m_styles("label"))
    end function

    public function h4(p_content)
        set h4 = (new htmlcontentclass).kind("h4").content(p_content).css(m_styles("h4"))
    end function

    public function h5(p_content)
        set h5 = (new htmlcontentclass).kind("h5").content(p_content).css(m_styles("h5"))
    end function

    public function h6(p_content)
        set h6 = (new htmlcontentclass).kind("h6").content(p_content).css(m_styles("h6"))
    end function

    public function var(p_content)
        set var = (new htmlcontentclass).kind("var").content(p_content).css(m_styles("var")).fallback(m_properties("fallback"))
    end function

    public function p(p_content)
        set p = (new htmlcontentclass).kind("p").content(p_content)
    end function

    public function ajax(p_id)
        set ajax = (new htmlcontentclass).id(p_id)
    end function

    public function checklist(p_name)
        set checklist = (new htmlchecklistclass).name(p_name).id(p_name).css(m_styles("checklist"))
    end function

    private function getcontent(p_name, p_kind)
        set getinput = (new htmlcontentclass).id(p_name).name(p_name).kind(p_kind)
    end function

    private function getinput(p_name, p_kind)
        set getinput = (new htmlinputclass).id(p_name).name(p_name).kind(p_kind)
    end function

    public function required()
        set required = (new htmlcontent("span")).content("*").css(m_style("required"))
    end function

    public function geterror(p_name)
        if m_errors.Exists(p_name) then
            if m_errors(p_name) = "required" then
                geterror = "Ce champ est obligatoire"
            elseif m_errors(p_name) = "invalid" then
                geterror = "Ce champ est invalide"
            end if
        end if
    end function
end class
%>
