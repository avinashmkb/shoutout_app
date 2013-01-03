// JavaScript Document
$(function() {
        $( "#from" ).datepicker({
            defaultDate: "+1w",
            changeMonth: true,
            numberOfMonths: 2,
            onClose: function( selectedDate ) {
                $( "#to" ).datepicker( "option", "minDate", selectedDate );
            }
        });
        $( "#to" ).datepicker({
            defaultDate: "+1w",
            changeMonth: true,
            numberOfMonths: 2,
            onClose: function( selectedDate ) {
                $( "#from" ).datepicker( "option", "maxDate", selectedDate );
            }
        });
		$( "#from, #to" ).datepicker({ dateFormat: "yy-mm-dd" });
		$( "#from, #to" ).datepicker( "option", "dateFormat", "dd-mm-yy" );
	   $( "#from" ).datepicker( "setDate" , 12-02-12 )
	   $( "#to" ).datepicker( "setDate" , 12-05-12 )
    });