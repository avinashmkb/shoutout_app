(function($){
	var initLayout = function() {
		var hash = window.location.hash.replace('#', '');
		var currentTab = $('ul.navigationTabs a')
							.bind('click', showTab)
							.filter('a[rel=' + hash + ']');
		if (currentTab.size() == 0) {
			currentTab = $('ul.navigationTabs a:first');
		}
		showTab.apply(currentTab.get(0));
		$('#date').DatePicker({
			flat: true,
			date: '2008-07-31',
			current: '2008-07-31',
			calendars: 1,
			starts: 1,
			view: 'years'
		});
		var now = new Date();
		now.addDays(-10);
		var now2 = new Date();
		now2.addDays(-5);
		now2.setHours(0,0,0,0);
		
		
		
		var now3 = new Date();
		now3.addDays(-4);
		var now4 = new Date()
		$('#widgetCalendar').DatePicker({
			flat: true,
			format: 'd b,y',
			date: [new Date(now3), new Date(now4)],
			calendars: 2,
			mode: 'range',
			starts: 1,
			onChange: function(formated) {
				$('#widgetField span').get(0).innerHTML = formated.join(' - ');
			
				if (formated[0]!=formated[1])
     {
    $('#widgetCalendar').stop().animate({height: state ? 0 : $('#widgetCalendar div.datepicker').get(0).offsetHeight}, 500);
    city = $("#combobox1").val();
  	 store = $("#combobox2").val();
  	 dateField=$('#widgetField span').get(0).innerHTML;
  	 var n=dateField.split("-");
  	 date1=n[0];
  	 dateFrom=date1.replace(/\s+/g, '');
  	 dat2 =n[1];
  	 dateTo=dat2.replace(/\s+/g, '');
  	//dateFrom =dateField.substr(0,9);
  	 //dateTo = dateField.substr(12,19);
  	var pathname = window.location.pathname;
  	var spliturl =pathname.split("?");
  	if (!spliturl)
  	{
  		var baseurl =spliturl[0];
  		
  	}
  	else 
  	{ 
  		var baseurl = pathname;
  	}
  	Url =baseurl+"?"+"&city="+city+"&store="+store+"&fromdate="+dateFrom+"&todate="+ dateTo
  	 location.href = Url;
  	 
   }
				
				 },
			
			
		});
		var state = false;
		$('#widgetField>a').bind('click', function(){
			$('#widgetCalendar').stop().animate({height: state ? 0 : $('#widgetCalendar div.datepicker').get(0).offsetHeight}, 500);
			state = !state;
			return false;
		});
	
		
		
		
		$('#widgetCalendar div.datepicker').css('position', 'absolute');
	};
	
	var showTab = function(e) {
		var tabIndex = $('ul.navigationTabs a')
							.removeClass('active')
							.index(this);
		$(this)
			.addClass('active')
			.blur();
		$('div.tab')
			.hide()
				.eq(tabIndex)
				.show();
	};
	
	EYE.register(initLayout, 'init');
})(jQuery)