function starttimer(endDate, increment, start) {
    if (start) {
        var timer = setInterval(function() {
            let now = new Date().getTime();
            var x = ((now - endDate) / 1000);
            let t = increment + ((now - endDate) / 1000);
            if (t >= 0) {
                let hours = Math.floor((t % (60 * 60 * 24)) / (60 * 60));
                let mins = Math.floor((t % (60 * 60)) / (60));
                let secs = Math.floor((t % (60)));
                document.getElementById('hours').innerHTML = ('0' + hours).slice(-2);
                document.getElementById('minutes').innerHTML = ('0' + mins).slice(-2);
                document.getElementById('seconds').innerHTML = ('0' + secs).slice(-2);
            }
        }, 1000);
    }
    else{
        let hours = Math.floor((increment % (60 * 60 * 24)) / (60 * 60));
        let mins = Math.floor((increment % (60 * 60)) / (60));
        let secs = Math.floor((increment % (60)));
        document.getElementById('hours').innerHTML = ('0' + hours).slice(-2);
        document.getElementById('minutes').innerHTML = ('0' + mins).slice(-2);
        document.getElementById('seconds').innerHTML = ('0' + secs).slice(-2);
    }
}