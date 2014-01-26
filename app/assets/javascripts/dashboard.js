$(function () {

    // Load the data
    setInterval(function() {
           $.ajax({
               url: "/dashboard/api_metrics.js",
               context: document.body,
               dataType : 'html'
           }).done(function(data) {
                $('#api_metrics').html(data);
           });
    }, 4000);

    setInterval(function() {
        $.ajax({
            url: "/dashboard/lb_metrics.js",
            context: document.body,
            dataType : 'html'
        }).done(function(data) {
                $('#lb_metrics').html(data);
            });
    }, 5000);

    setInterval(function() {
        $.ajax({
            url: "/dashboard/fi_metrics.js",
            context: document.body,
            dataType : 'html'
        }).done(function(data) {
                $('#fi_metrics').html(data);
            });
    }, 6000);

});
