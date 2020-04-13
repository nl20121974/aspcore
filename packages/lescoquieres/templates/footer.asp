
                </div>
                <% if sectionexists("commandbar") then %>
                <div class="w3-col m2 w3-right w3-hide-small">
                    <div class="w3-container w3-padding-top">
                        <div class="w3-bar-block">
                            <% on error resume next %>
                            <% commandbar %>
                            <% on error goto 0 %>
                            <!--#include virtual="/templates/helpbar.asp"-->
                        </div>
                    </div>
                </div>
                <% end if %>
            </div>
        </div>
      </div>
      <% debugger.writetime %>
      <% if isempty(querystring("edition")) then %>
      <script src="/wwwroot/js/jquery-3.3.1.min.js"></script>
      <script src="/wwwroot/js/ckeditor/ckeditor.js"></script>
      <script src="/wwwroot/js/ckuploadadapter.js"></script>
      <script src="/wwwroot/js/site.js"></script>
      <script src="/wwwroot/js/async.js"></script>
      <script type="text/javascript">
          $(document).ready(function () {
              useclassiceditor();
          });
      </script>
      <% if sectionexists("scripts") then %>
      <% scripts %>
      <% end if %>
      <% end if %>
    <script>
    </script>
</body>
</html>