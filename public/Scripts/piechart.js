// JavaScript Document


//Pie chart
$(function () {
    var chart;
    $(document).ready(function() {
        chart = new Highcharts.Chart({
            chart: {
				renderTo: 'piechart',
				width:400,
				backgroundColor:'none',
                margin:0,
																
		
                },
				legend: { enabled:false
			
           
			 
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
                    size:'49%',
					allowPointSelect: true,
                   
                   dataLabels: {
                        enabled: true,
						 softConnector: false,
						 distance:-20,
						 color:'#fff',
							
                                           formatter: function() {
                        return this.y +'%'+'       '},
						
                        style: {
                        fontWeight: 'bold',
																								fontSize:'14px'
                               }
						
                        
                    },
					showInLegend: true
                }
            },
			
            series: [{
                type: 'pie',
				name: 'feedbacks',
                data: [
                    { name:'Positive',
				      y:30.8,
					   color:'#3acb3a',
								sliced:true
					   
					  
					  },
                    { name:'Negative',
					  y:55.8,
					  color:'#f47359'},
                    {
                        name: 'Neutral',
                        y: 13.4,
                      color:'#f7d009',
					  sliced:true
					
                    },

                ]
            }],
			
			
        });
    });
    
});

