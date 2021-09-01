<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>회의 예약</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="${contextPath}/resources/plugins/fontawesome-free/css/all.min.css">

  <!-- Theme style -->
  <link rel="stylesheet" href="${contextPath}/resources/dist/css/adminlte.min.css">
  
  <!-- 자동 완성 -->
  <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
  
	<!-- Full Calendar  -->
	<link href='${contextPath}/resources/fullcalendar/core/main.css' rel='stylesheet' />
	<link href='${contextPath}/resources/fullcalendar/daygrid/main.css' rel='stylesheet' />
	<script src='${contextPath}/resources/fullcalendar/core/main.js'></script>
	<script src='${contextPath}/resources/fullcalendar/interaction/main.js'></script>
	<script src='${contextPath}/resources/fullcalendar/daygrid/main.js'></script>   
	
	<!-- 모달 -->




<style type="text/css">
	

	.selection{
		text-align: center;
		
	}
	.cards{
		display:inline-block;
	 	margin:.8rem;
	 	transition: .8s;
	 	cursor: pointer;
	}
	.cards:hover{
		background: lightblue;
		/* margin:.9rem; */
	}
	.cardsSelect{
		background: lightgray;
		border: 2px solid rgb(150,150,150);
	}

	.calssArea{
		zoom: 0.9;
		float:left;
		text-align: center; 
		border: 1px solid #5CD1E5; 
		background: #4ABFD3; 
		color:white;
		border-radius: 1rem;
		padding: 12px;
		padding-top:5px;
		padding-bottom: 5px;
		margin: 5px;
		transition: .8s;
	}
	#commit{
		/* display: none; */
		text-align: center;
		margin: auto;
	}
	.buttonArea{
		text-align: center;
		margin-top: 2rem;
	}
	.notFcards{
		display:inline-block;
	 	margin:.8rem;
	 	transition: .8s;
	 	background: rgb(20,20,50);
	 	color: rgb(255,255,255);
	}
	.fc-scroller {
   	overflow-y: hidden !important;
	}
	
	.ui-autocomplete, .ui-menu
    {
    	position : fixed;
        z-index: 1 !important;
    }

	.reserv-bar, card-primary {
		z-index: -1;
	}

	.ui-autocomplete {
		position:absolute;
		cursor:default;
		z-index:999999 !important;
	}
	
	.reserv-button{
		position:relative;
		top: 10px;
	}
	
	#calendar{
		height: 70%;
		width: 85%;
		position: relative;
		left: 80px;		
	}
	
	.dateResult{
		zoom: 1.3;
	}
	
	.fc-title{
		cursor: pointer;
	}

</style>

</head>
<body class="hold-transition sidebar-mini">


	<script type="text/javascript">
		var joinEmp ="";//참여 emp
		var date = ""; //참여일
		var SelectTime = "";//선택시간
		var mNo = "";//회의실 번호
		var savedTime="";//예약되어있는시간
	</script>

 
 <!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">WorkHome</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">확인</button>
      </div>
    </div>
  </div>
</div>




	<div class="wrapper">
		<!-- header -->
		<jsp:include page="../common/header.jsp"></jsp:include>
		<!-- /header -->


		<!-- Main Sidebar Container -->
		<jsp:include page="../common/sidebar.jsp"></jsp:include>


		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-8">
							<h1>예약 현황</h1>
						</div>
						<div class="col-sm-4"></div>
					</div>
				</div>
				<!-- /.container-fluid -->
			</section>

			<!-- Main content -->


			<section class="content">
				<div class="container-fluid">
					<div class="row">


						<div class="col-md-3">

							<div class="sticky-top mb-3">
								<!-- 회의실 예약 바 -->
								<div class="card card-primary">
									<div class="card-header">
										<h3 class="card-title">예약 현황</h3>

										<div class="card-tools">
											<button type="button" class="btn btn-tool"
												data-card-widget="collapse" title="Collapse"
											>
												<i class="fas fa-minus"></i>
											</button>
										</div>
									</div>
									<div class="card-body">

			                			<input type="hidden" id="id">
			                			<input type="hidden" id="joinEmp_hidden">

										<div class="form-group">
											<label for="inputName">회의 제목</label>
											<input type="text" id="mTitle" class="form-control" readonly>
										</div>

										<div class="form-group">
											<label for="inputName">회의 일시</label>
											<input type="text" id="rDate" class="form-control" readonly>
										</div>

										<div class="form-group">
											<label for="inputName">회의실</label>
											<input type="text" id="mName" class="form-control" readonly>
										</div>
										
										<div class="form-group">
											<label for="inputName">신청자</label>
											<input type="text" id="empNo" class="form-control" readonly>
										</div>
										
										<div class="form-group">
											<label for="inputDescription">회의 상세 내용</label>
											<textarea id="mContent" class="form-control" rows="4" readonly></textarea>
										</div>
										
										<div class="form-group">
											<label for="inputDescription">참여자</label>
											<textarea id="joinEmp" class="form-control" rows="4" readonly></textarea>
										</div>
																				
										<div class="form-group buttonArea"></div>
										
									</div>
									<!-- /.card-body -->
								</div>
								<!-- 끝 -->

							</div>
						</div>

						<!-- /.col -->
						<div class="col-md-9">
							<div class="card card-primary">
								<div class="card-body p-0">
									<!-- THE CALENDAR -->
									<div id="calendar" class="fc fc-ltr fc-bootstrap"></div>
									<!-- /.card-body -->
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

		<jsp:include page="../common/footer.jsp"></jsp:include>

		<!-- Control Sidebar -->
		<aside class="control-sidebar control-sidebar-dark">
			<!-- Control sidebar content goes here -->
		</aside>
		<!-- /.control-sidebar -->
	</div>
	<!-- ./wrapper -->

	<!-- jQuery -->
	<script src="${contextPath}/resources/plugins/jquery/jquery.min.js"></script>
	<!-- Bootstrap -->
	<script src="${contextPath}/resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- jQuery UI -->
	<script src="${contextPath}/resources/plugins/jquery-ui/jquery-ui.min.js"></script>
	<!-- AdminLTE App -->
	<script src="${contextPath}/resources/dist/js/adminlte.min.js"></script>
	
	<!-- AdminLTE for demo purposes -->
	<script src="${contextPath}/resources/dist/js/demo.js"></script>
	<!-- Page specific script -->

  <!--자동완성  -->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
                





	<!-- 캘린더로 날짜 선택 후 예약 내역 불러오기 -->
	<script>
  	 document.addEventListener('DOMContentLoaded', function() {
    		var today = new Date();
    	  var calendarEl = document.getElementById('calendar');
        	var calendar = new FullCalendar.Calendar(calendarEl, {
		        plugins: [ 'interaction', 'dayGrid' ],
		        defaultDate: today,
		        editable: false,
		        views: {
		            dayGrid: {
		               eventLimit: 3
		            }
		         },
		        eventLimit: true,// allow "more" link when too many events
		        dateClick: function(info) {
		            /* alert('Clicked on: ' + info.dateStr); */
		          },
	          eventClick: function(info) {
//	        	 	 $(".hidearea").hide();
//	        	  	$(".hidearea").fadeIn(1000);
					var id = info.event.id;
					var temp = id.split(";");
					var rDate = temp[0];
					var rTime = temp[1];
					var mNo = temp[2];
					
					var input_mTitle = "";
					var input_rDate ="날짜 : " + rDate+ " " + "/ 시간 : "+rTime+"시";
					var input_mName ="";
					var input_empNo="";
					var input_mContent="";
					var input_joinEmp="";
					
					<c:forEach var="i" items="${mine}">
						var temp = "${i.rDate}";
						if(rDate==temp){
							temp="${i.rTime}"
							if(temp==rTime){
								temp="${i.mNo}"
								if(mNo==temp){
									input_mTitle = "${i.mTitle}";
			        	    		input_mName = "${i.mName}";
			        	    		input_mContent = "${i.mContent}";
			        	    		input_joinEmp = "${i.joinEmp}";
			        	    		input_empNo="${i.empNo}";
								}
							}
						}
						
					</c:forEach>
					<c:forEach var="i" items="${join}">
					var temp = "${i.rDate}";
					if(rDate==temp){
						temp="${i.rTime}"
						if(temp==rTime){
							temp="${i.mNo}"
							if(mNo==temp){
								input_mTitle = "${i.mTitle}";
		        	    		input_mName = "${i.mName}";
		        	    		input_mContent = "${i.mContent}";
		        	    		input_joinEmp = "${i.joinEmp}";
		        	    		input_empNo="${i.empNo}";
							}
						}
					}
					
				</c:forEach>
					$("#joinEmp_hidden").val(input_joinEmp);
					input_joinEmp = input_joinEmp.replace(/;/gi,"\n")
					$("#mTitle").val(input_mTitle);
					$("#rDate").val(input_rDate);
					$("#mName").val(input_mName);
					$("#mContent").val(input_mContent);
					$("#joinEmp").val(input_joinEmp);
					$("#empNo").val(input_empNo);
					$("#id").val(id);
	        	    
	        	    var $button = $("<button class='btn btn-primary updateBtn'>");
	        	    if(input_empNo.includes("${loginUser.empNo}")){
	        	    	$button.text("예약 취소");
	        	    }else{
	        	    	$button.text("불참 신청");
	        	    }
	        	    $(".buttonArea").html("");
	        	    $(".buttonArea").append($button);
	        	  }
		      });
         <c:forEach var ='i' items='${mine}'>
        		calendar.addEvent({'id':'${i.rDate};${i.rTime};${i.mNo}',
        							'title': '${i.mTitle}',
        							'start':'${i.rDate}',
        							'color':'#FAED7D',
        							'textColor':'black'
        							});
    		</c:forEach>
    		<c:forEach var ='i' items='${join}'>
    		calendar.addEvent({'id':'${i.rDate};${i.rTime};${i.mNo}',
    							'title': '${i.mTitle}',
    							'start':'${i.rDate}',
    							'color':'#4ABFD3',
    							'textColor':'white'
    							});
			</c:forEach>
        	calendar.render();
        	
    	 });
    	 
	</script>


	<!-- 예약 취소 또는 불참 신청 -->
	<script type="text/javascript">
		$(document).on('click', '.updateBtn', function() {
			var text = $(this).text();
			var id = $("#id").val();
			var rStatus = "Y";
			var joinEmp = $("#joinEmp_hidden").val();
			
			console.log("id :" + id);
			console.log("joinEmp : " + joinEmp);

			if (text == "예약 취소") {
				if (confirm("'" + $("#mTitle").val() + "'를 정말로 취소하시겠습니까?")) {
					rStatus = "N";

					updateRes(id, rStatus, joinEmp);
				}
			} else if (text == "불참 신청") {
				if (confirm("'" + $("#mTitle").val() + "'에 정말로 불참하시겠습니까?")) {
					joinEmp = joinEmp.substring(0, joinEmp.length - 1);
					var myEmpno = "${loginUser.empNo}";
					var result = joinEmp.match(/;/g);
					if (result < 2) {
						 $('.modal-body').text("불가능합니다. 참여자는 1명 이상이어야 합니다.");
						 $('#exampleModal').modal('show');	
						return;
					}
					var temp = joinEmp.split(";");
					joinEmp = "";
					for ( var i in temp) {
						if (!temp[i].includes(myEmpno)) {
							joinEmp += temp[i] + ";";
						}
					}
					updateRes(id, rStatus, joinEmp);
				}
			}
		});

		function updateRes(id, rStatus, joinEmp) {
			$.ajax({
				url : "rCancle.meet",
				data : {
					id : id,
					rStatus : rStatus,
					joinEmp : joinEmp
				},
				type : "post",
				success : function(data) {
						
					var time = 3;
						
					if(!time == '0') {
							
						setInterval(function() {
							 $('.modal-body').text("성공적으로 취소하였습니다. (" + time + "초 후 자동으로 닫힙니다.)");
							 $('#exampleModal').modal('show');
								 
							 time--;
							 console.log(time);
								 
							 if(time == '0') {
								 location.href = "rList.meet";
							 }											 
						}, 1000);
							
					} else{
						location.href = "rList.meet";										
					}						 
					 
				}
			});
		}
	</script>

</body>
</html>