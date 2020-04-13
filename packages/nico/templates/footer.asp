
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
    <script>
      function w3_open() {
        document.getElementById("sidebar").style.display = "block";
        document.getElementById("overlay").style.display = "block";
      }
      function w3_close() {
        document.getElementById("sidebar").style.display = "none";
        document.getElementById("overlay").style.display = "none";
      }
      function onClick(element) {
        document.getElementById("img01").src = element.src;
        document.getElementById("modal01").style.display = "block";
        var captionText = document.getElementById("caption");
        captionText.innerHTML = element.alt;
      }
    </script>
</body>
</html>