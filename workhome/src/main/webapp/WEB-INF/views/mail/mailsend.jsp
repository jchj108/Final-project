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

/* 자동완성 */
.ui-autocomplete {
	max-height: 350px;
	overflow-y: auto;
	/* prevent horizontal scrollbar */
	overflow-x: hidden; -->
	border: 10px solid black;
}

.ui-autocomplete {
	position: absolute;
	top: 100%;
	left: 0;
	z-index: 1000;
	float: left;
	display: none;
	padding: 0;
	margin: 0;
	list-style: none;
	background-color: #ffffff;
	border-color: #ccc;
	border-color: rgba(0, 0, 0, 0.2);
	border-style: solid;
	border-width: 10px;
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	border-radius: 5px;
	-webkit-box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
	-moz-box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
	box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
	-webkit-background-clip: padding-box;
	-moz-background-clip: padding;
	background-clip: padding-box;
	*border-right-width: 2px;
	*border-bottom-width: 2px;
}

.ui-menu-item > a.ui-corner-all {
    display: block;
    clear: both;
    font-weight: normal;
    line-height: 18px;
    color: #555555;
    white-space: nowrap;
    text-decoration: none;
}


.ui-state-hover, .ui-state-active {
    color: #ffffff;
    text-decoration: none;
    border-radius: 0px;
    -webkit-border-radius: 0px;
    -moz-border-radius: 0px;
    background-image: none;
}

.ui-widget.ui-widget-content {
    border: 2px solid #c5c5c5;
    border-radius: 4px;
    width: 433px; !important;
}

.ui-menu-item .ui-menu-item-wrapper.ui-state-active {
	border: 2px solid #007BFF !important; 
    background: #007BFF !important;
    font-weight: bold !important;
    color: #ffffff !important;
} 
/* 자동완성 끝 */


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
						<jsp:include page="mailsidemenu.jsp"></jsp:include>

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
											name="senderMailId" /> <input type="hidden"
											value="${loginUser.empName}" name=senderName />
										<div class="mailsubtitle-flex-container">
											<div class="mailsubtitle-left">
												<b>받는 사람</b>
											</div>
											<div>
												<button type="button" class="btn btn-sm btn-primary"
													style="background-color: #007BFF" id="chart">조직도</button>
											</div>
											<div class="form-group mailsubtitle-right">
												<input type="email" id="email"
													class="form-control mail-subtitle" placeholder="받는 이"
													name="receiveEmp">
											</div>
										</div>
										<div class="mailsubtitle-flex-container">
											<div class="mailsubtitle-left">
												<b>제목</b>
											</div>
											<div class="form-group mailsubtitle-right">
												<input class="form-control" placeholder="제목" name="etitle"
													id="title">
											</div>
										</div>
										<div class="form-group">
											<textarea id="compose-textarea"
												class="form-control mail-subtitle" name="econtent">
					                 	   </textarea>
										</div>
										<div class="form-group">
											<div class="btn btn-default btn-file">
												<i class="fas fa-paperclip"> 파일 첨부 <input
													multiple="multiple" id="uploadfileinput" type="file"
													name="uploadFile"></i>
											</div>
										</div>
										<!-- 										<p class="help-block">Max. 32MB</p> -->
									</div>
								</form>
								<!-- /.card-body -->
								<div class="card-footer">
									<div class="float-right">
										<button type="button" id="tmpInsert-btn"
											class="btn btn-default">
											<i class="fas fa-pencil-alt"></i> 임시 저장
										</button>
										<button type="button" id="sendMail-btn"
											class="btn btn-primary">
											<i class="far fa-envelope"></i> 보내기
										</button>
									</div>
									<button onclick="location.href='javascript:history.back();'" type="reset" class="btn btn-default">
										<i class="fas fa-times"></i> 취소
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
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
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
			// 썸머노트 렌더링
			$('#compose-textarea').summernote({
				lang : "ko-KR",
				height : 550,
			});
			
			var empEmail;
			// 자동완성
            $("#email").autocomplete({
                source : function( request, response ) {
                     $.ajax({
                            url: 'searchemp.mail',
                            dataType: "json",
                            data: {keyword: $('#email').val()},
                            success: function(data) {
                                //서버에서 json 데이터 response 후 목록에 추가
                                console.log(data)
                                response(
                                    $.map(data, function(item) {    //json[i] 번째 에 있는게 item .
                                        return {
                                            value: item.empName +" (" + item.empPosition +")",    //UI 에서 보여지는 글자, 실제 검색어랑 비교 대상
<%-- 											gNo: "<%= request.getContextPath() %>/detail.do?gNo=" + item.G_NO --%>
											test: item.empNo + "@workhome.com"
                                        }
                                    })
                                );
                            }
                       });
                    },    // source 는 자동 완성 대상
                select : function(event, ui) {    //아이템 선택시
					console.log(ui.item.test);
                	console.log($('#email').val());
                	empEmail = ui.item.test;
                    
                },
                focus : function(event, ui) {    
                    return false;//한글 에러 잡기용도로 사용됨
                },
                minLength: 1,// 최소 글자수
                autoFocus: true, //첫번째 항목 자동 포커스 기본값 false
                classes: {    
                    "ui-autocomplete": "highlight"
                },
                close : function(event){    //자동완성창 닫아질때 호출
                	$('#email').val(empEmail);

                    console.log(event);
                }
            }).autocomplete( "instance" )._renderItem = function( ul, item ) {    // UI를 마음대로 변경하는 부분
                  return $( "<li>" )    //기본 tag가 li로 되어 있음 
                  .append("<div>" + item.value + "</div>")    //여기에다가 원하는 모양의 HTML을 만들면 UI가 원하는 모양으로 변함.
                  .appendTo( ul );
           }
		});

		$('#tmpInsert-btn').on("click", function() {
			$('#form-mailsend').attr("action", "tmpInsert.mail").submit();
		});

		$('#sendMail-btn').on("click", function() {
			if (validate() != false) {
				$('#form-mailsend').attr("action", "mailInsert.mail").submit();
			}
		});

		function validate() {
			var email = document.getElementById('email').value;
			var title = document.getElementById('title').value;
			var content = document.getElementById('compose-textarea').value;

			var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

			if (email == '' || email.length == 0) {
				alert('이메일을 입력해주세요.');
				document.getElementById('email').focus();
				return false;
			} else if (title == '' || title.length == 0) {
				alert('제목을 입력해주세요.');
				document.getElementById('title').focus();
				return false;
			} else if (content == '' || content.length == 0) {
				alert('내용을 입력해주세요.')
				document.getElementById('compose-textarea').focus();
				return false;
			} else if (!regExp.test(email)) {
				alert('올바른 이메일 주소를 입력해주세요.')
				document.getElementById('email').focus();
				return false;
			}
		}
	</script>
</body>
</html>
