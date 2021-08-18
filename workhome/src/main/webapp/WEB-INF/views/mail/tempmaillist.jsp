<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>AdminLTE 3 | Mailbox</title>

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
.mail-icon {
	width: 20px;
}

.table td, .table th {
	padding: .25rem;
	vertical-align: middle;
}

.table-striped tbody tr:nth-of-type(odd) {
	background-color: unset;
}

.table td:nth-child(1) {
	width: 4%;
}

.table td:nth-child(3) {
	width: 20%;
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

.fa-star, .fa-envelope {
	margin-right: 8px;
}

.mailbox-name a {
	margin-left: 20px;
	text-decoration: none;
}

td {
	height : 35px;
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
							<h1>임시보관함</h1>
						</div>
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="#">Home</a></li>
								<li class="breadcrumb-item active">Inbox</li>
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
							<a href="send.mail" class="btn btn-primary btn-block mb-3">메일
								쓰기</a>

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
								<div class="card-body p-0">
									<ul class="nav nav-pills flex-column">
										<li class="nav-item"><a href="#" class="nav-link"> <i
												class="far fa-circle text-danger"></i> 긴급
										</a></li>
										<li class="nav-item"><a href="#" class="nav-link"> <i
												class="far fa-circle text-warning"></i> 보통
										</a></li>
										<li class="nav-item"><a href="#" class="nav-link"> <i
												class="far fa-circle text-primary"></i> 낮음
										</a></li>
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
									<h3 class="card-title">받은 메일함</h3>

									<div class="card-tools">
										<div class="input-group input-group-sm">
											<input type="text" class="form-control" placeholder="메일 검색">
											<div class="input-group-append">
												<div class="btn btn-primary">
													<i class="fas fa-search"></i>
												</div>
											</div>
										</div>
									</div>
									<!-- /.card-tools -->
								</div>
								<!-- /.card-header -->
								<div class="card-body p-0">
									<div class="mailbox-controls">
										<!-- Check all button -->
										<button type="button"
											class="btn btn-default btn-sm checkbox-toggle">
											<i class="far fa-square"></i>
										</button>
										<div class="btn-group">
											<button type="button" class="btn btn-default btn-sm">
												<i class="far fa-trash-alt"></i>
											</button>
											<button type="button" class="btn btn-default btn-sm">
												<i class="fas fa-reply"></i>
											</button>
											<button type="button" class="btn btn-default btn-sm">
												<i class="fas fa-share"></i>
											</button>
										</div>
										<!-- /.btn-group -->
										<button type="button" class="btn btn-default btn-sm">
											<i class="fas fa-sync-alt"></i>
										</button>
										<div class="float-right">
											1-50/200
											<div class="btn-group">
												<button type="button" class="btn btn-default btn-sm">
													<i class="fas fa-chevron-left"></i>
												</button>
												<button type="button" class="btn btn-default btn-sm">
													<i class="fas fa-chevron-right"></i>
												</button>
											</div>
											<!-- /.btn-group -->
										</div>
										<!-- /.float-right -->
									</div>
									<div class="table-responsive mailbox-messages">
										<table class="table table-hover table-striped">
												<c:forEach var="m" items="${tempList }" varStatus="idCount">
													<c:forEach var="mF" items="${m.mailFileList}" varStatus="idCount">
														<c:if test="${mF.mStatus == 'Y'}">
															<c:set var="attachment" value="on"/>
														</c:if>
														<c:if test="${mF.mStatus != 'Y'}">
															<c:set var="attachment" value="off"/>
														</c:if>
													</c:forEach>
														<tr>
															<td>
																<div class="icheck-primary">
																	<input type="checkbox" value=""
																		id="check${idCount.count }"> <label
																		for="check${idCount.count }"></label>
																</div>
															</td>
															<td class="mailbox-star"><a href="#"><i
																	class="far fa-star text-warning"></i></a> <i
																id="readmail" class="fas fa-envelope text-primary"></i>
																<c:if test="${attachment == 'on' }">
																	<i class="fas fa-paperclip"></i>
																</c:if>
																</td>
															<td class="mailbox-name"><a href="read-mail.html">${m.senderName }</a></td>
															<td class="mailbox-subject">${m.etitle }</td>
<!-- 															<td class="mailbox-attachment"><i class="fas fa-paperclip"></i></td> -->
															<td class="mailbox-date">${m.sDate }</td>
														</tr>
												</c:forEach>
<!-- 											</tbody> -->
										</table>
										<!-- /.table -->
									</div>
									<!-- /.mail-box-messages -->
								</div>
								<!-- /.card-body -->
								<div class="card-footer p-0">
									<div class="mailbox-controls">
										<!-- Check all button -->
										<button type="button"
											class="btn btn-default btn-sm checkbox-toggle">
											<i class="far fa-square"></i>
										</button>
										<div class="btn-group">
											<button type="button" class="btn btn-default btn-sm">
												<i class="far fa-trash-alt"></i>
											</button>
											<button type="button" class="btn btn-default btn-sm">
												<i class="fas fa-reply"></i>
											</button>
											<button type="button" class="btn btn-default btn-sm">
												<i class="fas fa-share"></i>
											</button>
										</div>
										<!-- /.btn-group -->
										<button type="button" class="btn btn-default btn-sm">
											<i class="fas fa-sync-alt"></i>
										</button>
										<div class="float-right">
											1-50/200
											<div class="btn-group">
												<button type="button" class="btn btn-default btn-sm">
													<i class="fas fa-chevron-left"></i>
												</button>
												<button type="button" class="btn btn-default btn-sm">
													<i class="fas fa-chevron-right"></i>
												</button>
											</div>
											<!-- /.btn-group -->
										</div>
										<!-- /.float-right -->
									</div>
								</div>
							</div>
							<!-- /.card -->
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
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
	<!-- Page specific script -->
	<script>
		$(function() {
			//Enable check and uncheck all functionality
			$('.checkbox-toggle').click(
					function() {
						var clicks = $(this).data('clicks')
						if (clicks) {
							//Uncheck all checkboxes
							$('.mailbox-messages input[type=\'checkbox\']')
									.prop('checked', false)
							$('.checkbox-toggle .far.fa-check-square')
									.removeClass('fa-check-square').addClass(
											'fa-square')
						} else {
							//Check all checkboxes
							$('.mailbox-messages input[type=\'checkbox\']')
									.prop('checked', true)
							$('.checkbox-toggle .far.fa-square').removeClass(
									'fa-square').addClass('fa-check-square')
						}
						$(this).data('clicks', !clicks)
					})

			//Handle starring for font awesome
			$('.mailbox-star').click(function(e) {
				e.preventDefault()
				//detect type
				var $this = $(this).find('a > i')
				var fa = $this.hasClass('fa')

				//Switch states
				if (fa) {
					$this.toggleClass('fa-star')
					$this.toggleClass('fa-star-o')
				}
			});
		});
	</script>
</body>
</html>

