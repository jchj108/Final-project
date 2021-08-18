<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>AdminLTE 3 | Compose Message</title>

<!-- Google Font: Source Sans Pro -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="${contextPath}/resources/plugins/fontawesome-free/css/all.min.css">
<!-- Theme style -->
<link rel="stylesheet"
	href="${contextPath}/resources/dist/css/adminlte.min.css">
<!-- summernote -->
<link rel="stylesheet"
	href="${contextPath}/resources/plugins/summernote/summernote-bs4.min.css">

<style>
.mailsubtitle-flex-container {
	display: flex;
	justify-content: space-between;
}

.mailsubtitle-right {
	width: 87%;
}

.mailsubtitle-left {
	height: calc(2.25rem + 2px);
	align-self: center;
}

#chart {
	height: 30px;
	margin-top: 4px;
	align-self: center;
	background-color: rgba(128, 128, 128, 0.11);
	border-color: rgba(0, 0, 0, 0.125);
}

.mail-icon {
	width: 20px;
}
</style>

</head>
<body class="hold-transition sidebar-mini">
	<div class="wrapper">
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
							<h1>메일 보내기</h1>
						</div>
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="#">Home</a></li>
								<li class="breadcrumb-item active">Compose</li>
							</ol>
						</div>
					</div>
				</div>
				<!-- /.container-fluid -->
			</section>

			<!-- Main content -->
			<section class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-3">
							<a href="mail.mail" class="btn btn-primary btn-block mb-3">돌아가기</a>

							<div class="card">
								<div class="card-header">
									<h3 class="card-title">보관함</h3>

									<div class="card-tools">
										<button type="button" class="btn btn-tool"
											data-card-widget="collapse">
											<i class="fas fa-minus"></i>
										</button>
									</div>
								</div>
								<div class="card-body p-0">
									<ul class="nav nav-pills flex-column">
										<li class="nav-item active"><a href="#" class="nav-link">
												<i class="fas fa-inbox mail-icon"></i> 받은메일함 <span
												class="badge bg-primary float-right">12</span>
										</a></li>
										<li class="nav-item"><a href="#" class="nav-link"> <i
												class="far fa-envelope mail-icon"></i> 보낸메일함
										</a></li>
										<li class="nav-item"><a
											href="${contextPath}/templist.mail" class="nav-link"> <i
												class="far fa-file-alt mail-icon"></i> 임시보관함
										</a></li>
										<li class="nav-item"><a href="#" class="nav-link"> <i
												class="fas fa-filter mail-icon"></i> 스팸메일함 <span
												class="badge bg-warning float-right mail-icon">65</span>
										</a></li>
										<li class="nav-item"><a href="#" class="nav-link"> <i
												class="far fa-trash-alt mail-icon"></i> 휴지통
										</a></li>
									</ul>
								</div>
								<!-- /.card-body -->
							</div>
							<!-- /.card -->
							<div class="card">
								<div class="card-header">
									<h3 class="card-title">분류</h3>

									<div class="card-tools">
										<button type="button" class="btn btn-tool"
											data-card-widget="collapse">
											<i class="fas fa-minus"></i>
										</button>
									</div>
								</div>
								<!-- /.card-header -->
								<div class="card-body p-0">
									<ul class="nav nav-pills flex-column">
										<li class="nav-item"><a class="nav-link" href="#"><i
												class="far fa-circle text-danger"></i> 긴급</a></li>
										<li class="nav-item"><a class="nav-link" href="#"><i
												class="far fa-circle text-warning"></i> 보통</a></li>
										<li class="nav-item"><a class="nav-link" href="#"><i
												class="far fa-circle text-primary"></i> 낮음</a></li>
									</ul>
								</div>
								<!-- /.card-body -->
							</div>
							<!-- /.card -->
						</div>
						<!-- /.col -->
						<div class="col-md-9">
							<div class="card card-primary card-outline">
								<div class="card-header">
									<h3 class="card-title">새 메일 쓰기</h3>
								</div>
								<!-- /.card-header -->
								<form method="post" id="form-mailsend"
									enctype="Multipart/form-data">
									<div class="card-body">
										<input type="hidden" value="${loginUser.empNo}"
											name="senderMailId" />
										<input type="hidden" value="${loginUser.empName}"
											name=senderName />
										<input type="hidden" value="${mail.mailNo}"
											name=mailNo />
											
										<div class="mailsubtitle-flex-container">
											<div class="mailsubtitle-left">
												<b>받는 사람</b>
											</div>
											<div>
												<button type="button" class="btn btn-sm btn-primary" style="background-color:#007BFF"
													id="chart">조직도</button>
											</div>
											<div class="form-group mailsubtitle-right">
												<input class="form-control mail-subtitle" placeholder="받는 이"
													name="receiveEmp" value="${mail.receiveEmp }">
											</div>
										</div>
										<div class="mailsubtitle-flex-container">
											<div class="mailsubtitle-left">
												<b>제목</b>
											</div>
											<div class="form-group mailsubtitle-right">
												<input class="form-control" placeholder="제목" name="etitle" value="${mail.etitle }">
											</div>
										</div>
										<div class="form-group">
											<textarea id="compose-textarea"
												class="form-control mail-subtitle" name="econtent">${mail.econtent }
					                 	   </textarea>
										</div>
										<div class="form-group">
											<div class="btn btn-default btn-file">
												<i class="fas fa-paperclip"> 파일 첨부 <input
													multiple="multiple" id="uploadfileinput" type="file"
													name="uploadFile"></i>
											</div>
											<p class="help-block">
												<c:forEach var="mF" items="${mail.mailFileList }">
													<c:if test="${!empty mF.mChangeName}">
<!-- 														<p>첨부된 파일이 있습니다.</p> -->
														<div>첨부 파일 : ${mF.mOriginalName }        <span>X</span></div>
													</c:if>
													<c:if test="${empty mF.mChangeName}">
														<p>첨부된 파일이 없습니다.</p>
													</c:if>
<%-- 												${mF }										 --%>
												</c:forEach>
											</p>
											<table></table>
										</div>
									</div>
									<!-- /.card-body -->
									<div class="card-footer">
										<div class="float-right">
											<button type="submit" id="tmpInsert-btn"
												class="btn btn-default">
												<i class="fas fa-pencil-alt"></i> 임시 저장
											</button>
											<button type="submit" class="btn btn-primary">
												<i class="far fa-envelope"></i> 보내기
											</button>
										</div>
										<button type="reset" class="btn btn-default">
											<i class="fas fa-times"></i> 취소
										</button>
									</div>
								</form>
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
	<!-- Summernote -->
	<script
		src="${contextPath}/resources/plugins/summernote/summernote-bs4.min.js"></script>
	<script
		src="${contextPath}/resources/plugins/summernote/lang/summernote-ko-KR.js"></script>
	<!-- AdminLTE for demo purposes -->
	<script src="${contextPath}/resources/dist/js/demo.js"></script>
	<!-- Page specific script -->
	<script>
		$(function() {
			//Add text editor
			$('#compose-textarea').summernote({
				lang : "ko-KR",
				height : 550,
			});
		});

	</script>
</body>
</html>
