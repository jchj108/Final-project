
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
				<table id="userInfoTable" class="table table-bordered" style="text-align: center">
					<thead>
						<tr>
							<th>이름</th>
							<th>날짜</th>
							<th>출근시간</th>
							<th>퇴근시간</th>
							<th>총 근무시간</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="a" items="${list}">
						<tr>
							<td>${a.empName}</td>
							<td>${a.aDate}</td>
							<td>${a.attend}</td>
							<td>${a.goHome}</td>
							<td>${a.workTime}</td>
						</tr>
						</c:forEach>
					</tbody>
					<tr>
						<td colspan="6" align="center">
							<!-- 이전 -->
							<ul class="pagination justify-content-center">
								<c:if test="${ pi.currentPage <= 1 }">
									<li class="page-item"><a class="page-link" href="#">이전</a></li>
								</c:if>
								<c:if test="${ pi.currentPage > 1 }">
									<c:url var="before" value="alist.ao">
										<c:param name="page" value="${ pi.currentPage -1 }" />
									</c:url>
									<li class="page-item"><a class="page-link"
										href="${ before }">이전</a></li>
								</c:if>

								<!-- 페이지 -->
								<c:forEach var="p" begin="${ pi.startPage }"
									end="${ pi.endPage }">
									<c:if test="${ p eq pi.currentPage }">
										<li class="page-item"><a class="page-link" href="#"><b>${ p }</b></a></li>
									</c:if>

									<c:if test="${ p ne pi.currentPage }">
										<c:url var="pagination" value="alist.ao">
											<c:param name="page" value="${ p }" />
										</c:url>
										<li class="page-item"><a class="page-link"
											href="${ pagination }">${ p }</a></li>
									</c:if>
								</c:forEach>

								<!-- [다음] -->
								<c:if test="${ pi.currentPage >= pi.maxPage }">
									<li class="page-item"><a class="page-link" href="#">다음</a></li>
								</c:if>
								<c:if test="${ pi.currentPage < pi.maxPage }">
									<c:url var="after" value="alist.ao">
										<c:param name="page" value="${ pi.currentPage + 1 }" />
									</c:url>
									<%-- 		               <a href="${ after }">[다음]</a> --%>
									<li class="page-item"><a class="page-link"
										href="${ after }">다음</a></li>
								</c:if>
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
	<script src="${contextPath}/resources/plugins/jquery/jquery.min.js"></script>
	<!-- Bootstrap -->
	<script src="${contextPath}/resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- AdminLTE -->
	<script src="${contextPath}/resources/dist/js/adminlte.js"></script>

	<!-- OPTIONAL SCRIPTS -->
	<script src="${contextPath}/resources/plugins/chart.js/Chart.min.js"></script>
	<!-- AdminLTE for demo purposes -->
	<script src="${contextPath}/resources/dist/js/demo.js"></script>
	<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
	<script src="${contextPath}/resources/dist/js/pages/dashboard3.js"></script>
	
</body>
</html>