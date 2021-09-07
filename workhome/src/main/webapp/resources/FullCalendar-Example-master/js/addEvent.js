var eventModal = $('#eventModal');

var modalTitle = $('.modal-title');
var editAllDay = $('#edit-allDay');
var editTitle = $('#edit-title');
var editStart = $('#edit-start');
var editEnd = $('#edit-end');
var editType = $('#edit-type');
var editColor = $('#edit-color');
var editDesc = $('#edit-desc');

var addBtnContainer = $('.modalBtnContainer-addEvent');
var modifyBtnContainer = $('.modalBtnContainer-modifyEvent');

/*******************************************************************************
 * 새로운 일정 생성 **************
 */
var newEvent = function(start, end, eventType) {

	$("#contextMenu").hide(); // 메뉴 숨김

	modalTitle.html('새로운 일정');
	editType.val(eventType).prop('selected', true);
	editTitle.val('');
	editStart.val(start);
	editEnd.val(end);
	editDesc.val('');

	addBtnContainer.show();
	modifyBtnContainer.hide();
	eventModal.modal('show');


	// 새로운 일정 저장버튼 클릭
	$('#save-event').unbind();
	$('#save-event').on(
			'click',
			function() {

				var eventData = {
					title : editTitle.val(),
					start : editStart.val(),
					end : editEnd.val(),
					description : editDesc.val(),
					type : editType.val(),
//					username : '사나',
					backgroundColor : editColor.val(),
					textColor : '#ffffff',
					allDay : false
				};

				if (eventData.start > eventData.end) {
					alert('끝나는 날짜가 앞설 수 없습니다.');
					return false;
				}

				if (eventData.title === '') {
					alert('일정명은 필수입니다.');
					return false;
				}

				var realEndDay;

				if (editAllDay.is(':checked')) {
					eventData.start = moment(eventData.start).format(
							'YYYY-MM-DD');
					// render시 날짜표기수정
					eventData.end = moment(eventData.end).add(1, 'days')
							.format('YYYY-MM-DD');
					// DB에 넣을때(선택)
					realEndDay = moment(eventData.end).format('YYYY-MM-DD');

					eventData.allDay = true;
				}

				$("#calendar").fullCalendar('renderEvent', eventData, true);
				eventModal.find('input, textarea').val('');
				editAllDay.prop('checked', false);
				eventModal.modal('hide');

				var json = {
//					tStartDate : eventData.start,
//					tEndDate : eventData.end
					tContent : eventData.description
					, tTitle : eventData.title
					, tStartDate : moment(eventData.start).format() // moment를 이용해 date 타입으로 변환
					, tEndDate : moment(eventData.end).format()
					, bgColor : eventData.backgroundColor
					, allDay : eventData.allDay
					, textcolor : eventData.textColor
					, tType : eventData.type
				}

				// 새로운 일정 저장
				$.ajax({

					url : "insertTodo.to",
					type : 'POST',
					data : JSON.stringify(json),
			        contentType: "application/json",
					success : function(response) {
						// DB연동시 중복이벤트 방지를 위한
						console.log(response);
						
//						$('#calendar').fullCalendar('removeEvents');
//						$('#calendar').fullCalendar('refetchEvents');
					}
				});
			});
};