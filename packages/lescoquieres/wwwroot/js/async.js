    function register_async(viewname, formname, url, method) {
        $(document).ready(function(){
            get_async(viewname, formname, url, method);
        });
    }
    function send_data(viewname, formname, url, method) {
        var container = $('#' + formname);
        var form = container.find('form');
        var form_data = form.serialize();
        $.ajax({
            type: form.attr("method"),
            url: url,
            data: form_data,
            success: function(data) {
                $('#' + viewname).html(data);
                if (formname !== undefined)
                    send_async(viewname, formname, url, method);
                async_js();
            },
            error: function() {
                alert('send_async error for view ' + viewname + 'with url : ' + url + ', data: ' + form_data);
            }
        });
    }
    function send_async(viewname, formname, url, method) {
        var container = $('#' + formname);
        var form = container.find('form');
        //form.submit(function(event) {
            //event.preventDefault();
            //send_data(viewname, formname, url, method);
        //});
        form.find(':input').change(function(){
            var container = $('#' + formname);
            var form = container.find('form');
            var form_data = form.serialize();
            $.ajax({
                type: form.attr("method"),
                url: url,
                data: form_data,
                success: function(data) {
                    $('#' + viewname).html(data);
                    if (formname !== undefined)
                        send_async(viewname, formname, url, method);
                    async_js();
                },
                error: function() {
                    alert('send_async error for view ' + viewname + 'with url : ' + url + ', data: ' + form_data);
                }
            });
        });
    }
    function get_async(viewname, formname, url, method) {
        $.ajax({
            type: 'GET',
            url: url,
            success: function(data) {
                $('#' + viewname).html(data);
                async_js();
                if (method !== undefined)
                    send_async(viewname, formname, url, method);
            },
            error: function() {
                alert('get_async error for view ' + viewname + 'with url : ' + url);
            }
        });
    }