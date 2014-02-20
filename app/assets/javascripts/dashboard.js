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
    }, 3000);

    setInterval(function() {
        $.ajax({
            url: "/dashboard/fi_metrics.js",
            context: document.body,
            dataType : 'html'
        }).done(function(data) {
                $('#fi_metrics').html(data);
            });
    }, 3000);

    setInterval(function() {
        $.ajax({
            url: "/dashboard/dashboard_counts.js",
            context: document.body,
            dataType : 'html'
        }).done(function(data) {
                $('#dashboard_counts').html(data);
            });
    }, 3000);

});
