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
	
	.first-area{
		margin-bottom: 5rem;
		margin-left: auto;
		margin-right: auto;
		transition: .8s;
		margin-top: 5rem;
	}
	
	#calendarWrapper{
	display: none;
	}
	
	.secondArea, .ThirdArea{
		display: none;
	}
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
	.fc-day:hover{
		background: lightblue;
	}
	#joinEmp{
		display:inline-block;
		border: none;
		margin: 5px;
		padding: 5px;
		clear: both;
		width: 30%;		
	}
	#joinEmp:focus{
	outline: none;
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
		margin-bottom: 2rem;
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
            <h1>회의실 예약</h1>
          </div>
          <div class="col-sm-4">
           <div class="form-group">
                        <select class="form-control">
                          <option>중앙 회의실</option>
                          <option>회의실 A</option>
                          <option>회의실 B</option>
                          <option>회의실 C</option>
                          <option>회의실 D</option>
                        </select>
            </div>
          </div>
        </div>
      </div><!-- /.container-fluid -->
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
              <h3 class="card-title">회의실 예약</h3>

              <div class="card-tools">
                <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                  <i class="fas fa-minus"></i>
                </button>
              </div>
            </div>
            <div class="card-body">



            
              <div class="form-group">
                <label for="inputName">회의실 선택</label><br>
		           <div class="form-group">
                        <select class="form-control" id="roomSelect">
                          <option value="" disabled selected hidden>회의실을 선택해 주세요</option>
                          <option value="ROOM01">중앙 회의실</option>
                          <option value="ROOM02">회의실 A</option>
                          <option value="ROOM03">회의실 B</option>
                          <option value="ROOM04">회의실 C</option>
                          <option value="ROOM05">회의실 D</option>
                        </select>
		            </div>
              </div>   
            
              <div class="form-group">
                <label for="inputName">선택 날짜</label><br>
                <span class="dateResult"></span>
              </div>   
                       
              <div class="form-group">
                <label for="inputName">예약 가능 시간</label>
	            <div id="timearea" style="margin: auto; min-height: 2rem;">
	            	날짜 및 회의실을 선택해 주세요.	            		        
	            </div>
	            
	          <!-- 시간 -->
	            
              </div>
              <div class="form-group">
                <label for="inputName">회의 제목</label>
                <input type="text" id="mTitle" class="form-control" placeholder="회의 제목을 입력하세요.">
              </div>
              <div class="form-group">
                <label for="inputDescription">회의 상세 설명</label>
                <textarea id="mContent" class="form-control" rows="4" placeholder="회의  상세 설명을 입력하세요."></textarea>
              </div>
              <div class="form-group">
                <label for="inputClientCompany">총 참여 사원</label>  
                <input class="inputModal" type="text" id="joinEmp" placeholder="참가인 추가">  
                	<div class="extraArea">	</div>

                     <button type="button" class="btn btn-block btn-primary reserv-button" id="commit">예약하기</button>
                   
              </div>
            </div>
            <!-- /.card-body -->
          </div>          
          <!-- 끝 -->  
 

          
                
              <div class="card" style="display:none;">
                <div class="card-header">
                  <h4 class="card-title">Draggable Events</h4>
                </div>
                <div class="card-body">
                  <!-- the events -->
                  <div id="external-events">
                    <div class="external-event bg-success">회의 A</div>
                    <div class="external-event bg-warning">회의 B</div>
                    <div class="checkbox">
                      <label for="drop-remove">
                        <input type="checkbox" id="drop-remove">
                        remove after drop
                      </label>
                    </div>
                  </div>
                </div>
                <!-- /.card-body -->
              </div>
              <!-- /.card -->
              <div class="card" style="display:none;">
                <div class="card-header">
                  <h3 class="card-title">Create Event</h3>
                </div>
                <div class="card-body">
                  <div class="btn-group" style="width: 100%; margin-bottom: 10px;">
                    <ul class="fc-color-picker" id="color-chooser">
                      <li><a class="text-primary" href="#"><i class="fas fa-square"></i></a></li>
                      <li><a class="text-warning" href="#"><i class="fas fa-square"></i></a></li>
                      <li><a class="text-success" href="#"><i class="fas fa-square"></i></a></li>
                      <li><a class="text-danger" href="#"><i class="fas fa-square"></i></a></li>
                      <li><a class="text-muted" href="#"><i class="fas fa-square"></i></a></li>
                    </ul>
                  </div>
                  <!-- /btn-group -->
                  <div class="input-group">
                    <input id="new-event" type="text" class="form-control" placeholder="회의 제목 입력">               
                    <div class="input-group-append">
                      <button id="add-new-event" type="button" class="btn btn-primary">Add</button>
                    </div>
                    <!-- /btn-group -->
                    
                  </div>
                  <!-- /input-group -->
                </div>
              </div>
            </div>
          </div>
       
          <!-- /.col -->
          <div class="col-md-9">         
            <div class="card card-primary">
              <div class="card-body p-0">
                <!-- THE CALENDAR -->
                <div id="calendar" class="fc fc-ltr fc-bootstrap">                     
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
          </div>
          <!-- /.col -->
        </div>
        <!-- /.row -->
      </div><!-- /.container-fluid -->
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
                




<!-- 회의실 선택 -->
			           		<script type="text/javascript">
			           			$(document).ready(function(){
					           		$("#roomSelect").val("");
			           			});
	
			           			$("#roomSelect").change(function() {
			           				   mNo = $("#roomSelect option:selected").val();
							           $(".fc-today-button").trigger('click');
										
							           console.log("mNo : " + mNo);
							           
							           if(date!=""){
							        	   rSelectDateFun(date);
							           }
									});
			           		</script>

        
<!-- 캘린더로 날짜 선택 -->

<script>

	  document.addEventListener('DOMContentLoaded', function() {
		    var calendarEl = document.getElementById('calendar');
		 		var today = new Date();
		 		var firstDayOfMonth = new Date( today.getFullYear(), today.getMonth() , 1 );
		 		var lastMonth = new Date ( firstDayOfMonth.setDate( firstDayOfMonth.getDate() - 1 ) );
 			 var yesterDate = today.getTime() - (1 * 24 * 60 * 60 * 1000);
			
 			 console.log("firstDayOfMonth" + firstDayOfMonth);
 			 console.log("lastMonth" + lastMonth);
 			 console.log("today" + today);
 			 
		    var calendar = new FullCalendar.Calendar(calendarEl, {
		        plugins: [ 'interaction', 'dayGrid' ],
		        defaultDate: today,
		        editable: false,
		        eventLimit: true,
		        dateClick: function(info) {
		            /* alert('Clicked on: ' + info.dateStr); */
		            //날짜 받아옴!
					if(yesterDate > info.date){
//						alert("이미 지난 날짜는 선택할 수 없습니다.");
						 $('.modal-body').text("이미 지난 날짜는 선택 불가능합니다.");
						 $('#exampleModal').modal('show');
					}else{			             
			            date=info.dateStr;
			            $(".secondArea").fadeIn(1000);
			            $(".fc-day").css('background','none');
			            info.dayEl.style.backgroundColor = '#B2EBF4';
//			            console.log(info.dateStr);
			            $(".dateResult").text(info.dateStr);
			            rSelectDateFun(date);
					}
		          }
		      });

		      calendar.render();
		    });
</script>       


<!-- 시간 선택 -->

<script>

/*	$(document).on('click', ".time-button", function() {
		if($(this).hasClass("btn-default") === true) {
			$(this).attr("class", "btn btn-primary btn-sm");
		}
		if($(this).hasClass("btn-primary") === true) {
			$(this).attr("class", "btn btn-default btn-sm");
		}
	});
*/

</script>


<script>
	function rSelectDateFun(date){
		$.ajax({
			url:"rSelectDate.meet",
			data:{date:date, mNo:mNo},
			dataType:"json",
			success:function(data) {
				savedTime = data;
				
				console.log(savedTime);
				
				var $timearea = $("#timearea");
				$timearea.html("");
				for(var i = 10 ; i < 19 ; i++) {
					if(savedTime.includes(i)) {
						console.log("if문 진입 : 포함된 시간이 있다");
						var $div1 = $('<button type="button" class="btn btn-danger btn-sm closed-time" style="margin:3px;">'); // 빨간 카드
					} else {
						console.log("if문 진입 X : 포함된 시간이 없다");
						var $div1 = $('<button type="button" class="btn btn-default btn-sm open-time" style="margin:3px;">'); // default 카드
					}
					var $span = $('<span class="time">').text(i);
					var $span2 = $('<span>').text("시");
					
					$div1.append($span);
					$timearea.append($div1);
				}
			}
		});
	}

</script>




<!-- 참가인 추가 -->

	<script type="text/javascript">
		$(document).on('keyup','#joinEmp',function(){
				var search = $(this).val();
				$.ajax({
				url:"searchEmpList.meet",
				data:{search:search},
				dataType:"json",
				success : function(data){
					var list = [];
					if(data.length > 0){
						for(var i in data){
							var inputText = decodeURIComponent(data[i].replace(/\+/g," "));
							if(!joinEmp.includes(inputText)){
								list.push(inputText);
								console.log("list : " + list);
							}
						}
						$("#joinEmp").autocomplete({
							source:list,
							select: function(event, ui) {
//								console.log(ui.item);
								/* $(this).attr('readonly',true); */
								addFun(ui.item.value);
								return false;
					        },
					        focus: function(event, ui) {
					            return false;
					        }
						});
					}
				}
			});
	});
			function addFun(value){
					var $div = $(".extraArea");
				var $span = $("<span class='calssArea'>").text(value);
				if(joinEmp.includes(value)){
					alert("이미 추가한 사원입니다.");
				}else{
					joinEmp += value+";";
					$div.append($span);
				}
				$("#joinEmp").val("");
				}
				
				$(document).on('click','.calssArea',function(){
					var text = $(this).text();
					if(confirm(text +" 사원을 정말로 삭제하시겠습니까?")){
						$(this).fadeOut(500);
						var array = joinEmp.split(";");
						joinEmp = "";
						for ( var i in array ) {
							if(array[i]==text){
								array[i]="";
							}else{
								array[i]+=";";
							}
							joinEmp+=array[i];
					      }
						joinEmp=joinEmp.substr(0,joinEmp.length-1);
						console.log(joinEmp);
					}
				});	
	</script>




<!-- 풀캘린더 -->




<!-- 예약 확인 -->
						  			<script type="text/javascript">
						  				$(document).on('click','#commit',function(){
						  					
						  					
						  					var mTitle = $("#mTitle").val();
						  					var mContent = $("#mContent").val();
						  					var date = $(".dateResult").text();
						  					var room = $("#roomSelect").val();
						  					var count = false;
						  					var empName = "${loginUser.empName}";

						  					if(mNo==""){
//						  						alert("날짜를 선택해 주세요.");
												 $('.modal-body').text("회의실을 선택해 주세요.");
												 $('#exampleModal').modal('show');
						  						return;
						  					}						  					

						  					if(date==""){
//						  						alert("날짜를 선택해 주세요.");
												 $('.modal-body').text("날짜를 선택해 주세요.");
												 $('#exampleModal').modal('show');
						  						return;
						  					}						  					
						  					
						  					if(mTitle==""){
												 $('.modal-body').text("회의 제목을 입력해 주세요.");
												 $('#exampleModal').modal('show');
						  						$("#mTitle").focus();
						  						return;
						  					}
						  					if(mContent==""){
												 $('.modal-body').text("회의 상세 설명을 입력해 주세요.");
												 $('#exampleModal').modal('show');
						  						$("#mContent").focus();
						  						return;
						  					}
						  					if(joinEmp!=""){
							  					var array = joinEmp.match(/;/g);
							  					count = array.length>=1?true:false;
						  					}
						  					if(!count){
												 $('.modal-body').text("참가인을 한 명 이상 등록해 주세요.");
												 $('#exampleModal').modal('show');
						  						$("#joinEmp").focus();
						  						return;
						  					}
//						  					if(SelectTime==""){
//						  						alert("시간을 선택해주세요!");
//						  						return;
//						  					}
						  					
//						  					SelectTime = SelectTime.substr(0,SelectTime.length-1);
						  					
						  					if(confirm("날짜 : "+date+"\n제목 : \'"+mTitle+"\n참가인 : \'"+joinEmp+"\n회의 등록인 : \'"+empName+"\'\n예약이 맞습니까?")){
						  						var rDate = date+";";
//						  						var rDate = date+";"+SelectTime;
						  						var empNo = "${loginUser.empNo}";
						  						
						  						
						  						console.log("rDate : " + rDate);
						  											  						
						  						$.ajax({
													url:"reInsert.meet",
													data:{rDate:rDate,joinEmp:joinEmp,mTitle:mTitle,mContent:mContent, empNo:empNo, mNo:mNo},
													type:"post",
													success:function(data){
														if(data=="success"){
															 $('.modal-body').text("성공적으로 예약하였습니다.");
															 $('#exampleModal').modal('show');
//															location.href="meetReserv5.meet";
														}else{
															console.log(date, mTitle, joinEmp);
															 $('.modal-body').text("예약에 실패하였습니다.");
															 $('#exampleModal').modal('show');
														}
													}
						  						});
						  					}else{
//						  						SelectTime+=",";
												 $('.modal-body').text("예약을 취소하였습니다.");
												 $('#exampleModal').modal('show');
						  					}
						  					
						  				})
						  			</script>


</body>
</html>