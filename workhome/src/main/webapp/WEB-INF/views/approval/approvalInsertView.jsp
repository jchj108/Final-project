<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome Icons -->
<link rel="stylesheet"
	href="resources/plugins/fontawesome-free/css/all.min.css">
<!-- IonIcons -->
<link rel="stylesheet"
	href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="resources/dist/css/adminlte.min.css">
<style type="text/css">
a{ cursor: pointer;}
a:link { color: gray; text-decoration: none;}
a:visited { color: gray; text-decoration: none;}
a:hover { color: gray; text-decoration: none;}

.buttons {
	display: inline-block;
	width: 80%;
	margin-left: auto;
	margin-right: auto;
}

#a, #g, #c, #s {
	display: inline-block;
	margin-left: 1em;
	margin-right: 1em;
}

.empList {
	display: inline-block;
	width: 20rem;
	height: 18rem;
	margin: 3rem;
	border: 1px solid lightgray;
	margin-left: auto;
	margin-right: auto;
	list-style-type: none;
	padding: 0;
	overflow: auto;
}

li {
	margin: 0;
	padding: 0;
	width: 100%;
}

.bgclss {
	background-color: rgb(240, 240, 240);
}
</style>
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
				<script type="text/javascript">
					var hEmp = "";
					var approvalEmp = "";
					var refEmp = "";
					var tEmp = "";
				</script>
					<br>
					<!-- 타이틀 영역 -->
					<div
						class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800" style="font-weight: bold;">기안</h1>
					</div>
					<div class="row">
						<div class="col-lg-4">
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h6 class="m-0 font-weight-bold text-primary">부서</h6>
								</div>
								<div class="card-body">
									<table class="table table-bordered" id="dataTable">
										<colgroup>
											<col width="40%">
										</colgroup>
										<thead>
											<tr>
												<th>부서</th>
												<th>팀</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="dl" items="${deptlist}">  
												<c:set var="dDeptNo" value="${dl.deptNo}" />
												<% int i = 0; %>
													<c:forEach var="tl" items="${teamlist}">
														<c:set var="tDeptNo" value="${tl.deptNo}" />
														<c:if test="${fn:startsWith(tDeptNo,dDeptNo)}">
															<c:choose>
																<c:when test="<%= i == 0 %>">
																	<tr> 
																		<td><b>${dl.deptName}</b></td>   
																		<td>
																			<a class="getEmp">
																				<input type="hidden" class="tDeptNo" value="${tDeptNo}"> ${tl.deptName}( ${tDeptNo} )
																			</a>
																		</td>
																	</tr>
																</c:when>
																<c:otherwise>
																	<tr>
																		<td></td>
																		<td>
																			<a class="getEmp">
																				<input type="hidden" class="tDeptNo" value="${tDeptNo}"> ${tl.deptName}( ${tDeptNo} )
																			</a>
																		</td>
																	</tr> 
																</c:otherwise>
															</c:choose>
															<% i++; %>
														</c:if>
													</c:forEach>
											</c:forEach>
										</tbody>
									</table>
					
                <script>
					$(document).on('click','.getEmp',function(){
						var deptNo = $(this).find(".tDeptNo").val();
						$(this).closest("tbody").children("tr").removeClass("bgclss");
						$(this).closest("tr").addClass('bgclss');
						$.ajax({
							url:'selectEmpList.emp',
							data:{deptNo:deptNo},
							dataType:'json',
							success:function(data){
								$tableBody = $('#empList tbody');
								$tableBody.html('');
								if(data==""){
									var $tr = $('<tr>');
									var $td = $('<td colspan="3">').text("사원이 존재하지 않습니다");
									
									$tr.append($td);
									$tableBody.append($tr);
								}
								
								for(var i in data){
									if(!tEmp.includes(data[i].empNo) && (data[i].empNo!="${loginUser.empNo}")){
										var $tr = $('<tr class="selectTr" style="cursor:pointer">');
										var $deptName = $('<td>').text("(" + data[i].deptNo+") "+decodeURIComponent(data[i].deptName.replace(/\+/g, " ")) );
										var $empPosition = $('<td>').text("lv." + data[i].empPosition);
										var $empName =$('<td>').text("("+data[i].empNo+") "+decodeURIComponent(data[i].empName.replace(/\+/g, " ")));
										
										var $input1 =$('<input class="empNo" type="hidden">').val("("+data[i].empNo+") "+decodeURIComponent(data[i].empName.replace(/\+/g, " ")));
										var $input2 =$('<input class="deptName" type="hidden">').val("(" + data[i].deptNo+") "+decodeURIComponent(data[i].deptName.replace(/\+/g, " ")) );
										var $input3 =$('<input class="empPosition" type="hidden">').val("lv." + data[i].empPosition);
										
										
										$empName.append($input1);
										$empName.append($input2);
										$empName.append($input3);
										$tr.append($deptName);
										$tr.append($empPosition);
										$tr.append($empName);
										
										$tableBody.append($tr);
									
									}
								}
							},
							error : function(){console.log("error")}
						});
					});
					
					$(document).on('click','.selectTr',function(){
						$(this).closest("tbody").children("tr").removeClass("bgclss");
						$(this).addClass('bgclss');
					});
                </script>
						</div>
					</div>
				</div>
				<div class="col-lg-8">
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">결재자 선택</h6>
						</div>
						<div class="card-body">
							<table class="table table-bordered" id="empList" style="text-align: center;">
								<thead>
									<tr>
										<th>부서</th>
										<th>직급</th>
										<th>이름</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td colspan="3" id="shut">참조할 부서를 클릭해주세요!</td>
									</tr>
								</tbody>
							</table>
							
							
							<br>
							<div class="row" style="text-align: center;">
								<div class="buttons">
									<a style="cursor: pointer;"  class="btn btn-secondary btn-icon-split" id="h">
					                    <span class="icon text-white-50">
					                      <i class="fa fa-arrow-down"></i>
					                    </span>
					                    <span class="text" style="color: white;">합의</span>
					                  </a>
					                  <a style="cursor: pointer;" class="btn btn-secondary btn-icon-split" id="g">
					                    <span class="icon text-white-50">
					                      <i class="fa fa-arrow-down"></i>
					                    </span>
					                    <span class="text" style="color: white;">결재</span>
					                  </a>
					                  <a style="cursor: pointer;" class="btn btn-secondary btn-icon-split" id="c">
					                    <span class="icon text-white-50">
					                      <i class="fa fa-arrow-down"></i>
					                    </span>
					                    <span class="text" style="color: white;">참조</span>
					                  </a>
				                  </div>
				                  
				                  <script type="text/javascript">
				                    //합의-list에 추가
						          	$(document).on('click','#h',function(){
						              		addList('realH','#hlist');
									});
				                  
				                	//list 클릭시 클래스 추가
				                	$(document).on('click','.realH',function(){
				                		addbgClass(this);
									});
				                  
									//list 더블클릭시 제거
									$(document).on('dblclick','.realH',function(){
										removeLi(this,hEmp);
									});
								
									//결재
									$(document).on('click','#g',function(){
										addList('realG','#glist');
									});
								 	//list 클릭시 클래스 추가
				                	$(document).on('click','.realG',function(){
				                		addbgClass(this);
									});
								 
				                	//list 더블클릭시 제거
									$(document).on('dblclick','.realG',function(){
										removeLi(this,approvalEmp);
										
									});
								
									//참조
									$(document).on('click','#c',function(){
										addList('realC','#clist');
									});
									 //list 클릭시 클래스 추가
				                	$(document).on('click','.realC',function(){
				                		addbgClass(this);
									});
								 
				                	//list 더블클릭시 제거
									$(document).on('dblclick','.realC',function(){
										removeLi(this,refEmp);
										
									});
				                	
				                	//지정 list 에 append 하는 function
				                	function addList(realClass,listId){
				                		var empNo = $("#empList").find('.bgclss').find('.empNo').val();
				                		if(empNo!= undefined){
						              		var deptName = $("#empList").find('.bgclss').find('.deptName').val();
						              		var empPosition =$("#empList").find('.bgclss').find('.empPosition').val();
						              		
						              		$("#empList").find('.bgclss').hide();
						              		$("#empList").find('.bgclss').removeClass('bgclss');
						              		
						              		
						              		$li =$('<li>').attr('class',realClass).text(empNo);
						              		$input1 = $('<input type="hidden" class="empNo">').val(empNo);
						              		$input2 = $('<input type="hidden" class="deptName">').val(deptName);
						              		$input3 = $('<input type="hidden" class="empPosition">').val(empPosition);
						              		
						              		$ul = $(listId);
											
						              		$li.append($input1);
						              		$li.append($input2);
						              		$li.append($input3);
						              		$ul.append($li);
						              		
						              		if(listId == '#hlist'){
						              			hEmp += empNo +', ';
						              		}else if(listId == '#clist'){
						              			refEmp += empNo +', ';
						              		}else if(listId == '#glist'){
						              			approvalEmp += empNo +', ';
						              		}
						              		
						              		tEmp += empNo +', ';
				                		}
				                		console.log(tEmp);
				                	}
				                	
				                	//클래스 추가하는function
				                	function addbgClass(a){
				                		$(a).closest('ul').children("li").removeClass("bgclss");
										$(a).addClass('bgclss');
				                	}
				                	
				                	//더블클릭시 제거하는 function
				                	function removeLi(a,empV){
				                		var empNo= $(a).find('.empNo').val();//이름(사번)
										var deptName = $(a).find('.deptName').val();//부서
										var empPosition = $(a).find('.empPosition').val();//직위
										
										$(a).hide();
										//전체 list 에 split으로 짤라 다시 넣을 임시 배열
										
										var array = empV.split(', ');
										empV="";
										for (i = 0; i < array.length; i++){
											if(empNo != array[i] && array[i]!=""){
												empV+=array[i]+", ";
											}
										}
										
										var class_name = $(a).attr('class');
										if(class_name.includes('realH')){
											hEmp = empV;
											console.log(hEmp);
										}else if(class_name.includes('realG')){
											approvalEmp = empV;
											console.log(approvalEmp);
										}else if(class_name.includes('realC')){
											refEmp = empV;
											console.log(refEmp);
										}
										
										array = tEmp.split(', ');
										tEmp="";
										
										for (i = 0; i < array.length; i++){
											if(empNo!=array[i] && array[i]!=" "){
												tEmp+=array[i]+", ";
											}
										}
										
										//상위 리스트에 다시 붙이기 - 만약 현재 선택된 부서와 같을때만!
										var selectDept = $("#dataTable").find('.bgclss').find('.tDeptNo').val();
										 if(deptName.indexOf(selectDept)>=0){
											$tableBody = $('#empList tbody');
											var $tr = $('<tr class="selectTr" style="cursor:pointer">');
											var $deptName = $('<td>').text(deptName);
											var $empPosition = $('<td>').text(empPosition);
											var $empName =$('<td>').text(empNo);
											
											var $input1 =$('<input class="empNo" type="hidden">').val(empNo);
											var $input2 =$('<input class="deptName" type="hidden">').val(deptName);
											var $input3 =$('<input class="empPosition" type="hidden">').val(empPosition);
											
											$empName.append($input1);
											$empName.append($input2);
											$empName.append($input3);
											$tr.append($deptName);
											$tr.append($empPosition);
											$tr.append($empName);
											
											$tableBody.append($tr);
											
										}
				                	}
				                	
				                  </script>
							</div>
							<hr style="margin-top: 2rem; margin-bottom: 2rme;">
							<div class="row">
								<ul class="empList" id="hlist" style="text-align: center;">
									<li style="margin-top:5px;margin-bottom:5px;"><h5>합의자</h5></li>
								</ul>
								<ul class="empList" id="glist" style="text-align: center;">
									<li style="margin-top:5px;margin-bottom:5px"><h5>결재자</h5></li>
								</ul>
							</div>
							<div class="row">
								<ul class="empList" id="clist" style="text-align: center;">
									<li style="margin-top:5px;margin-bottom:5px"><h5>참조자</h5></li>
								</ul>
							</div>
							<div class="row">
								<div style="display: inline-block; margin : 5rem; margin-left: auto; margin-right: auto;">
									<a onclick="nextFun();" class="btn btn-light btn-icon-split">
					                    <span class="icon text-gray-600">
					                      <i class="fas fa-arrow-right"></i>
					                    </span>
					                    <span class="text">다음으로</span>
					                  </a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div>
				<form id="hiddenform" action="nextPage.ap" method="post"></form>
			</div>
		</div>
		</section>	
	</div>
		<script>
			function nextFun(){
				if(approvalEmp!=''){
				var tag = "${tag}";
				$hiddenform =$('#hiddenform');
				$hiddenform.html('');
				var $input1 =$('<input name="hEmp" type="hidden">').val(hEmp);
				var $input2 =$('<input name="approvalEmp" type="hidden">').val(approvalEmp);
				var $input3 =$('<input name="refEmp" type="hidden">').val(refEmp);
				var $input4 =$('<input name="tag" type="hidden">').val(tag);
				
				$hiddenform.append($input1);
				$hiddenform.append($input2);
				$hiddenform.append($input3);
				$hiddenform.append($input4);
				
				$('#hiddenform').submit();
				
				}else{
					alert("결재자를 반드시 선택해야 합니다!");
				}
			}
		</script>
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

	<!-- OPTIONAL SCRIPTS -->
	<script src="resources/plugins/chart.js/Chart.min.js"></script>
	<!-- AdminLTE for demo purposes -->
	<script src="resources/dist/js/demo.js"></script>
	<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
	<script src="resources/dist/js/pages/dashboard3.js"></script>
</body>
</html>