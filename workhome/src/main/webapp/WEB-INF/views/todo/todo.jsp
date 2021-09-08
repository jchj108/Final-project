<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>AdminLTE 3 | Calendar</title>

<!-- Google Font: Source Sans Pro -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback" />
<!-- Font Awesome -->
<link rel="stylesheet" href="${contextPath }/resources/plugins/fontawesome-free/css/all.min.css" />
<!-- Theme style -->
<link rel="stylesheet" href="${contextPath }/resources/dist/css/adminlte.min.css" />
<!-- myFullCalendar -->
<link rel="stylesheet" href='${contextPath }/resources/FullCalendar-Example-master/vendor/css/select2.min.css' />
<link rel="stylesheet" href='${contextPath }/resources/FullCalendar-Example-master/vendor/css/bootstrap-datetimepicker.min.css' />
<!-- myFullCalendar end -->
<link rel="stylesheet" href="${contextPath }/resources/FullCalendar-Example-master/vendor/css/bootstrap.min.css?sb" />
<link rel="stylesheet" href="${contextPath }/resources/FullCalendar-Example-master/css/main.css">
<link rel="stylesheet" href="${contextPath }/resources/FullCalendar-Example-master/vendor/css/fullcalendar.min.css" />

<style>
.btn-tool {
	position: relative;
	top: 12px;
}

.modal-header .close {
    padding: 1rem;
    margin: -1rem -1rem -1rem auto;
    opacity: .5;
}
/* 모달 가운데 */
.modal {
        text-align: center;
}

.fc-title, .fc-time {
	font-size: 11.9px;
}

#eventModal {
	padding-bottom: 50px;
	padding-right: 0px;
}
@media screen and (min-width: 768px) { 
        .modal:before {
                display: inline-block;
                vertical-align: middle;
                content: " ";
                height: 100%;
        }
}
 
.modal-dialog {
        display: inline-block;
        text-align: left;
        vertical-align: middle;
}
/* 모달 가운데 */

</style>


</head>
<body class="hold-transition sidebar-mini">
	<div class="wrapper">
		<!-- header -->
		<jsp:include page="../common/header.jsp"></jsp:include>
		<!-- /header -->
		<!-- sidebar -->
		<jsp:include page="../common/sidebar.jsp"></jsp:include>
		<!-- /sidebar -->

		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-8">
							<h1>일정 관리</h1>
						</div>
						<div class="col-sm-4"></div>
					</div>
				</div>
				<!-- /.container-fluid -->
			</section>
			<!-- /.container-fluid -->
			<!-- 			</section> -->

			<!-- Main content -->
			<section class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-4">
							<div class="card card-primary">

								<div class="card-header">
									<h3 class="card-title">필터</h3>

									<div class="card-tools">
										<button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
											<i class="fas fa-minus"></i>
										</button>
									</div>
								</div>
								<div class="card-body">
									<label for="calendar_view">구분별</label>
									<div class="form-group">
										<!-- 									<div class="col-lg-6"> -->
										<div class="input-group">
											<select class="filter" id="type_filter" multiple="multiple">
												<option value="카테고리1">카테고리1</option>
												<option value="카테고리2">카테고리2</option>
												<option value="카테고리3">카테고리3</option>
												<option value="카테고리4">카테고리4</option>
											</select>
										</div>
									</div>
									<!-- 									</div> -->
									<div class="form-group">

										<!-- 									<div class="col-lg-6"> -->
										<label for="calendar_view">등록자별</label>
										<div class="input-group">
											<label class="checkbox-inline"><input class='filter' type="checkbox" value="정연" checked>1</label> <label class="checkbox-inline"><input
													class='filter' type="checkbox" value="다현" checked
												>2</label> <label class="checkbox-inline"><input class='filter' type="checkbox" value="사나" checked>3</label> <label
												class="checkbox-inline"
											><input class='filter' type="checkbox" value="나연" checked>4</label> <label class="checkbox-inline"><input class='filter'
													type="checkbox" value="지효" checked
												>5</label>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-8">
							<div class="card card-primary">
								<div id="calendar"></div>
							</div>
						</div>
					</div>
				</div>
				<!-- /.filter panel -->

				<div class="container">
					<!-- 일자 클릭시 메뉴오픈 -->
					<div id="contextMenu" class="dropdown clearfix">
						<ul class="dropdown-menu dropNewEvent" role="menu" aria-labelledby="dropdownMenu" style="display: block; position: static; margin-bottom: 5px;">
							<li><a tabindex="-1" href="#">카테고리1</a></li>
							<li><a tabindex="-1" href="#">카테고리2</a></li>
							<li><a tabindex="-1" href="#">카테고리3</a></li>
							<li><a tabindex="-1" href="#">카테고리4</a></li>
							<li class="divider"></li>
							<li><a tabindex="-1" href="#" data-role="close">Close</a></li>
						</ul>
					</div>

					<!-- 					<div id="wrapper"> -->
					<!-- 						<div id="loading"></div> -->
					<!-- 					</div> -->


					<!-- 일정 추가 MODAL -->
					<div class="modal fade" tabindex="-1" role="dialog" id="eventModal">
						<div class="modal-dialog" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h4 class="modal-title"></h4>
									<button type="button" class="close" data-dismiss="modal" aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>
								<div class="modal-body">

									<div class="row">
										<div class="col-xs-12">
											<label class="col-xs-4" for="edit-allDay">하루종일</label>
											<input class='allDayNewEvent' id="edit-allDay" type="checkbox">
											</label>
										</div>
									</div>

									<div class="row">
										<div class="col-xs-12">
											<label class="col-xs-4" for="edit-title">일정명</label>
											<input class="inputModal" type="text" name="edit-title" id="edit-title" required="required" />
										</div>
									</div>
									<div class="row">
										<div class="col-xs-12">
											<label class="col-xs-4" for="edit-start">시작</label>
											<input class="inputModal" type="text" name="edit-start" id="edit-start" />
										</div>
									</div>
									<div class="row">
										<div class="col-xs-12">
											<label class="col-xs-4" for="edit-end">끝</label>
											<input class="inputModal" type="text" name="edit-end" id="edit-end" />
										</div>
									</div>
									<div class="row">
										<div class="col-xs-12">
											<label class="col-xs-4" for="edit-type">구분</label> <select class="inputModal" type="text" name="edit-type" id="edit-type">
												<option value="카테고리1">카테고리1</option>
												<option value="카테고리2">카테고리2</option>
												<option value="카테고리3">카테고리3</option>
												<option value="카테고리4">카테고리4</option>
											</select>
										</div>
									</div>
									<div class="row">
										<div class="col-xs-12">
											<label class="col-xs-4" for="edit-color">색상</label> <select class="inputModal" name="color" id="edit-color">
												<option value="#D25565" style="color: #D25565;">빨간색</option>
												<option value="#9775fa" style="color: #9775fa;">보라색</option>
												<option value="#ffa94d" style="color: #ffa94d;">주황색</option>
												<option value="#74c0fc" style="color: #74c0fc;">파란색</option>
												<option value="#f06595" style="color: #f06595;">핑크색</option>
												<option value="#63e6be" style="color: #63e6be;">연두색</option>
												<option value="#a9e34b" style="color: #a9e34b;">초록색</option>
												<option value="#4d638c" style="color: #4d638c;">남색</option>
												<option value="#495057" style="color: #495057;">검정색</option>
											</select>
										</div>
									</div>
									<div class="row">
										<div class="col-xs-12">
											<label class="col-xs-4" for="edit-desc">설명</label>
											<textarea rows="4" cols="50" class="inputModal" name="edit-desc" id="edit-desc"></textarea>
										</div>
									</div>
								</div>
								<div class="modal-footer modalBtnContainer-addEvent">
									<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
									<button type="button" class="btn btn-primary" id="save-event">저장</button>
								</div>
								<div class="modal-footer modalBtnContainer-modifyEvent">
									<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
									<button type="button" class="btn btn-danger" id="deleteEvent">삭제</button>
									<button type="button" class="btn btn-primary" id="updateEvent">저장</button>
								</div>
							</div>
							<!-- /.modal-content -->
						</div>
						<!-- /.modal-dialog -->
					</div>
					<!-- /.modal -->


				</div>
			</section>
			<!-- /.content -->
		</div>

		<!--       </footer> -->
		<jsp:include page="../common/footer.jsp"></jsp:include>

		<!-- Control Sidebar -->
		<aside class="control-sidebar control-sidebar-dark">
			<!-- Control sidebar content goes here -->
		</aside>
		<!-- /.control-sidebar -->
	</div>
	<!-- ./wrapper -->

	<!-- jQuery -->
	<script src="${contextPath }/resources/plugins/jquery/jquery.min.js"></script>
	<!-- Bootstrap -->
	<script src="${contextPath }/resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- jQuery UI -->
	<script src="${contextPath }/resources/plugins/jquery-ui/jquery-ui.min.js"></script>
	<!-- AdminLTE App -->
	<script src="${contextPath }/resources/dist/js/adminlte.min.js"></script>
	<!-- fullCalendar 2.2.5 -->
	<%-- 		<script src="${contextPath }/resources/plugins/moment/moment.min.js"></script> --%>
	<%-- 		<script src="${contextPath }/resources/plugins/fullcalendar/main.js"></script> --%>
	<!-- AdminLTE for demo purposes -->
	<script src="${contextPath }/resources/dist/js/demo.js"></script>
	<!-- Page specific script -->
	<script src="${contextPath }/resources/FullCalendar-Example-master/vendor/js/jquery.min.js"></script>
	<!--  -->
	<script src="${contextPath }/resources/FullCalendar-Example-master/vendor/js/moment.min.js"></script>
	<script src="${contextPath }/resources/FullCalendar-Example-master/vendor/js/fullcalendar.min.js"></script>
	<script src="${contextPath }/resources/FullCalendar-Example-master/vendor/js/ko.js"></script>
	<script src="${contextPath }/resources/FullCalendar-Example-master/vendor/js/select2.min.js"></script>
	<script src="${contextPath }/resources/FullCalendar-Example-master/vendor/js/bootstrap-datetimepicker.min.js"></script>
	<script src="${contextPath }/resources/FullCalendar-Example-master/js/main.js"></script>
	<script src="${contextPath }/resources/FullCalendar-Example-master/js/addEvent.js"></script>
	<script src="${contextPath }/resources/FullCalendar-Example-master/js/editEvent.js"></script>
	<script src="${contextPath }/resources/FullCalendar-Example-master/js/etcSetting.js"></script>
	<script src="${contextPath}/resources/FullCalendar-Example-master/vendor/js/bootstrap.min.js"></script>
</body>
</html>
