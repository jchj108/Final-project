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
<style>
#buttonTab{border-left: hidden; border-right: hidden;}
</style>
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
			<!-- 공지사항 -->
			<div class="container"
				style="background: white; padding: 30px 30px 30px; margin: 30px">
				<h3 align="left">공지사항</h3>
				<p>공지사항 게시글 총 갯수:${ pi.listCount }</p>
				<table class="table table-bordered">
					<thead>
						<tr class="">
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>날짜</th>
							<th>조회수</th>
							<th>첨부파일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="n" items="${ list }">
							<tr>
								<td align="center">${ n.noticeNo }</td>
								
								<td align="left">
					            <c:if test="${ !empty loginUser }">
					               <c:url var="ndetail" value="ndetail.no">
					                  <c:param name="nId" value="${ n.noticeNo }"/>
					                  <c:param name="page" value="${ pi.currentPage }"/>
					               </c:url>
					               <a href="${ ndetail }">${ n.noticeTitle }</a>
					            </c:if>
					            <c:if test="${ empty loginUser }">
					               ${ n.noticeTitle }      
					            </c:if>
					         </td>
								<td align="center">${ n.noticeWriter }</td>
								<td align="center">${ n.noticeCreateDate }</td>
								<td align="center">${ n.noticeCount }</td>
								<td align="center">
									<c:if test="${ !empty n.originFileName }">
										○
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</tbody>

					<tr>
						<td colspan="6" align="right" id="buttonTab"><c:if
								test="${ !empty loginUser }">
			               &nbsp; &nbsp; &nbsp;
			               <button onclick="location.href='ninsertView.no';">글쓰기</button>
							</c:if></td>
					</tr>
				</table>

				<!-- 이전 -->
				<ul class="pagination justify-content-center">
					<c:if test="${ pi.currentPage <= 1 }">
					<li class="page-item"><a class="page-link" href="#">이전</a></li>
					</c:if>
					<c:if test="${ pi.currentPage > 1 }">
						<c:url var="before" value="nlist.no">
							<c:param name="page" value="${ pi.currentPage -1 }"/>
						</c:url>
						<li class="page-item"><a class="page-link" href="${ before }">이전</a></li>
					</c:if>
					
					<!-- 페이지 -->
					<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
						<c:if test="${ p eq pi.currentPage }">
							<li class="page-item"><a class="page-link" href="#"><b>${ p }</b></a></li>
						</c:if>
						
						 <c:if test="${ p ne pi.currentPage }">
		                  <c:url var="pagination" value="nlist.no">
		                     <c:param name="page" value="${ p }"/>
		                  </c:url>
							<li class="page-item"><a class="page-link" href="${ pagination }">${ p }</a></li>
		               	</c:if>
					</c:forEach>
					
					<!-- [다음] -->
		            <c:if test="${ pi.currentPage >= pi.maxPage }">
		               <li class="page-item"><a class="page-link" href="#">다음</a></li>
		            </c:if>
		            <c:if test="${ pi.currentPage < pi.maxPage }">
		               <c:url var="after" value="nlist.no">
		                  <c:param name="page" value="${ pi.currentPage + 1 }"/>
		               </c:url> 
<%-- 		               <a href="${ after }">[다음]</a> --%>
		               <li class="page-item"><a class="page-link" href="${ after }">다음</a></li>
		            </c:if>
				</ul>
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