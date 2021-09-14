<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
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
<!-- fullCalendar -->
<link rel="stylesheet" href='${contextPath }/resources/FullCalendar-Example-master/vendor/css/select2.min.css' />
<link rel="stylesheet" href='${contextPath }/resources/FullCalendar-Example-master/vendor/css/bootstrap-datetimepicker.min.css' />
<link rel="stylesheet" href="${contextPath }/resources/FullCalendar-Example-master/vendor/css/bootstrap.min.css" />
<link rel="stylesheet" href="${contextPath }/resources/FullCalendar-Example-master/css/main.css">
<link rel="stylesheet" href="${contextPath }/resources/FullCalendar-Example-master/vendor/css/fullcalendar.min.css" />
<!-- fullCalendar -->


<style>
.chulgun {
	transition: .8s;
}

<
style>.btn-tool {
	position: relative;
	top: 12px;
}

#space {
	height: 100px;
	background-color: #f4f6f9;
}

#eventModal {
	padding-right: 0px !important;
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
	padding-bottom: 80px;
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
</style>
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
		<div class="wrapper">
			<div class="content-wrapper">
				<!-- Content Header (Page header) -->
				<div class="container-fluid">
					<div class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800"></h1>
					</div>
					<div class="row">
						<div class="col-lg-7">
							<div class="card card-primary">
								<div id="calendar" class="fc fc-unthemed fc-ltr"></div>
							</div>
						</div>
						<div class="col-lg-5">
							<div class="card shadow mb-4">
								<div class="card-body">
									<h4 style="margin-bottom: 1rem;">출퇴근</h4>
									<div style="padding: 1.5rem; font-size: 1.3rem;">
										<p id="pClock"></p>
										<p class="startwork">
											<c:if test="${!empty map.ATTEND}">
								출근 : ${map.ATTEND}
								</c:if>
											<c:if test="${empty map.ATTEND}">
								출근 : 아직 출근 시간이 기록되지 않았어요!
								</c:if>
										</p>
										<p class="finishwork">
											<c:if test="${!empty map.ATTEND && empty map.GOHOME}">
								퇴근 : 아직 퇴근 시간이 기록되지 않았어요!
								</c:if>
											<c:if test="${!empty map.GOHOME}">
								퇴근 : ${map.GOHOME}
								</c:if>
										</p>
									</div>
									<c:if test="${empty map.ATTEND}">
										<a id="startbtn" class="btn btn-primary btn-user btn-block" style="color: white;"> 출근하기 </a>
									</c:if>
									<c:if test="${!empty map.ATTEND &&  empty map.GOHOME}">
										<a id="off" class="btn btn-success btn-user btn-block finishbtn" style="color: white;"> 퇴근하기 </a>
									</c:if>
									<a class="btn btn-success btn-user btn-block finishbtn" style="color: white; display: none;"> 퇴근하기 </a>
								</div>
							</div>

							<div class="card shadow mb-4">
								<div class="card-body">
									<h4 id="board" style="margin-bottom: 1rem; cursor: pointer">최신 공지</h4>
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
									<h4 style="margin-bottom: 1rem; cursor: pointer" id="go_todo">Today</h4>
									<div class="table-responsive">
										<table class="table table-bordered">
											<c:if test="${ list.size() == 0}">
												<tr>
													<td class="empty_todo" style="text-align: center">등록된 일정이 없습니다</td>
												</tr>
											</c:if>
											<c:forEach var="toDo" items="${list }">
												<tr>
													<fmt:formatDate value="${toDo.start }" pattern="HH:mm" var="start" />
													<fmt:formatDate value="${toDo.end }" pattern="HH:mm" var="end" />
													<td style="width: 20%;" >${start } - ${end }</td>
													<td style="width: 20%;">${toDo.type }
													<td style="width: 60%">${toDo.title }</td>
												</tr>
											</c:forEach>
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
		</div>
		<!-- ./wrapper -->


		<!-- Bootstrap -->
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
<script>
	$(document).on('click', '#startbtn', function() {
		$.ajax({
			url : "workstart.do",
			success : function(data) {
				if (data == "fail") {
					alert("출근 등록 실패");
				} else {
					$("#startbtn").hide();
					$(".finishbtn").fadeIn(1000);
					$(".startwork").text("출근 : " + data);
					$(".finishwork").text("퇴근 : 아직 퇴근 시간이 기록되지 않았어요!");
					clock.start();
				}
			}
		});
	});
	$(document).on('click', '.finishbtn', function() {
		$.ajax({
			url : "goHome.do",
			dataType : "json",
			success : function(data) {
				console.log(data);
				if (data.result == "success") {
					$(".finishbtn").hide();
					$('.finishwork').text("퇴근 : " + data.time);
					clock.close();
				}
			}
		})
	});
</script>

<!-- 공지사항 top n -->
<script>
	function topList() {
		$.ajax({
			url : 'topList.no',
			success : function(data) {
				console.log(data);

				$tableBody = $('#tb tbody');
				$tableBody.html('');

				for ( var i in data) {
					var $tr = $('<tr>');
					var $no = $('<td>').text(data[i].noticeNo);
					var $title = $('<td>').text(data[i].noticeTitle);

					$tr.append($no);
					$tr.append($title);
					$tableBody.append($tr);
				}
			},
			error : function(data) {
				console.log(data);
			}
		});
	};

	$(function() {
		topList();
		setInterval(function() {
			topList();
		}, 3000);
	});
</script>


</html>
