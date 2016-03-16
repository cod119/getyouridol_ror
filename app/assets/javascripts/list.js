
$(document).ready(function() {
	
	function once(func) {
    // TIP: These variables are stored in a "closure scope" (worth researching),
    // so that they'll remain available to the newly-generated function every
    // time it's called.
    	var alreadyCalled = false;
    	var result;

    // TIP: We'll return a new function that delegates to the old one, but only
    // if it hasn't been called before.
    	return function() {
     	 if (!alreadyCalled) {
        // TIP: .apply(this, arguments) is the standard way to pass on all of the
        // infromation from one function call to another.
      	  result = func.apply(this, arguments);
      	  alreadyCalled = true;
      	}
      // The new function always returns the originally computed result.
     	 return result;
    	};
  	};
  	
    	
  	
	$('#search_form').on('change', '.select_min', function(e){
		e.stopPropagation;
		var $first = +$(this).val();
		console.log($first);
		console.log($(this).closest('.select_field').find('.select_max option'));
		$(this).closest('.select_field').find('.select_max option').each(function() {
			$(this).show();
			if(+$(this).val() <= $first) {
				$(this).hide();
			}
		});
		console.log($(this).closest('.select_field').find('.select_max').val());
		if(+$(this).val() >= +$(this).closest('.select_field').find('.select_max').val()) {
			console.log($(this).closest('.select_field').find('.select_max option').removeAttr('selected').filter(':visible').first());
			$(this).closest('.select_field').find('.select_max option').removeAttr('selected').filter(':visible').first().attr('selected', 'selected');
		}
		 
		//var $notHidden = $('#form_heightMax option').filter(function() {
		//	if ($(this).attr('style')!=="display: none;") {
		//		return true;
		//	} else {
		//		return false;
		//	} 
		//});
		//$notHidden.first().attr('selected','selected').end().last().removeattr('selected');
		
	}).trigger('change');
	
	$('#search_form').on('change', '.select_max', function(e){
		e.stopPropagation;
		var $last = +$(this).val();
		console.log($last);
		//max값 선택 여부에 따라 min 값의 range가 변화하는 기믹(하단) 없앰
		//$(this).closest('.select_field').find('.select_min option').each(function() {
		//	$(this).show();
		//	if(+$(this).val() >= $last) {
		//		$(this).hide();
		//	}
		//});
		
		//var $notHidden = $('#form_heightMin option').filter(function() {
		//	if ($(this).attr('style')!=="display: none;") {
		//		return true;
		//	} else {
		//		return false;
		//	} 
		//});
		//$notHidden.last().attr('selected','selected').end().first().removeattr('selected');
		
	}).trigger('change');
	
	$('.card_picture').on('click', function(e) {
		$(this).hide();
		$(this).closest('.box-outter').children('.box-inner').fadeToggle();
	});
	$('.box-inner').on('click', function(e) {
		$(this).closest('.box-inner').hide();
		$(this).closest('.box-outter').children('.card_picture').fadeToggle();
	});
});