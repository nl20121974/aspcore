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

$(document).ready(function () {
    $('.w3-dropdown-click').each(function () {
        $(this).focusout(function () {
            $(this).children('.w3-dropdown-content').removeClass('w3-show');
        });
        $(this).click(function () {
            $(this).children('.w3-dropdown-content').toggleClass('w3-show');
        });
    });
});
function async_js() {
    $('.w3-accordion-click').each(function () {
        $(this).unbind();
        $(this).click(function () {
            var test = $(this).next('.w3-accordion-content');
            $(this).nextAll('.w3-accordion-content:first').toggleClass('w3-hide');
        });
    });
}
$(document).ready(function () {
    async_js();
});
function afficher_aide(aide_id) {
    $('#aide_corps').load('/aide/details?aide_id=' + aide_id, function () {
        document.getElementById('aide_modal').style.display = 'block';
    });
}

function getDate(data) {
    return check_digits(data.getDate()) + "/" + check_digits(data.getMonth()) + "/" + check_digits(data.getFullYear());
}

function getTime(data) {
    return check_digits(data.getHours()) + "H" + check_digits(data.getMinutes());
}
function check_digits(i) {
    if (i < 10) {
        i = "0" + i;
    }
    return i;
}
function getCookie(cname) {
    var name = cname + "=";
    var decodedCookie = decodeURIComponent(document.cookie);
    var ca = decodedCookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}
function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}
function urlencodeFormData(fd){
    var params = new URLSearchParams();
    for(var pair of fd.entries()){
        typeof pair[1]=='string' && params.append(pair[0], pair[1]);
    }
    return params.toString();
}