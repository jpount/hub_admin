$(function () {
    $(document).ready(function() {
        Highcharts.setOptions({
            global: {
                useUTC: false
            }
        });

        var chart_002_cassie = new Highcharts.Chart({
            chart: {
                renderTo: 'container2Cassie',
                animation: Highcharts.svg, // don't animate in old IE
                type:'spline',
                marginRight: 10
            },
            title: {
                text: 'Pacs002 - Database'
            },
            xAxis: {
                type: 'datetime',
                tickPixelInterval: 150
            },
            yAxis: {
                title: {
                    text: 'No of Pacs002'
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },
            tooltip: {
                formatter: function() {
                        return '<b>'+ this.series.name +'</b><br/>'+
                        Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) +'<br/>'+
                        Highcharts.numberFormat(this.y, 2);
                }
            },
            legend: {
                enabled: false
            },
            exporting: {
                enabled: false
            },
            series: [{
                name: 'Random data',
                data: (function() {
                    // generate an array of random data
                    var data = [],
                        time = (new Date()).getTime(),
                        i;

                    for (i = -19; i <= 0; i++) {
                        data.push({
                            x: time + i * 1000,
                            y: 0
                        });
                    }
                    return data;
                })()
            }]
        });

        var chart_002_in = new Highcharts.Chart({
            chart: {
                renderTo: 'container2In',
                animation: Highcharts.svg, // don't animate in old IE
                type:'spline',
                marginRight: 10
            },
            title: {
                text: 'Pacs002 - Messages In'
            },
            xAxis: {
                type: 'datetime',
                tickPixelInterval: 150
            },
            yAxis: {
                title: {
                    text: 'No of Pacs002'
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },
            tooltip: {
                formatter: function() {
                    return '<b>'+ this.series.name +'</b><br/>'+
                        Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) +'<br/>'+
                        Highcharts.numberFormat(this.y, 2);
                }
            },
            legend: {
                enabled: false
            },
            exporting: {
                enabled: false
            },
            series: [{
                name: 'Random data',
                data: (function() {
                    // generate an array of random data
                    var data = [],
                        time = (new Date()).getTime(),
                        i;

                    for (i = -19; i <= 0; i++) {
                        data.push({
                            x: time + i * 1000,
                            y: 0
                        });
                    }
                    return data;
                })()
            }]
        });

        var chart_002_errors = new Highcharts.Chart({
            chart: {
                renderTo: 'container2Errors',
                animation: Highcharts.svg, // don't animate in old IE
                type:'spline',
                marginRight: 10
            },
            title: {
                text: 'Pacs002 - Errors'
            },
            xAxis: {
                type: 'datetime',
                tickPixelInterval: 150
            },
            yAxis: {
                title: {
                    text: 'No of Pacs002'
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },
            tooltip: {
                formatter: function() {
                    return '<b>'+ this.series.name +'</b><br/>'+
                        Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) +'<br/>'+
                        Highcharts.numberFormat(this.y, 2);
                }
            },
            legend: {
                enabled: false
            },
            exporting: {
                enabled: false
            },
            series: [{
                name: 'Random data',
                data: (function() {
                    // generate an array of random data
                    var data = [],
                        time = (new Date()).getTime(),
                        i;

                    for (i = -19; i <= 0; i++) {
                        data.push({
                            x: time + i * 1000,
                            y: 0
                        });
                    }
                    return data;
                })()
            }]
        });

        var chart_002_out = new Highcharts.Chart({
            chart: {
                renderTo: 'container2Out',
                animation: Highcharts.svg, // don't animate in old IE
                type:'spline',
                marginRight: 10
            },
            title: {
                text: 'Pacs002 - Messages Out'
            },
            xAxis: {
                type: 'datetime',
                tickPixelInterval: 150
            },
            yAxis: {
                title: {
                    text: 'No of Pacs002'
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },
            tooltip: {
                formatter: function() {
                    return '<b>'+ this.series.name +'</b><br/>'+
                        Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) +'<br/>'+
                        Highcharts.numberFormat(this.y, 2);
                }
            },
            legend: {
                enabled: false
            },
            exporting: {
                enabled: false
            },
            series: [{
                name: 'Random data',
                data: (function() {
                    // generate an array of random data
                    var data = [],
                        time = (new Date()).getTime(),
                        i;

                    for (i = -19; i <= 0; i++) {
                        data.push({
                            x: time + i * 1000,
                            y: 0
                        });
                    }
                    return data;
                })()
            }]
        });

        // Load the data
        var series2Cassie = chart_002_cassie.series[0];
        var series2In = chart_002_in.series[0];
        var series2Out = chart_002_out.series[0];
        var series2Errors = chart_002_errors.series[0];
        setInterval(function() {
            $.ajax({
                url: "/admin/stats.json?topology=PaymentPacs002",
                context: document.body
            }).done(function(data) {
                    var x = (new Date()).getTime(); // current time
                    var cy = data.cassie_total;
                    var ci = data.kafka_spout_total;
                    var co = data.kafka_out_total;
                    var ce = data.errors_total;
                    series2Cassie.addPoint([x, cy], true, true);
                    series2In.addPoint([x, ci], true, true);
                    series2Out.addPoint([x, co], true, true);
                    series2Errors.addPoint([x, ce], true, true);
                    console.log(data);
                });
        }, 5000);

    });

});

$(function () {
    $(document).ready(function() {
        Highcharts.setOptions({
            global: {
                useUTC: false
            }
        });

        var chart_008_cassie = new Highcharts.Chart({
            chart: {
                renderTo: 'container8Cassie',
                type: 'spline',
                animation: Highcharts.svg, // don't animate in old IE
                marginRight: 10
            },
            title: {
                text: 'Pacs008 - Database'
            },
            xAxis: {
                type: 'datetime',
                tickPixelInterval: 150
            },
            yAxis: {
                title: {
                    text: 'No of Pacs008'
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },
            tooltip: {
                formatter: function() {
                        return '<b>'+ this.series.name +'</b><br/>'+
                        Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) +'<br/>'+
                        Highcharts.numberFormat(this.y, 2);
                }
            },
            legend: {
                enabled: false
            },
            exporting: {
                enabled: false
            },
            series: [{
                name: 'Random data',
                data: (function() {
                    // generate an array of random data
                    var data = [],
                        time = (new Date()).getTime(),
                        i;

                    for (i = -19; i <= 0; i++) {
                        data.push({
                            x: time + i * 1000,
                            y: 0
                        });
                    }
                    return data;
                })()
            }]
        });

        var chart_008_in = new Highcharts.Chart({
            chart: {
                renderTo: 'container8In',
                animation: Highcharts.svg, // don't animate in old IE
                type:'spline',
                marginRight: 10
            },
            title: {
                text: 'Pacs008 - Messages In'
            },
            xAxis: {
                type: 'datetime',
                tickPixelInterval: 150
            },
            yAxis: {
                title: {
                    text: 'No of Pacs008'
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },
            tooltip: {
                formatter: function() {
                    return '<b>'+ this.series.name +'</b><br/>'+
                        Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) +'<br/>'+
                        Highcharts.numberFormat(this.y, 2);
                }
            },
            legend: {
                enabled: false
            },
            exporting: {
                enabled: false
            },
            series: [{
                name: 'Random data',
                data: (function() {
                    // generate an array of random data
                    var data = [],
                        time = (new Date()).getTime(),
                        i;

                    for (i = -19; i <= 0; i++) {
                        data.push({
                            x: time + i * 1000,
                            y: 0
                        });
                    }
                    return data;
                })()
            }]
        });

        var chart_008_errors = new Highcharts.Chart({
            chart: {
                renderTo: 'container8Errors',
                animation: Highcharts.svg, // don't animate in old IE
                type:'spline',
                marginRight: 10
            },
            title: {
                text: 'Pacs008 - Errors'
            },
            xAxis: {
                type: 'datetime',
                tickPixelInterval: 150
            },
            yAxis: {
                title: {
                    text: 'No of Pacs008'
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },
            tooltip: {
                formatter: function() {
                    return '<b>'+ this.series.name +'</b><br/>'+
                        Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) +'<br/>'+
                        Highcharts.numberFormat(this.y, 2);
                }
            },
            legend: {
                enabled: false
            },
            exporting: {
                enabled: false
            },
            series: [{
                name: 'Random data',
                data: (function() {
                    // generate an array of random data
                    var data = [],
                        time = (new Date()).getTime(),
                        i;

                    for (i = -19; i <= 0; i++) {
                        data.push({
                            x: time + i * 1000,
                            y: 0
                        });
                    }
                    return data;
                })()
            }]
        });

        var chart_008_out = new Highcharts.Chart({
            chart: {
                renderTo: 'container8Out',
                animation: Highcharts.svg, // don't animate in old IE
                type:'spline',
                marginRight: 10
            },
            title: {
                text: 'Pacs008 - Messages Out'
            },
            xAxis: {
                type: 'datetime',
                tickPixelInterval: 150
            },
            yAxis: {
                title: {
                    text: 'No of Pacs008'
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },
            tooltip: {
                formatter: function() {
                    return '<b>'+ this.series.name +'</b><br/>'+
                        Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) +'<br/>'+
                        Highcharts.numberFormat(this.y, 2);
                }
            },
            legend: {
                enabled: false
            },
            exporting: {
                enabled: false
            },
            series: [{
                name: 'Random data',
                data: (function() {
                    // generate an array of random data
                    var data = [],
                        time = (new Date()).getTime(),
                        i;

                    for (i = -19; i <= 0; i++) {
                        data.push({
                            x: time + i * 1000,
                            y: 0
                        });
                    }
                    return data;
                })()
            }]
        });

        // Load the data
        var series8Cassie = chart_008_cassie.series[0];
        var series8In = chart_008_in.series[0];
        var series8Out = chart_008_out.series[0];
        var series8Errors = chart_008_errors.series[0];
        setInterval(function() {
            $.ajax({
                url: "/admin/stats.json?topology=PaymentPacs008",
                context: document.body
            }).done(function(data) {
                    var x = (new Date()).getTime(); // current time
                    var cy = data.cassie_total;
                    var ci = data.kafka_spout_total;
                    var co = data.kafka_out_total;
                    var ce = data.errors_total;
                    series8Cassie.addPoint([x, cy], true, true);
                    series8In.addPoint([x, ci], true, true);
                    series8Out.addPoint([x, co], true, true);
                    series8Errors.addPoint([x, ce], true, true);
                    console.log(data);
                });
        }, 5000);



    });

});
