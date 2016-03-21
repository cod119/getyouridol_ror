
$(document).ready(function() {
	

  	
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
	
		$('#search_form2').on('change', '.select_box', function(e){
			e.stopPropagation;
			var $that = $(this);
			var $nextAlls = $(this).closest('.cell_content').nextAll('td.cell_content').find('.select_box');
			var $prevAlls = $(this).closest('.cell_content').prevAll('td.cell_content').find('.select_box');
			console.log($prevAlls.length);
			console.log($nextAlls.length);
			//'선택안함'을 선택하지 않았는지 검사
			if ($(this).val() !== "") {
				//이후에 있는 select_box의 option 중 금방 선택한 값과 같은 option을 제거
				//부작용: 앞서 있는 select_box의 선택 후 제거된 select_box의 option이 되살아남 
				$nextAlls.each(function() {
					$(this).find('option').each(function() {
						$(this).show();
						if ($(this).val() === $that.val()) {
							$(this).hide();
						}
					})
					
				})

				
				// 위에서 발생한 부작용을 처리.
				// 이후 위치한 select_box가 하나 이상일 때
				// 앞서 위치한 select_box에서 select된 값에 대하여, 이후의 select_box의 option중 같은 값이 있으면
				// 해당 option을 삭제.
				if ($nextAlls.length >= 1) {
					for (var i = 0; i < $nextAlls.length; i++) {
						$nextAlls.eq(i).each(function() {
							$(this).find('option').each(function() {
								for (var j = 0; j < $prevAlls.length; j++) {
									//아래 && 이후 구문은, '선택안함'이 사라지지 않도록 하기 위함.
									if ($(this).val() === $prevAlls.eq(j).val() && $(this).val() !== "") {
										$(this).hide();
									}	
								}
								
							})
						})
					}
					// 뒤로가기로 search.html로 돌아왔을때, 특정 select_box에서 값을 선택할 경우,
					// 이후의 select_box에 이미 selected된 값과 겹치는 경우, 목록에서는 사라지나,
					// selected된 값이 바뀌지 않는 현상이 있는데, 이를 해결하는 코드.
					$nextAlls.each(function () {
						if ($(this).val() === $that.val()) {
							$(this).find('option').removeAttr('selected').first().attr("selected", "selected");
						}
					})
				}
			}
		
	}).trigger('change');
	
	// 뒤로가기로 search.html로 돌아왔을때, 특정 select_box를 열었을 경우(click)
	// 앞선 select_box에서 이미 selected된 값이 사라지지 않고 그대로 뜨는 현상이 있는데
	// 이를 해결하는 코드.
	$('#search_form2').on('click', '.select_box', function(e){
		e.stopPropagation;
		var $that = $(this)
		var $prevAlls = $(this).closest('.cell_content').prevAll('td.cell_content').find('.select_box');
		//'선택안함'을 선택하지 않았는지 검사
		if ($(this).val() !== "") {
			// 
			if ($prevAlls.length >= 1) {
				$that.find('option').each(function() {
					var $option = $(this)
					$prevAlls.each(function() {
						if ($(this).val() === $option.val() && $option.val() !== "") {
							$option.hide();
						}
					})
				})
			}
		}
	})
	
	$('#search_form2').on('change', '.check_box_multisel_group', function(e){
		e.stopPropagation;
		var $box = $(this).closest('.check_box_multisel_group_box');
		console.log($(this).prop('checked') === true);
		if($(this).prop('checked') === true) {
			$box.find('.check_box_multisel_indiv').each(function() {
				$(this)[0].checked = true;
			})
			console.log($box.find('.check_box_multisel_indiv'))
		} else {
			$box.find('.check_box_multisel_indiv').each(function() {
				$(this)[0].checked = false;
			})
		}
	}).trigger('change')
	
	$('#search_form2').on('change', '.check_box_multisel_indiv', function(e){
		e.stopPropagation;
		var $box = $(this).closest('.check_box_multisel_group_box');
		if($(this).prop('checked') === true) {
			console.log($box.find('.check_box_multisel_indiv:checked').length)
			console.log($box.find('.check_box_multisel_indiv').length)
			if ($box.find('.check_box_multisel_indiv').length === $box.find('.check_box_multisel_indiv:checked').length) {
				console.log($box.find('.check_box_multisel_group'))
				$box.find('.check_box_multisel_group')[0].checked = true;
			}	
		} else {
			if ($box.find('.check_box_multisel_group').prop('checked') === true) {
				$box.find('.check_box_multisel_group')[0].checked = false;
			}
		}
		// 추가 조건 검색의 소속사2의 체크박스에 변동이 발생(click)하는 경우
		// 소속사1의 셀렉트 박스의 선택값을 초기화
		if ($('#search_form').find('#form_productionorunit').val() !== "") {
		 	console.log($('#search_form').find('#form_productionorunit').val())
			$('#search_form').find('#form_productionorunit').val("전체")
		}
	}).trigger('change')
	// 소속사1 셀렉트 박스의 선택값이 변화한 경우, 추가 조건 검색의 소속사2의 모든 체크박스롤 체크로.
	// 이기능은, 뒤로가기할 때, 추가 조건 선택 박스가 출력도되록 한 아래의 코드로 해결이 가능하므로
	// 솔직히 필요없는 기능이지만, 남겨두겠음.
	$('#search_form').on('change', '#form_productionorunit', function() {
		$('#search_form2').find('.check_box_multisel_group, .check_box_multisel_indiv').each(function() {
			$(this)[0].checked = true;
		})
	})
	//소속사2의 체크박스, 셀렉트 박스등에 변동이 있을 경우(주로 검색 후 뒤로가기 시), .search_form2를 show함
	if ($('#search_form2').find('.check_box_multisel_indiv').length !== $('#search_form2').find('.check_box_multisel_indiv:checked').length) {
		$('#search_form2').find('tbody').show();
	}
	if ($('#search_form2').find('.select_box').val() !== "") {
		$('#search_form2').find('tbody').show();
	}
	//****************
	
	// 추가 검색 조건 누르면, 상단의 소속 행이 사라지고 추가 검색 테이블 출력
	// 소속사2의 체크박스의 체크가 모두 사라짐.
	$('#search_form2').on('click', 'thead', function(e) {
		$('#productionorunit_cell_1').hide()
		e.stopPropagation;
		var $that = $(this)
		$(this).closest('#search_form2').find('tbody').show('fast')
		$('#search_form2').find('.check_box_multisel_group, .check_box_multisel_indiv').each(function() {
			$(this)[0].checked = false;
		})
				
	}).trigger('click')
	
	//result.html
	$('.box-card').on('click', function(e) {
		$(this).hide('fast', function(){
			$(this).closest('.box-outter').children('.box-inner').fadeToggle('fast');
		});
		
	});
	$('.box-inner').on('click', function(e) {
		$(this).closest('.box-inner').hide('fast', function() {
			$(this).closest('.box-outter').children('.box-card').fadeToggle('fast');
		});
		
	});
	//만약 아무런 result값이 없다면 nothing 출력
	if ($('.result-wrapper .box-outter').length === 0) {
		$('#result_nothing').show();
	}
});