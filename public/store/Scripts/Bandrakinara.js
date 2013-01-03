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
					size:'70%',
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
				size:'70%',
				name: '',
                data: [
                    { name:'Positive',
				      y:20.00,
					 color:'#3acb3a'
					  
					  },
                    { name:'Negative',
					  y:75.71,
					  color:'#f47359'},
                    {
                        name: 'Neutral',
                        y: 4.29,
                        sliced: true,
                        selected: true,
						color:'#f7d009',
						
						
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
                data: [0,1,2]},
					
									{
                name: 'Negative',
			
				color:'#f47359',
                data: [38,8,7]
            }, {
			name: 'Positive',
				color:'#3acb3a',
                data: [3,2,9]
				 }] }); 
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
			title: {
			text: 'Net Score'
		},
	
			
		}, { // Secondary yAxis
			title: {
				text: 'Total FeedBacks',
				
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
					(this.series.name == 'Rainfall' ? ' sms' : ' Score');
			}
		},
		
		legend: {
			enabled:true,
			y:10,
			x:-1,
			width:310,
			padding:4.5
		},
		series: [{
			name: 'Comments',
			color: '#999999',
			borderColor:'#333',
			 cursor: 'pointer',
			type: 'column',
			yAxis: 1,
			data: [9,48,9]

		}, {
			name: 'Product',
			color: '#502b54',
			cursor: 'pointer',
			type: 'spline',
			data: [-1,-1,0.167]
		},
		 {
			name: 'Service',
			color: '#f7d009',
			cursor: 'pointer',
			type: 'spline',
			data: [-1,-0.712,1]
		},
		 {
			name: 'Process',
			color: '#fb9817',
			cursor: 'pointer',
			type: 'spline',
			data: [0.1,0,-0.25]
		}
		]
	});
});//bar with line chart end
		
		