
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>AdminLTE 3 | Dashboard 3</title>

<!-- Google Font: Source Sans Pro -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="${contextPath}/resources/plugins/fontawesome-free/css/all.min.css">
<!-- icheck bootstrap -->
<link rel="stylesheet"
	href="${contextPath}/resources/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
<!-- Theme style -->
<link rel="stylesheet"
	href="${contextPath}/resources/dist/css/adminlte.min.css">

</head>
<!--
	`body` tag options:
	
	  Apply one or more of the following classes to to the body tag
	  to get the desired effect
	
	  * sidebar-collapse
	  * sidebar-mini
	-->
<body class="hold-transition sidebar-mini">
	<div class="wrapper">
		<!-- header -->
		<jsp:include page="../common/header.jsp"></jsp:include>
		<!-- /header -->

		<!-- sidebar -->
		<jsp:include page="../common/sidebar.jsp"></jsp:include>
		<!-- /sidebar -->

		<!-- 메인 컨텐츠 -->
		<div class="content-wrapper" align="center">
			<br> <br>
			<!-- 근태관리 -->
			<div class="container"
				style="background: white; padding: 30px 30px 30px; margin: 30px">
				<h3 align="left">출퇴근 기록</h3>
				<table class="table table-bordered" style="text-align: center">
					<thead>
						<tr>
							<th>이름</th>
							<th>날짜</th>
							<th>출근시간</th>
							<th>퇴근시간</th>
							<th>총 근무시간</th>
							<th>근무시간 상세</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>강건강</td>
							<td>2021-08-10</td>
							<td>08:59:01</td>
							<td>18:00:15</td>
							<td>07:38:44</td>
							<td>업무 07:38:44 / 휴식 01:00:00 / 식사 01:15:43</td>
						</tr>
						<tr>
							<td>강건강</td>
							<td>2021-08-10</td>
							<td>08:59:01</td>
							<td>18:00:15</td>
							<td>07:38:44</td>
							<td>업무 07:38:44 / 휴식 01:00:00 / 식사 01:15:43</td>
						</tr>
						<tr>
							<td>강건강</td>
							<td>2021-08-10</td>
							<td>08:59:01</td>
							<td>18:00:15</td>
							<td>07:38:44</td>
							<td>업무 07:38:44 / 휴식 01:00:00 / 식사 01:15:43</td>
						</tr>
						<tr>
							<td>강건강</td>
							<td>2021-08-10</td>
							<td>08:59:01</td>
							<td>18:00:15</td>
							<td>07:38:44</td>
							<td>업무 07:38:44 / 휴식 01:00:00 / 식사 01:15:43</td>
						</tr>
						<tr>
							<td>강건강</td>
							<td>2021-08-10</td>
							<td>08:59:01</td>
							<td>18:00:15</td>
							<td>07:38:44</td>
							<td>업무 07:38:44 / 휴식 01:00:00 / 식사 01:15:43</td>
						</tr>
						<tr>
							<td>강건강</td>
							<td>2021-08-10</td>
							<td>08:59:01</td>
							<td>18:00:15</td>
							<td>07:38:44</td>
							<td>업무 07:38:44 / 휴식 01:00:00 / 식사 01:15:43</td>
						</tr>
					</tbody>
					<tr>
						<td colspan="6" align="center">
							<ul class="pagination justify-content-center">
								<li class="page-item"><a class="page-link" href="#">이전</a></li>
								<li class="page-item"><a class="page-link" href="#">1</a></li>
								<li class="page-item"><a class="page-link" href="#">2</a></li>
								<li class="page-item"><a class="page-link" href="#">3</a></li>
								<li class="page-item"><a class="page-link" href="#">다음</a></li>
							</ul>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<!-- /메인 컨텐츠 -->

		<!-- footer -->
		<jsp:include page="../common/footer.jsp"></jsp:include>
		<!-- /footer -->

	</div>
	<!-- ./wrapper -->

	<!-- REQUIRED SCRIPTS -->

	<!-- jQuery -->
	<script src="plugins/jquery/jquery.min.js"></script>
	<!-- Bootstrap -->
	<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- AdminLTE -->
	<script src="dist/js/adminlte.js"></script>

	<!-- OPTIONAL SCRIPTS -->
	<script src="plugins/chart.js/Chart.min.js"></script>
	<!-- AdminLTE for demo purposes -->
	<script src="dist/js/demo.js"></script>
	<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
	<script src="dist/js/pages/dashboard3.js"></script>
</body>
</html>