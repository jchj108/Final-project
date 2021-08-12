<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
							<a href="mailbox.html" class="btn btn-primary btn-block mb-3">돌아가기</a>

							<div class="card">
								<div class="card-header">
									<h3 class="card-title">폴더</h3>

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
												<i class="fas fa-inbox"></i> 받은메일함 <span
												class="badge bg-primary float-right">12</span>
										</a></li>
										<li class="nav-item"><a href="#" class="nav-link"> <i
												class="far fa-envelope"></i> 보낸메일함
										</a></li>
										<li class="nav-item"><a href="#" class="nav-link"> <i
												class="far fa-file-alt"></i> 임시보관함
										</a></li>
										<li class="nav-item"><a href="#" class="nav-link"> <i
												class="fas fa-filter"></i> 스팸메일함 <span
												class="badge bg-warning float-right">65</span>
										</a></li>
										<li class="nav-item"><a href="#" class="nav-link"> <i
												class="far fa-trash-alt"></i> 휴지통
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
										<!-- 										<div class="form-group"> -->
										<%-- 											<input class="form-control" value="받는 이 : ${loginUser.empName }"> --%>
										<!-- 										</div> -->
										<div class="form-group">
											<input class="form-control" placeholder="받는 이">
										</div>
										<div class="form-group">
											<input class="form-control" placeholder="제목">
										</div>
										<div class="form-group">
											<textarea id="compose-textarea" class="form-control"
												style="height: 300px">
					                      <h1>
																	<u>Heading Of Message</u>
																</h1>
					                      <h4>Subheading</h4>
					                      <p>But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain
					                        was born and I will give you a complete account of the system, and expound the actual teachings
					                        of the great explorer of the truth, the master-builder of human happiness. No one rejects,
					                        dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know
					                        how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again
					                        is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain,
					                        but because occasionally circumstances occur in which toil and pain can procure him some great
					                        pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise,
					                        except to obtain some advantage from it? But who has any right to find fault with a man who
					                        chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that
					                        produces no resultant pleasure? On the other hand, we denounce with righteous indignation and
					                        dislike men who are so beguiled and demoralized by the charms of pleasure of the moment, so
					                        blinded by desire, that they cannot foresee</p>
					                      <ul>
					                        <li>List item one</li>
					                        <li>List item two</li>
					                        <li>List item three</li>
					                        <li>List item four</li>
					                      </ul>
					                      <p>Thank you,</p>
					                      <p>John Doe</p>
					                    </textarea>
										</div>
										<div class="form-group">
											<div class="btn btn-default btn-file">
												<i class="fas fa-paperclip"></i> 파일 첨부 <input multiple="multiple" type="file"
													name="uploadFile">
											</div>
											<p class="help-block">Max. 32MB</p>
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
				callbacks : {
					onImageUpload : function(image) {
						uploadImage(image[0]);
						console.log("이미지");
					}
				}
			});
		});

		// 	    function uploadImage(image) {
		// 	        var data = new FormData();
		// 	        data.append("image", image);
		// 	        $.ajax({
		// 	            type: "post",
		// 	            cache: false,
		// 	            contentType:false,
		// 	            processData: false,
		// 	            dataType :'jsonp',
		// 	            url: '/cop/bbs/insertSummberNoteFile.do',
		// 	            data: data,
		// 	            success: function(data) {
		// 	//이미지 경로
		// 	                var image = $('<img>').attr('src', '/cmm/fms/getImage.do?atchFileId='+data[0].atchFileId+'&fileSn=0');
		// 	                $('#nttCn').summernote("insertNode", image[0]);
		// 	            },
		// 	            error: function(data) {
		// 	                alert('error : ' +data);
		// 	            }
		// 	        });
		// 	    }

		$('#tmpInsert-btn').on("click", function() {
			$('#form-mailsend').attr("action", "tmpInsert.mail").submit();
		});
	</script>
</body>
</html>
