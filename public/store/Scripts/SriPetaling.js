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
            x: -2,
            y: 180,
			width:235, padding:4.5
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
                    cursor: 'pointer',
					cursor: 'pointer',
					
					
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
				      y:60.4,
					 color:'#3acb3a'
					  
					  },
                    { name:'Negative',
					  y:26.8,
					  color:'#f47359'},
                    {
                        name: 'Neutral',
                        y: 12.8,
                        sliced: true,
                        selected: true,
						color:'#f7d009'
						
						
                    },
                    
                   
                   
                ]
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
			legend:{ enabled:'true',
				padding:4.5
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
                data: [25,125,82]},
					
									{
                name: 'Negative',
			
				color:'#f47359',
                data: [233,78,110]
            }, {
			name: 'Positve',
				color:'#3acb3a',
                data: [7,32,38]
				
				
				
				
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
			categories: ['2010','2011','2012'],
				
		}],
		yAxis: [{ // Primary yAxis
		min:-1,max:1,
			title: {
			text: 'Net Score'
		},
	
			
		}, { // Secondary yAxis
			title: {
				text: 'Total Feedbacks',
				style: {
					color: '#4572A7'
				}
			},
		labels: {
				formatter: function() {
					return this.value +' sms';
				},
				style: {
					color: '#999999'
				}
			},
			opposite: true
		}],
		tooltip: {
			formatter: function() {
				return ''+
					this.x +': '+ this.y +
					(this.series.name == 'Rainfall' ? ' sms' : '');
			}
		},
		
		legend: {
			enabled:true,
			width:310, padding:4.5,
			y:9
		},
		series: [{
			name: 'Comments',
			color: '#999',
			borderColor:'#333',
			 cursor: 'pointer',
			type: 'column',
			yAxis: 1,
			data: [14,33,16]

		}, {
			name: 'Product',
			color: '#502b54',
			cursor: 'pointer',
			type: 'spline',
			data: [0.25,0.091,0.2]
		},
		 {
			name: 'Service',
			color: '#f7d009',
			cursor: 'pointer',
			type: 'spline',
			data: [-1,0.136,-0.125]
		},
		 {
			name: 'Process',
			color: '#fb9817',
			cursor: 'pointer',
			type: 'spline',
			data: [0.25,-0.445,-0.143]
		}
		]
	});
});//bar with line chart end
		
		