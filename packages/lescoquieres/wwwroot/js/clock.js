$(document).ready(function () {
    var $dOut = $('#date'),
        $hOut = $('#hours'),
        $mOut = $('#minutes'),
        $sOut = $('#seconds'),
        $ampmOut = $('#ampm');
    var months = ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Decembre'];
    var days = ['Dimanche', 'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi'];
    function update() {
        var date = new Date();
        var hours = formatdigit(date.getHours());
        var minutes = formatdigit(date.getMinutes());
        var seconds = formatdigit(date.getSeconds());
        var dayOfWeek = days[date.getDay()];
        var month = months[date.getMonth()];
        var day = date.getDate();
        var year = date.getFullYear();
        var dateString = dayOfWeek + ' ' + day + ' ' + month;
        $dOut.text(dateString);
        $hOut.text(hours);
        $mOut.text(minutes);
        $sOut.text(seconds);
        //$ampmOut.text(ampm);
    }
    function formatdigit(unit) {
        return unit < 10 ? '0' + unit : unit;
    }

    update();
    window.setInterval(update, 1000);
});