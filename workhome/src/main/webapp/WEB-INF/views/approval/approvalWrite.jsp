<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>AdminLTE 3 | Dashboard 3</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
 <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome Icons -->
  <link rel="stylesheet" href="resources/plugins/fontawesome-free/css/all.min.css">
  <!-- IonIcons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="resources/dist/css/adminlte.min.css">
  <!-- summernote -->
  <link rel="stylesheet" href="resources/plugins/summernote/summernote-bs4.min.css">
</head> 
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
	<section class="content">
		<!-- 컨텐츠 영역 -->
		<div class="container-fluid">
			<!-- 타이틀 영역 -->
			  <div class="card shadow" style="margin-bottom: 5rem;">
				  <div class="card-body">
				  	<form action="insertApproval.ap" method="post" enctype="Multipart/form-data" id="form">
					  <h3 style="margin-bottom: 25px;">결재 서류</h3>
					   <div class="form-group">
						   <strong>기안자 : </strong><input type="text" class="form-control" value="(${loginUser.empNo}) ${loginUser.empName}" name="empNo" readonly>
					   </div>
					   <div class="row">
						   <div class="form-group col-lg-6">
						    	<strong>합의자 : </strong><input type="text" class="form-control" value="${hEmp}" name="hEmp" readonly>
						   </div>
						   <div class="form-group col-lg-6">
						    	<strong>결재자 : </strong><input type="text" class="form-control" value="${gEmp}" name="approvalEmp" readonly>
						   </div>
						    <div class="form-group col-lg-6">
						    	<strong>참조자 : </strong><input type="text" class="form-control" value="${cEmp}" name="refEmp" readonly>
					    </div>
					    </div>
					  <div class="form-group">
					    	<input type="text" class="form-control" name="apTitle" placeholder="제목을 입력해주세요" autocomplete="off" required>
					   	</div>
					   	<c:if test="${empty tag}">
						   	<div class="form-group">
						   		<strong>마감일 : </strong> <input type="date" id="dDate" class="form-control" name="dDate" max="9999-12-31">
						   </div>
					   </c:if>
					   	<c:if test="${tag eq 'T'}">
					   		<div class="row">
					   			<div class="form-group col-lg-6">
					   				<strong>휴가시작일 : </strong> <input type="date" class="form-control" name="a_v_first" max="9999-12-31">
					   			</div>
					   			<div class="form-group col-lg-6">
					   				<strong>휴가종료일: </strong> <input type="date" class="form-control" name="a_v_last" max="9999-12-31">
					   			</div>
					   		</div>
					   </c:if>
					    <div class="form-group">
						    <textarea class="form-control" id="summernote" name="apContent" maxlength="140" rows="7"  autocomplete="off"></textarea>
						 </div>
						 	<input type="file" name="uploadFile">
						  
					  <div class="row">
						  <div id="buttons">
							  <button type="button" id="submitBtn" class="btn btn-primary">전송</button>
							  <button type="button" onclick="location.href='approvalView.ap'" class="btn btn-danger">취소</button>
						  </div>
					  </div>
					 </form>
				 </div>
				</div>

			<script>
			$(function(){
				var today = new Date();
				$("#dDate").val(today.toISOString().slice(0, 10));
			});
			
			$(function(){
			      $('#summernote').summernote({
			    	  toolbar: [
			    		    ['style', ['bold', 'italic', 'underline', 'clear']],
			    		    ['font', ['strikethrough']],
			    		    ['fontsize', ['fontsize']],
			    		    ['color', ['color']],
			    		    ['para', ['ul', 'ol', 'paragraph']],
			    		    ['height', ['height']],
			    		    ['Insert',['picture','link','video','table']],
			    		    ['Misc',['codeview']]
			    		  ],
			    	disableDragAndDrop: true,
			    	placeholder: '내용을 입력해주세요',
			        height: 500,
			        minHeight: 500,
			        focus: true,
			        callbacks: {
			        	onImageUpload: function(files, editor, welEditable) {
				            for (var i = files.length - 1; i >= 0; i--) {
				            	sendFile(files[i], this);
				            }
				        }
	               }
			      });
			    });
				
				function sendFile(file,el) {
					var form_data = new FormData();
			      	form_data.append('file', file);
			      	$.ajax({
			        	data: form_data,
			        	type: "POST",
			        	url: 'saveFile.ap',
			        	cache: false,
			        	contentType: false,
			        	enctype: 'multipart/form-data',
			        	processData: false,
			        	success: function(data) {
			        		var renameFile ="${ contextPath }/resources/buploadFiles/" + data;
			        		$("#summernote").summernote('insertImage', renameFile);

			        	}
			      	});
			    }
				
				$(document).on('click','#submitBtn',function(){
					if(confirm("정말로 제출하시겠습니까?\n기안 후엔 수정이 불가능합니다.")){
						$("#form").submit();
					}					
				});
				</script>
		</div>
	</section>	
</div>
  <!-- /메인 컨텐츠 -->
  
  <!-- footer -->
  <jsp:include page="../common/footer.jsp"></jsp:include>
  <!-- /footer -->
  
</div>
<!-- ./wrapper -->

<!-- REQUIRED SCRIPTS -->

<!-- jQuery -->
<script src="resources/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE -->
<script src="resources/dist/js/adminlte.js"></script>
<!-- Summernote -->
<script src="resources/plugins/summernote/summernote-bs4.min.js"></script>

<!-- Page specific script -->
<script>
  $(function () {
    // Summernote
    $('#summernote').summernote();

  });
</script>
<!-- OPTIONAL SCRIPTS -->
<script src="resources/plugins/chart.js/Chart.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="resources/dist/js/demo.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="resources/dist/js/pages/dashboard3.js"></script>
</body>
</html>
