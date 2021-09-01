<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
			<br>
			<br>
			<!-- 공지사항 -->
			<div class="container"
				style="background: white; padding: 30px 30px 30px; margin: 30px">
				<h3 align="left">공지사항 상세보기</h3>
				<table class="table table-bordered">
					<tr>
						<th width="15%">번호</th>
						<td>${ notice.noticeNo }</td>
					</tr>
					<tr>
						<th>제목</th>
						<td>${ notice.noticeTitle }</td>
					</tr>
					<tr>
						<th>작성자</th>
						<td>${ notice.noticeWriter }</td>
					</tr>
					<tr>
						<th>작성날짜</th>
						<td>${ notice.noticeModifyDate }</td>
					</tr>
					<tr>
						<th>내용</th>
						<% pageContext.setAttribute("newLineChar", "\r\n"); %>
						<td>${ fn:replace(notice.noticeContent, newLineChar, "<br>") }</td>
					</tr>
					
					<c:if test="${ !empty notice.originFileName }">
					<tr>
						<th>첨부파일</th>
						<td><a href="${ contextPath }/resources/nuploadFiles/${ notice.renameFileName }" download="${ notice.originFileName }">${ notice.originFileName }</a></td>
					</tr>
					</c:if>
					
				<c:url var="nupView" value="nupView.no">
					<c:param name="nId" value="${ notice.noticeNo }"/>
					<c:param name="page" value="${ page }"/>
				</c:url>
				<c:url var="ndelete" value="ndelete.no">
					<c:param name="nId" value="${ notice.noticeNo }"/>
				</c:url>
				<c:url var="nlist" value="nlist.no">
					<c:param name="page" value="${ page }"/>
				</c:url>
				
				<c:if test="${ loginUser.empName eq notice.noticeWriter }">
					<tr>
						<td colspan="2" align="center">
							<button onclick="location.href='${ nupView }'">수정하기</button>
							<button onclick="location.href='${ ndelete}'">삭제하기</button>
							<button onclick="location.href='${ nlist}'">목록보기</button>
						</td>
					</tr>
				</c:if>
				</table>
				
				<br>
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