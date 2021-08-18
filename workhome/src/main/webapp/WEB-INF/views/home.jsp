<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>AdminLTE 3 | Calendar</title>

<!-- Google Font: Source Sans Pro -->
<!-- <link rel="stylesheet" -->
<!-- 	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback" /> -->
<!-- Font Awesome -->
<link rel="stylesheet"
	href="${contextPath }/resources/plugins/fontawesome-free/css/all.min.css" />
<!-- fullCalendar -->
<link rel="stylesheet"
	href="${contextPath}/resources/plugins/fullcalendar/main.css" />
<link
	href="${contextPath }/resources/plugins/fullcalendar-4.4.0/packages/core/main.css"
	rel="stylesheet" />
<link
	href="${contextPath }/resources/plugins/fullcalendar-4.4.0/packages/daygrid/main.css"
	rel="stylesheet" />
<script
	src="${contextPath }/resources/plugins/fullcalendar-4.4.0/packages/core/main.js"></script>
<script
	src="${contextPath }/resources/plugins/fullcalendar-4.4.0/packages/interaction/main.js"></script>
<script
	src="${contextPath }/resources/plugins/fullcalendar-4.4.0/packages/daygrid/main.js"></script>

<!-- Theme style -->
<link rel="stylesheet"
	href="${contextPath }/resources/dist/css/adminlte.min.css" />
</head>
<body class="hold-transition sidebar-mini">
	<div class="wrapper">
		<!-- header -->
		<jsp:include page="common/header.jsp"></jsp:include>
		<!-- /header -->

		<!-- sidebar -->
		<jsp:include page="common/sidebar.jsp"></jsp:include>
		<!-- /sidebar -->
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<div id="wrapper">
				<div class="container-fluid">
					<div
						class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800">Home</h1>
					</div>
					<div class="row">
						<div class="col-lg-7">
							<div class="card shadow mb-4">
								<div class="card-body">
									<div id="calendar"></div>
								</div>
							</div>
						</div>
						<div class="col-lg-5">
							<div class="card shadow mb-4">
								<div class="card-body">
									<h4 style="margin-bottom: 1rem">출퇴근</h4>
									<div style="padding: 1.5rem; font-size: 1.3rem">
										<p id="pClock"></p>
										<p class="workstart">출근 : 아직 출근 시간이 기록되지 않았습니다.</p>
										<p class="workend">퇴근 : 아직 퇴근 시간이 기록되지 않았습니다.</p>
										<p id="resultArea"></p>
									</div>
									<a id="commute" class="btn btn-primary btn-user btn-block"
										style="color: white"> 출근하기 </a> <a
										class="btn btn-success btn-user btn-block goHome"
										style="color: white"> 퇴근하기 </a> <a
										class="btn btn-success btn-user btn-block goHome"
										style="color: white; display: none"> 퇴근하기 </a>
								</div>
							</div>

							<div class="card shadow mb-4">
								<div class="card-body">
									<h4 id="board" style="margin-bottom: 1rem; cursor: pointer">
										최신 공지</h4>
									<div class="table-responsive">
										<table class="table table-bordered" id="tb">
											<thead>
												<tr style="text-align: center">
													<th>번호</th>
													<th>제목</th>
												</tr>
											</thead>
											<tbody>
												<tr>
<!-- 													<td><i class="fa fa-picture-o" aria-hidden="false"></i> -->
<!-- 														<i class="fa fa-video-camera" aria-hidden="true"></i></td> -->
													<td></td>
													<td></td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
							<div class="card shadow mb-4">
								<div class="card-body">
									<h4 style="margin-bottom: 1rem; cursor: pointer" id="go_todo">
										할일</h4>
									<div class="table-responsive">
										<table class="table table-bordered">
											<tr class="todo_tr">
												<td><i class="fa fa-check todo_check"
													aria-hidden="true" style="float: right; margin-right: 1rem"></i>
												</td>
											</tr>
											<tr id="hideTr">
												<td class="empty_todo"
													style="text-align: center; cursor: pointer">아직 등록된 할
													일이 없습니다!</td>
											</tr>
											<tr>
												<td class="empty_todo"
													style="text-align: center; cursor: pointer">아직 등록된 할
													일이 없습니다!</td>
											</tr>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- /.content -->
			</div>
			<!-- /.content-wrapper -->

			<!--       <footer class="main-footer"> -->
			<!--         <div class="float-right d-none d-sm-block"><b>Version</b> 3.1.0</div> -->
			<!--         <strong -->
			<!--           >Copyright &copy; 2014-2021 -->
			<!--           <a href="https://adminlte.io">AdminLTE.io</a>.</strong -->
			<!--         > -->
			<!--         All rights reserved. -->
			<!--       </footer> -->
			<jsp:include page="common/footer.jsp"></jsp:include>


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
<!-- 		<script -->
<%-- 			src="${contextPath }/resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script> --%>
		<!-- jQuery UI -->
		<script
			src="${contextPath }/resources/plugins/jquery-ui/jquery-ui.min.js"></script>
		<!-- AdminLTE App -->
		<script src="${contextPath }/resources/dist/js/adminlte.min.js"></script>
		<!-- Page specific script -->
</body>
<script type="text/javascript">
	function showClock() {
		var currentDate = new Date()
		var pClock = document.getElementById('pClock')
		var apm = currentDate.getHours()
		if (apm < 12) {
			apm = '오전 '
		} else {
			apm = '오후 '
		}

		var msg = '현재시간  : ' + apm + currentDate.getHours() + ' 시 '
		msg += currentDate.getMinutes() + ' 분  '
		msg += currentDate.getSeconds() + ' 초  '

		pClock.innerText = msg

		setTimeout(showClock, 1000)
	}

	$(document).ready(function() {
		showClock()
	})
</script>
<script type="text/javascript">
	document.addEventListener('DOMContentLoaded', function() {
		var calendarEl = document.getElementById('calendar')
		var today = new Date()

		var calendar = new FullCalendar.Calendar(calendarEl, {
			plugins : [ 'interaction', 'dayGrid' ],
			defaultDate : today,
			editable : false,
			eventLimit : true,
			views : {
				dayGrid : {
					eventLimit : 3,
				},
			},
		})
		calendar.render()
	})
</script>

<!-- 공지사항 top n -->
<script>
	function topList(){
		$.ajax({
			url : 'topList.no',
			success : function(data){
				console.log(data);
				
				$tableBody = $('#tb tbody');
				$tableBody.html('');
				
				for(var i in data){
					var $tr = $('<tr>');
					var $no = $('<td>').text(data[i].noticeNo);
					var $title =$('<td>').text(data[i].noticeTitle);
				
				$tr.append($no);
				$tr.append($title);
				$tableBody.append($tr);
				}
			},
			error : function(data){
				console.log(data);
			}
		});
	};
	
	$(function(){
		topList();
		setInterval(function(){
			topList();
		}, 3000);
	});
</script>


</html>
