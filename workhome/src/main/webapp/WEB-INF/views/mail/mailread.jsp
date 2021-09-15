<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>AdminLTE 3 | Read Mail</title>

<!-- Google Font: Source Sans Pro -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="${contextPath}/resources/plugins/fontawesome-free/css/all.min.css">
<!-- Theme style -->
<link rel="stylesheet"
	href="${contextPath}/resources/dist/css/adminlte.min.css">

<style>
.mailSR-info {
	font-size: 14px;
	color: gray;
/* 	vertical-align: middle; */
}

#favorites-icon {
	font-size: 14px;
}

.mail-icon {
	width: 20px;
}

.thispage, .thispage b {
	color: #007bff;
}

.table td, .table th {
	padding: .25rem;
	vertical-align: middle;
}

.table-striped tbody tr:nth-of-type(odd) {
	background-color: rgba(0, 0, 0, 0);
}

.table-hover tbody tr:hover {
	background-color: rgba(0, 0, 0, .075)
}

.table td:nth-child(1) {
	width: 4%;
}

.table td:nth-child(2) {
	width: 8%;
}

.table td:nth-child(3) {
	width: 18%;
}

.table td:nth-child(4) {
	width: 50%;
}

.table td:nth-child(5) {
	text-align: right;
}

.table td:nth-child(6) {
	width: 12%;
	text-align: right;
}

.fa-star {
	margin-right: 8px;
}

.fa-paperclip {
	margin-left: 10px;
}

.mailbox-name a {
	margin-left: 20px;
	text-decoration: none;
}

td {
	height: 35px;
}

.pagination {
	margin-top: 10px;
	margin-bottom: 10px;
}

.mailNo-hidden {
	display: none;
	width: 0px;
}

.mailbox-read-message {
	min-height: 500px;
}
</style>

</head>
<body class="hold-transition sidebar-mini">
	<div class="wrapper">
		<!-- Navbar -->
		<jsp:include page="../common/header.jsp"></jsp:include>
		<!-- Main Sidebar Container -->
		<jsp:include page="../common/sidebar.jsp"></jsp:include>
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
<!-- 							<h1>메일 읽기</h1> -->
						</div>
						<div class="col-sm-6">
<!-- 							<ol class="breadcrumb float-sm-right"> -->
<!-- <!-- 								<li class="breadcrumb-item"><a href="#">Home</a></li> --> -->
<!-- <!-- 								<li class="breadcrumb-item active">Compose</li> --> -->
<!-- 							</ol> -->
						</div>
					</div>
				</div>
				<!-- /.container-fluid -->
			</section>

			<!-- Main content -->
			<section class="content">
				<div class="container-fluid">
					<div class="row">
						<jsp:include page="mailsidemenu.jsp"></jsp:include>
						<!-- /.col -->
						<div class="col-md-9">
							<div class="card card-primary card-outline">
								<div class="card-header">
									<h3 class="card-title">${mail.etitle }</h3>

									<div class="card-tools">
										<a href="#" class="btn btn-tool" title="Previous"><i
											class="fas fa-chevron-left"></i></a> <a href="#"
											class="btn btn-tool" title="Next"><i
											class="fas fa-chevron-right"></i></a>
									</div>
								</div>
								<!-- /.card-header -->
								<div class="card-body p-0">
									<div class="mailbox-read-info">
										<h6>
											보낸 사람 : &lt;${mail.senderName }&gt; ${mail.empNo }@workhome.com
											</h5>
											<h6>
												받는 사람 :
												<c:if test="${mail.receiverName != null }">&lt;${mail.receiverName }&gt;</c:if>
												${mail.receiveEmp} <span
													class="mailbox-read-time float-right">
														<fmt:formatDate pattern="yyyy-MM-dd a HH:mm" value="${mail.sDate }"/>
													</span>
											</h6>
									</div>
									<!-- /.mailbox-read-info -->
									<div class="mailbox-controls with-border text-center">
										<div class="btn-group">
											<button type="button" class="btn btn-default btn-sm"
												data-container="body" title="Delete">
												<i class="far fa-trash-alt"></i>
											</button>
											<button type="button" class="btn btn-default btn-sm"
												data-container="body" title="Reply">
												<i class="fas fa-reply"></i>
											</button>
											<button type="button" class="btn btn-default btn-sm"
												data-container="body" title="Forward">
												<i class="fas fa-share"></i>
											</button>
										</div>
										<!-- /.btn-group -->
										<button type="button" class="btn btn-default btn-sm"
											title="Print">
											<i class="fas fa-print"></i>
										</button>
									</div>
									<!-- /.mailbox-controls -->
									<div class="mailbox-read-message">${mail.econtent }</div>
									<!-- /.mailbox-read-message -->
								</div>
								<!-- /.card-body -->
								<div class="card-footer bg-white">
									<ul
										class="mailbox-attachments d-flex align-items-stretch clearfix">
										<c:forEach var="mF" items="${mail.mailFileList }">
											<c:if test="${mF.mFileNo != 0}">
												<li><span class="mailbox-attachment-icon"><i
														class="far fa-file-pdf"></i></span>

													<div class="mailbox-attachment-info">
														<a 
														href="${contextPath }/resources/mailUploadFiles/${mF.mChangeName}" 
														download="${mF.mOriginalName }"
														class="mailbox-attachment-name"><i
															class="fas fa-paperclip"></i> ${mF.mOriginalName }</a> <span
															class="mailbox-attachment-size clearfix mt-1"> 
<!-- 															<span>1,245KB</span>  -->
															<a 
																href="${contextPath }/resources/mailUploadFiles/${mF.mChangeName}" 
																download="${mF.mOriginalName }"
															class="btn btn-default btn-sm float-right"><i
																class="fas fa-cloud-download-alt"></i></a>
														</span>
													</div></li>
											</c:if>
										</c:forEach>
									</ul>

								</div>
								<!-- /.card-footer -->
								<div class="card-footer">
									<div class="float-right">
										<button type="button" class="btn btn-default">
											<i class="fas fa-reply"></i> 답장
										</button>
										<button type="button" class="btn btn-default">
											<i class="fas fa-share"></i> 전달
										</button>
									</div>
									<button type="button" class="btn btn-default">
										<i class="far fa-trash-alt"></i> 삭제
									</button>
									<button type="button" class="btn btn-default">
										<i class="fas fa-print"></i> 인쇄
									</button>
								</div>
								<!-- /.card-footer -->
							</div>
							<!-- /.card -->
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.container-fluid -->
			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->
		<footer class="main-footer">
			<div class="float-right d-none d-sm-block">
				<b>Version</b> 3.1.0
			</div>
			<strong>Copyright &copy; 2014-2021 <a
				href="https://adminlte.io">AdminLTE.io</a>.
			</strong> All rights reserved.
		</footer>
		<!-- Control Sidebar -->
		<aside class="control-sidebar control-sidebar-dark">
			<!-- Control sidebar content goes here -->
		</aside>
		<!-- /.control-sidebar -->
	</div>
	<!-- ./wrapper -->

	<!-- jQuery -->
	<script src="${contextPath}/resources/plugins/jquery/jquery.min.js"></script>
	<!-- Bootstrap 4 -->
	<script
		src="${contextPath}/resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- AdminLTE App -->
	<script src="${contextPath}/resources/dist/js/adminlte.min.js"></script>
	<!-- AdminLTE for demo purposes -->
	<script src="${contextPath}/resources/dist/js/demo.js"></script>
	<script>
// 		$('.fa-trash-alt').empty();
	
	</script>
	
</body>
</html>
