// JavaScript Document

$(document).ready(function() {
    $('#all').addClass('ba');
});
	$(document).ready(function() {
		
  $('#negativecont').hide();
		$('#neutralcont').hide();
		$('#positivecont').hide();
		
		 $('#positive').click(function(){
			  $('#negative, #neutral,#all').removeClass('ba');
		   $(this).addClass('ba');
			  $('#neutralcont, #negativecont,#allcont').animate({height:'hide'},'slow');
					$('#positivecont').delay(800).animate({height:'show'},'slow','swing');
								
			});
			
			$('#negative').click(function(){
				 $('#positive, #neutral,#all').removeClass('ba');
				 $(this).addClass('ba');
				 $('#positivecont, #neutralcont,#allcont').animate({height:'hide'},'slow');
				 $('#negativecont').delay(800).animate({height:'show'},'slow','swing');
			});
			$('#neutral').click(function(){
				 $('#positive,#negative,#all').removeClass('ba');
				 $(this).addClass('ba');
				 $('#positivecont, #negativecont,#allcont').animate({height:'hide'},'slow');;
				 $('#neutralcont').delay(800).animate({height:'show'},'slow','swing');
			});
			$('#all').click(function(){
				$('#positive,#negative,#neutral').removeClass('ba');
				 $(this).addClass('ba');
				 $('#positivecont, #negativecont,#neutralcont').animate({height:'hide'},'slow');
				 $('#allcont').delay(700).animate({height:'show'},'slow','swing');
				
				});
			
	});