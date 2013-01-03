//Pie chart
$(function () {
    var chart;
    $(document).ready(function() {
        chart = new Highcharts.Chart({
            chart: {
				renderTo: 'container',
				marginTop:-15,
				margin:0 ,
		backgroundColor: {
         linearGradient: [0, 0, 0, 400],
         stops: [
            [0, 'rgb(246,246,246)'],
            [1, 'rgb(223,223,223)']
         ]
      },
                },
				legend: {
			verticalAlign: 'right',
            x: 0,
            y: 174
        },
			exporting: {
    buttons: { 
        exportButton: {
            enabled:false
        },
        printButton: {
            enabled:false
        }

    }
},
            title: {
                text: ''
            },
            tooltip: {
                formatter: function() {
                    return '<b>'+ this.point.name +'</b>: '+ this.percentage +' %';
                }
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
					size:'70%',
                    cursor: 'pointer',
					cursor: 'pointer',
					events: {
                    click: function(event) {
                        document.location.href = 'Feedbacks.html'
                   
					}},
					
                   dataLabels: {
                        enabled: false,
						
                        
                    },
					showInLegend: true
                }
            },
			
            series: [{
                type: 'pie',
				name: '',
                data: [
                    { name:'Positive',
				      y:5,
					  color:'#f7d009'
					  
					  },
                    { name:'Negative',
					  y:95,
					  color:'#642168'},
                    {
                        name: 'Neutral',
                        y: 0,
                       color:'#fb9817'
						},]
            }],
	        });
    });
});

		
//bar graph begin
$(function () {
	
    var chart;
    $(document).ready(function() {
        chart = new Highcharts.Chart({
            chart: {
				
               renderTo: 'container2',
                type: 'bar',
				
		backgroundColor: {
         linearGradient: [0,0,0,400],
         stops: [
             [0, 'rgb(246,246,246)'],
            [1, 'rgb(223,223,223)']
         ]
      },
            },
			
			
            title: {
                text:''
            },
			legend:{ enabled:'true'
				
				},
				exporting: {
    buttons: { 
        exportButton: {
            enabled:false
        },
        printButton: {
            enabled:false
        }

    }
},
            xAxis: {
				max:2,
                categories: ['Service','Product','Process']
				
            },
			
			
           yAxis: {
			   min:0,
                title: {
                    text: ''
                }
            },
			
        plotOptions: {
              bar: {
			         backgroundColor: {
         linearGradient: [0, 0, 0, 400],
         stops: [
            [0, 'rgb(246,246,246)'],
            [1, 'rgb(223,223,223)']
         ]
      },
                    allowPointSelect: true,
					pointHeight:52,
                    cursor: 'pointer',
					events: {
                    click: function(event) {
                        document.location.href = 'Bargraphs.html'
                   
					}}
				    },
               
				 series: {
                    stacking: 'normal',
					borderRadius:3,
					plotBackgroundImage:'Images/2.png'
                }
            },
                series: [{
					 name: 'Neutral',
				color:'#f7d009', 
                data: [0,0,0]},
					
									{
                name: 'Negative',
				events: {
                    click: function(event) {
                        document.location.href = 'Bargraphs.html'
                    }
                },
				color:'#642168',
                data: [56,13,11]
            }, {
			name: 'Positive',
				color:'#fb9817',
                data: [0,4,0]
				
				
				
				
            }]
			
			
		
        }); 
    });
    
});//ice cream bar end



//Gauge code beginning
$(document).ready(function(e) {
$('#test').speedometer();
$('.changeSpeedometer').click(function(){
$('#test').speedometer({ percentage: $('.speedometer').val() || -1 });
});
});
//Gauge code Ending


//bar with line chart start
var chart;
$(document).ready(function() {
	chart = new Highcharts.Chart({
		chart: {
			renderTo: 'container3',
			
			backgroundColor: {
         linearGradient: [0, 0, 0, 400],
         stops: [
            [0, 'rgb(246,246,246)'],
            [1, 'rgb(223,223,223)']
         ]
      },
		},
	exporting: {
    buttons: { 
        exportButton: {
            enabled:false
        },
        printButton: {
            enabled:false
        }

    }
},
		title: {
			text: ''
		},
		
		xAxis:
		[{
			categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
				'Sat'],
				
		}],
		yAxis: [{ // Primary yAxis
			title: {
			text: ''
		},
	
			
		}, { // Secondary yAxis
			title: {
				text: '',
				style: {
					color: '#4572A7'
				}
			},
			labels: {
				formatter: function() {
					return this.value +' sms';
				},
				style: {
					color: '#4572A7'
				}
			},
			opposite: true
		}],
		tooltip: {
			formatter: function() {
				return ''+
					this.x +': '+ this.y +
					(this.series.name == 'Rainfall' ? ' sms' : 'per/day');
			}
		},
		
		legend: {
			enabled:true,
			y:10,
			x:-3,
			width:310
		},
		series: [{
			
			name: 'Feedbacks',
			color: '#00d40f',
			 cursor: 'pointer',
			type: 'column',
			yAxis: 1,
			data: [49.9,71.5,106.4,129.2,144.0,176.0]

		}, {
			name: 'Product',
			color: '#502b54',
			cursor: 'pointer',
			type: 'spline',
			data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5]
		},
		 {
			name: 'Service',
			color: '#f7d009',
			cursor: 'pointer',
			type: 'spline',
			data: [8.0, 7.9, 8.5, 16.5, 20.2, 24.5]
		},
		 {
			name: 'Process',
			color: '#fb9817',
			cursor: 'pointer',
			type: 'spline',
			data: [11.0, 8.9, 9.5, 12.5, 18.2, 29.5]
		}
		]
	});
});//bar with line chart end
		
		