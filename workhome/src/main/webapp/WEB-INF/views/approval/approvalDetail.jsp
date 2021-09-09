<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
		<div class="container-fluid">
			<!-- 타이틀 영역 -->
			<div class="d-sm-flex align-items-center justify-content-between mb-4">
				<h1 class="h3 mb-0 text-gray-800">결재문서</h1>
			</div>
			 <div class="card shadow" style="margin-bottom: 5rem;">
				  <div class="card-body">
					 <h3 style="margin-bottom: 25px;">${ap.apTitle}( ${ap.apNo} )</h3>
					   <div class="form-group">
						   <strong>기안자 : </strong><input type="text" class="form-control" value="${ap.empNo}" readonly>
					   </div>
					   <div class="row">
						   <div class="form-group col-lg-6">
						   		<c:set var="str01" value="${ap.hEmp}"/>
								<c:set var="str02" value="${fn:replace(str01, '-N', '-미결')}" />
								<c:set var="str03" value="${fn:replace(str02, '-R', '-거부')}" />
								<c:set var="str04" value="${fn:replace(str03, 'Y', '-합의')}" />
						    	<strong>합의자 : </strong><input type="text" class="form-control" value="${str04}" readonly>
						   </div>
						   <div class="form-group col-lg-6">
						   		<c:set var="str1" value="${ap.approvalEmp}"/>
								<c:set var="str2" value="${fn:replace(str1, '-N', '-미결')}" />
								<c:set var="str3" value="${fn:replace(str2, '-R', '-반려')}" />
								<c:set var="str4" value="${fn:replace(str3, '-Y', '-승인완료')}" />
						    	<strong>결재자 : </strong><input type="text" class="form-control" value="${str4}" readonly>
						   </div>
						    <div class="form-group col-lg-6">
						    	<strong>참조자 : </strong><input type="text" class="form-control" value="${ap.refEmp}" readonly>
					    	</div>
					    </div>
				   		<c:if test="${empty ap.a_v_first}">
					   	<div class="form-group">
					   		<strong>마감일 : </strong> <input type="date" class="form-control" value="${ap.dDate}" readonly>
					   </div>
				   		</c:if>
				   		<c:if test="${!empty ap.a_v_first }">
							<div class="row">
					   			<div class="form-group col-lg-6">
					   				<strong>휴가시작일 : </strong> <input type="date" value="${ap.a_v_first }" class="form-control" name="a_v_first" readonly>
					   			</div>
					   			<div class="form-group col-lg-6">
					   				<strong>휴가종료일: </strong> <input type="date" value="${ap.a_v_last }" class="form-control" name="a_v_last" readonly>
					   			</div>
					   		</div>
				   		</c:if>
					    <div class="form-group" style="border: 1px solid lightgray; border-radius:.5rem; padding: 2rem;min-height: 20rem;">
					    	${ap.apContent}
						 </div>
						 	<c:if test="${!empty ap.originalFile }">
						 	첨부파일 : 
						 	</c:if>
						 	<a href="${ contextPath }/resources/buploadFiles/${ ap.renameFile }" download="${ ap.originalFile }">${ ap.originalFile }</a>
							<!-- a태그 안에서 다운로드 받을 것이 있을 때 쓰는 속성 download, 얘는 download="fileName" 이라고 해서 fileName을 지정해줄 수 있다. -->
						  
					  <div class="row">
						  <div id="buttons">
						  	  <c:set var="tag" value="${tag}"/>
						  	  <!--결재 할 문서일때  -->
						  	 <c:set var="empNo" value="${loginUser.empNo}"/>
							  <c:if test="${tag eq 'g'}">
							  	 <c:set var="approvalEmp" value="${ap.approvalEmp}"/>
							  	 <c:if test="${fn:contains(approvalEmp, empNo)}">
								 	 <button type="button" id="agreeFun" class="btn btn-success">결재</button>
								 	 <button type="button" id="disareeFun" class="btn btn-danger">반려</button>
							  	 </c:if>
							  	 <c:set var="hEmp" value="${ap.hEmp}" />
							  	 <c:if test="${fn:contains(hEmp,empNo)}">
								 	 <button type="button" id="yesFun" class="btn btn-success">합의</button>
								 	 <button type="button" id="nopeFun" class="btn btn-danger">거절</button>
							  	 </c:if>
							 </c:if>
							  <c:set var="gEmp" value="${ap.empNo}"/>
							  <c:if test="${fn:contains(gEmp,empNo)}">
								 	<button id="deleteBtn" class="btn btn-danger">삭제하기</button>
							 </c:if>
							  <button type="button" onclick="javascript:location.href='approvalView.ap';" class="btn btn-secondary">목록으로</button>
						  </div>
					  </div>	
					</div>
				</div>
				<script type="text/javascript">
					$(document).on('click','#agreeFun',function(){
						if(confirm("'${ap.apTitle}'를 정말로 결재 하시겠습니까?")){
							var cate = "g";
							var agree = "Y";
							updateApFun(cate,agree);
						}
					});
					
					$(document).on('click','#disareeFun',function(){
						if(confirm("'${ap.apTitle}'를 정말로 반려 하시겠습니까?")){
							var cate = "g";
							var agree = "R";
							updateApFun(cate,agree);
						}
					});
					
					$(document).on('click','#yesFun',function(){
						if(confirm("'${ap.apTitle}'를 정말로 합의 하시겠습니까?")){
							var cate = "h";
							var agree = "Y";
							updateApFun(cate,agree);
						}
					});
					
					$(document).on('click','#nopeFun',function(){
						if(confirm("'${ap.apTitle}'를 정말로 거절 하시겠습니까?")){
							var cate = "h";
							var agree = "R";
							updateApFun(cate,agree);
						}
					});
					
					function updateApFun(cate,agree){
						var loginUser = "${empNo}";
						var apNo = "${ap.apNo}";
						var status="";
						var plusStatus="";
						
						if(cate=='g'){
							status= "${ap.approvalEmp}";
							plusStatus= "${ap.hEmp}";
						} else if(cate=='h'){
							status= "${ap.hEmp}";
							plusStatus= "${ap.approvalEmp}";
						}
						$.ajax({
							url:"updateAp.ap",
							data:{apNo:apNo,cate:cate,agree:agree,loginUser:loginUser,status:status,plusStatus:plusStatus},
							type:"POST",
							success:function(data){
								if(data=="success"){
									alert("요청하신 결재가 완료되었습니다.\n결재 목록으로 이동합니다.");
									location.href="approvalView.ap";
								}else{
									alert("결재에 실패하였습니다.\n관라자에게 문의해주세요");
								}
							}
						});
					}
					
					$(document).on('click','#deleteBtn',function(){
						if(confirm("'${ap.apTitle}'를 정말로 삭제 하시겠습니까?\n 삭제 후 재조회는 불가능합니다.")){
							var apNo = "${ap.apNo}";
							$.ajax({
								url:"deleteAp.ap",
								data:{apNo:apNo},
								type:"post",
								success:function(data){
									if(data=="success"){
										alert("결재서류 삭제에 성공하였습니다.\n결재 목록으로 이동합니다.");
										location.href="approvalView.ap";
									}else{
										alert("삭제에 실패하였습니다.\n관라자에게 문의해주세요");
									}
								}
							});
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
