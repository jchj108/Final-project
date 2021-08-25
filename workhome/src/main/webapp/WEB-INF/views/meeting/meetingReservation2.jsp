<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Calendar</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="${contextPath}/resources/plugins/fontawesome-free/css/all.min.css">
  <!-- fullCalendar -->
  <link rel="stylesheet" href="${contextPath}/resources/plugins/fullcalendar/main.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="${contextPath}/resources/dist/css/adminlte.min.css">

   <link rel=" shortcut icon" href="${contextPath}/resources/plugins/FullCalendar-Example-master/image/favicon.ico">

   <link rel="stylesheet" href="${contextPath}/resources/plugins/FullCalendar-Example-master/vendor/css/fullcalendar.min.css" />
   <link rel="stylesheet" href="${contextPath}/resources/plugins/FullCalendar-Example-master/vendor/css/bootstrap.min.css">
   <link rel="stylesheet" href='${contextPath}/resources/plugins/FullCalendar-Example-master/vendor/css/select2.min.css' />
   <link rel="stylesheet" href='${contextPath}/resources/plugins/FullCalendar-Example-master/vendor/css/bootstrap-datetimepicker.min.css' />

   <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:400,500,600">
   <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

   <link rel="stylesheet" href="${contextPath}/resources/plugins/FullCalendar-Example-master/css/main.css">

	<style>
		.ui-autocomplete { 
		    overflow-y: scroll; 
		    overflow-x: hidden;
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
                    <div class="input-group">구분별
                        <select class="filter" id="type_filter" multiple="multiple">
                            <option value="중앙회의실">중앙회의실</option>
                            <option value="회의실A">회의실A</option>
                            <option value="회의실B">회의실B</option>
                            <option value="회의실C">회의실C</option>
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
                <label for="inputName">예약 가능 시간</label>
	            <div>
	            	<button type="button" class="btn btn-danger btn-sm">09</button>
	            	<button type="button" class="btn btn-default btn-sm">10</button>
	            	<button type="button" class="btn btn-default btn-sm">11</button>
	            	<button type="button" class="btn btn-default btn-sm">12</button>
	            	<button type="button" class="btn btn-primary btn-sm">13</button>
	            	<button type="button" class="btn btn-primary btn-sm">14</button>
	            	<button type="button" class="btn btn-default btn-sm">15</button>
	            	<button type="button" class="btn btn-danger btn-sm">16</button>
	            	<button type="button" class="btn btn-danger btn-sm">17</button>
	            	<button type="button" class="btn btn-danger btn-sm">18</button>
	            </div>
              </div>
              <div class="form-group">
                <label for="inputName">회의 제목</label>
                <input type="text" id="inputName" class="form-control" placeholder="회의 제목을 입력하세요.">
              </div>
              <div class="form-group">
                <label for="inputDescription">회의 상세 설명</label>
                <textarea id="inputDescription" class="form-control" rows="4" placeholder="회의  상세 설명을 입력하세요."></textarea>
              </div>
              <div class="form-group">
                <label for="joinEmp">참여 사원</label>
                <input type="text" id="joinEmp" class="form-control" placeholder="사번 또는 사원명을 입력하세요.">
              </div>
              <div class="form-group">
                <label for="inputClientCompany">총 참여 사원</label>
                       <button type="button" class="btn btn-block bg-gradient-info btn-sm">강건강 - 영업팀</button>
                      <button type="button" class="btn btn-block bg-gradient-info btn-sm">남나눔 - 기획팀</button>
                      <button type="button" class="btn btn-block bg-gradient-info btn-sm">류라라 - 생산팀</button>
                      <br>
                      <button type="button" class="btn btn-info btn-sm">강건강 - 영업팀</button>
                      <button type="button" class="btn btn-info btn-sm">남나눔 - 기획팀</button>
                      <button type="button" class="btn btn-info btn-sm">류라라 - 생산팀</button>

                  <br><br>
                     <button type="button" class="btn btn-block btn-primary">예약하기</button>
                   
              </div>
            </div>
            <!-- /.card-body -->
          </div>          
          <!-- 끝 -->  
          
 <!-- 풀캘린더 -->
 
 
 
 
 <!-- 풀캘린더 끝 -->         
               
              <!-- /.card -->
            </div>
          </div>
          
          
          
          
          
          
          <!-- /.col -->
          <div class="col-md-9">         
            <div class="card card-primary">
              <div class="card-body p-0">
                <!-- THE CALENDAR -->

<!-- 풀캔 -->

    <div class="container">

        <!-- 일자 클릭시 메뉴오픈 -->
        <div id="contextMenu" class="dropdown clearfix">
            <ul class="dropdown-menu dropNewEvent" role="menu" aria-labelledby="dropdownMenu"
                style="display:block;position:static;margin-bottom:5px;">
                <li><a tabindex="-1" href="#">중앙 회의실</a></li>
                <li><a tabindex="-1" href="#">회의실A</a></li>
                <li><a tabindex="-1" href="#">회의실B</a></li>
                <li><a tabindex="-1" href="#">회의실C</a></li>
                <li class="divider"></li>
                <li><a tabindex="-1" href="#" data-role="close">Close</a></li>
            </ul>
        </div>

        <div id="wrapper">
            <div id="loading"></div>
            <div id="calendar"></div>
        </div>


        <!-- 일정 추가 MODAL -->
        <div class="modal fade" tabindex="-1" role="dialog" id="eventModal">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title"></h4>
                    </div>
                    <div class="modal-body">

                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-allDay">하루종일</label>
                                <input class='allDayNewEvent' id="edit-allDay" type="checkbox"></label>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-title">일정명</label>
                                <input class="inputModal" type="text" name="edit-title" id="edit-title"
                                    required="required" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-start">시작</label>
                                <input class="inputModal" type="text" name="edit-start" id="edit-start" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-end">끝</label>
                                <input class="inputModal" type="text" name="edit-end" id="edit-end" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-type">구분</label>
                                <select class="inputModal" type="text" name="edit-type" id="edit-type">
                                    <option value="중앙회의실">중앙회의실</option>
                                    <option value="회의실A">회의실A</option>
                                    <option value="회의실B">회의실B</option>
                                    <option value="회의실C">회의실C</option>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-color">색상</label>
                                <select class="inputModal" name="color" id="edit-color">
                                    <option value="#D25565" style="color:#D25565;">빨간색</option>
                                    <option value="#9775fa" style="color:#9775fa;">보라색</option>
                                    <option value="#ffa94d" style="color:#ffa94d;">주황색</option>
                                    <option value="#74c0fc" style="color:#74c0fc;">파란색</option>
                                    <option value="#f06595" style="color:#f06595;">핑크색</option>
                                    <option value="#63e6be" style="color:#63e6be;">연두색</option>
                                    <option value="#a9e34b" style="color:#a9e34b;">초록색</option>
                                    <option value="#4d638c" style="color:#4d638c;">남색</option>
                                    <option value="#495057" style="color:#495057;">검정색</option>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-desc">설명</label>
                                <textarea rows="4" cols="50" class="inputModal" name="edit-desc"
                                    id="edit-desc"></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer modalBtnContainer-addEvent">
                        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                        <button type="button" class="btn btn-primary" id="save-event">저장</button>
                    </div>
                    <div class="modal-footer modalBtnContainer-modifyEvent">
                        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                        <button type="button" class="btn btn-danger" id="deleteEvent">삭제</button>
                        <button type="button" class="btn btn-primary" id="updateEvent">저장</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->

        <div class="panel panel-default" style="display:none;">

            <div class="panel-heading">
                <h3 class="panel-title">필터</h3>
            </div>

            <div class="panel-body">

                <div class="col-lg-6">
                    <label for="calendar_view">구분별</label>
                    <div class="input-group">
                        <select class="filter" id="type_filter" multiple="multiple">
                            <option value="중앙회의실">중앙회의실</option>
                            <option value="회의실A">회의실A</option>
                            <option value="회의실B">회의실B</option>
                            <option value="회의실C">회의실C</option>
                        </select>
                    </div>
                </div>

                <div class="col-lg-6">
                    <label for="calendar_view">등록자별</label>
                    <div class="input-group">
                        <label class="checkbox-inline"><input class='filter' type="checkbox" value="정연"
                                checked>정연</label>
                        <label class="checkbox-inline"><input class='filter' type="checkbox" value="다현"
                                checked>다현</label>
                        <label class="checkbox-inline"><input class='filter' type="checkbox" value="사나"
                                checked>사나</label>
                        <label class="checkbox-inline"><input class='filter' type="checkbox" value="나연"
                                checked>나연</label>
                        <label class="checkbox-inline"><input class='filter' type="checkbox" value="지효"
                                checked>지효</label>
                    </div>
                </div>

            </div>
        </div>
        <!-- /.filter panel -->
    </div>

<!-- 풀캔 끝 -->


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
<!-- fullCalendar 2.2.5 -->
<script src="${contextPath}/resources/plugins/moment/moment.min.js"></script>
<script src="${contextPath}/resources/plugins/fullcalendar/main.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="${contextPath}/resources/dist/js/demo.js"></script>
<!-- Page specific script -->


<!-- 풀캘린더 -->

    <script src="${contextPath}/resources/plugins/FullCalendar-Example-master/vendor/js/jquery.min.js"></script>
    <script src="${contextPath}/resources/plugins/FullCalendar-Example-master/vendor/js/bootstrap.min.js"></script>
    <script src="${contextPath}/resources/plugins/FullCalendar-Example-master/vendor/js/moment.min.js"></script>
    <script src="${contextPath}/resources/plugins/FullCalendar-Example-master/vendor/js/fullcalendar.min.js"></script>
    <script src="${contextPath}/resources/plugins/FullCalendar-Example-master/vendor/js/ko.js"></script>
    <script src="${contextPath}/resources/plugins/FullCalendar-Example-master/vendor/js/select2.min.js"></script>
    <script src="${contextPath}/resources/plugins/FullCalendar-Example-master/vendor/js/bootstrap-datetimepicker.min.js"></script>
    <script src="${contextPath}/resources/plugins/FullCalendar-Example-master/js/main.js"></script>
    <script src="${contextPath}/resources/plugins/FullCalendar-Example-master/js/addEvent.js"></script>
    <script src="${contextPath}/resources/plugins/FullCalendar-Example-master/js/editEvent.js"></script>
    <script src="${contextPath}/resources/plugins/FullCalendar-Example-master/js/etcSetting.js"></script>





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
								console.log(ui.item);
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
	</script>






</body>
</html>